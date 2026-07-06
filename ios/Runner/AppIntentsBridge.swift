import Foundation
import Flutter

/// AppIntents桥接插件
/// 使用弱链接支持iOS 15.0+，AppIntents功能仅在iOS 16+可用
@available(iOS 13.0, *)
class AppIntentsBridge: NSObject, FlutterPlugin {
    static let channelName = "com.beecount.app_intents"
    private static var eventChannel: FlutterEventChannel?
    private static var eventSink: FlutterEventSink?

    // 事件缓存队列（解决冷启动时序问题）
    private static var pendingEvents: [String] = []
    private static let maxPendingEvents = 5

    // openAppWhenRun=false 时,perform() 把事件丢给 Flutter 后必须**等 Flutter
    // 处理完**再返回。否则 iOS 认为 AppIntent 已结束,会很快 kill 进程,导致
    // 「正在识别」通知出来了但「成功」通知发不出去。
    //
    // Flutter 处理完 processScreenshot 后通过 MethodChannel 调
    // `notifyBillingComplete`,触发这里的 continuation 让 perform() 返回。
    // 使用请求级 requestId 避免并发 Shortcut 误唤醒。
    private static var pendingRequestIds: [String] = []
    private static var billingCompletionContinuations: [String: CheckedContinuation<Void, Never>] = [:]
    private static let continuationLock = NSLock()
    private static var requestCounter: UInt64 = 0

    static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(
            name: channelName,
            binaryMessenger: registrar.messenger()
        )

        let instance = AppIntentsBridge()
        registrar.addMethodCallDelegate(instance, channel: channel)

        // 创建事件通道用于发送AppIntent事件
        eventChannel = FlutterEventChannel(
            name: "\(channelName)/events",
            binaryMessenger: registrar.messenger()
        )
        eventChannel?.setStreamHandler(instance)
    }

    func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case "isSupported":
            // 检查是否支持AppIntents（iOS 16+）
            if #available(iOS 16.0, *) {
                result(true)
            } else {
                result(false)
            }
        case "notifyBillingComplete":
            // Flutter 端 processScreenshot 处理完(成功/失败/超时都算)后回调
            // 只唤醒最早等待的那个 continuation，避免并发 Shortcut 误唤醒
            AppIntentsBridge.resumeNextContinuation()
            print("[AppIntentsBridge] ✅ 收到 Flutter 处理完成信号")
            result(nil)
        default:
            result(FlutterMethodNotImplemented)
        }
    }

    /// 从AppIntent发送事件到Flutter
    /// 如果Flutter还未订阅，事件会被缓存，等待订阅后发送
    static func sendEvent(_ event: String) {
        DispatchQueue.main.async {
            if let sink = eventSink {
                // 如果已连接，立即发送
                sink(event)
                print("[AppIntentsBridge] ✅ 事件已发送: \(event)")
            } else {
                // 如果未连接，缓存事件（解决冷启动时序问题）
                pendingEvents.append(event)
                if pendingEvents.count > maxPendingEvents {
                    pendingEvents.removeFirst()
                }
                print("[AppIntentsBridge] 📦 事件已缓存（共\(pendingEvents.count)个）: \(event)")
            }
        }
    }

    /// AppIntent perform() 用这个方法等 Flutter 完成处理。
    /// 默认 25 秒超时(留 5s buffer 给 iOS 的 30s 后台窗口)。
    /// 返回 requestId 供调用方在异常路径下手动取消，避免 continuation 泄漏。
    static func waitForBillingComplete(timeout: TimeInterval = 25.0) async {
        let requestId = nextRequestId()
        await withCheckedContinuation { (continuation: CheckedContinuation<Void, Never>) in
            continuationLock.lock()
            pendingRequestIds.append(requestId)
            billingCompletionContinuations[requestId] = continuation
            continuationLock.unlock()
            print("[AppIntentsBridge] ⏳ perform() 等待 Flutter 处理完成(requestId=\(requestId), 超时 \(timeout)s)")

            // 兜底超时:如果 Flutter 卡了/挂了,iOS 30s 窗口快到时强制唤醒自己
            DispatchQueue.main.asyncAfter(deadline: .now() + timeout) {
                AppIntentsBridge.resumeContinuation(requestId: requestId)
            }
        }
    }

    /// 单调递增的请求 ID（线程安全）
    private static func nextRequestId() -> String {
        continuationLock.lock()
        defer { continuationLock.unlock() }
        requestCounter &+= 1
        return "req-\(requestCounter)"
    }

    /// 唤醒最早等待的 continuation（FIFO）。
    /// `notifyBillingComplete` 调用此方法：每次只唤醒一个，按入队顺序出队，
    /// 避免并发 Shortcut 互相误唤醒。
    private static func resumeNextContinuation() {
        continuationLock.lock()
        guard !pendingRequestIds.isEmpty else {
            continuationLock.unlock()
            return
        }
        let requestId = pendingRequestIds.removeFirst()
        let cont = billingCompletionContinuations.removeValue(forKey: requestId)
        continuationLock.unlock()

        cont?.resume()
    }

    /// 按 requestId 精确唤醒（超时兜底用）。重复调用安全(已 resume 的会被跳过)。
    private static func resumeContinuation(requestId: String) {
        continuationLock.lock()
        // 从等待队列中移除（若已出队则 removeValue 返回 nil，无副作用）
        if let idx = pendingRequestIds.firstIndex(of: requestId) {
            pendingRequestIds.remove(at: idx)
        }
        let cont = billingCompletionContinuations.removeValue(forKey: requestId)
        continuationLock.unlock()

        cont?.resume()
    }
}

// MARK: - FlutterStreamHandler
@available(iOS 13.0, *)
extension AppIntentsBridge: FlutterStreamHandler {
    func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
        AppIntentsBridge.eventSink = events

        // 发送缓存的事件（解决冷启动时序问题）
        DispatchQueue.main.async {
            for event in AppIntentsBridge.pendingEvents {
                events(event)
                print("[AppIntentsBridge] 📤 发送缓存事件: \(event)")
            }
            if !AppIntentsBridge.pendingEvents.isEmpty {
                print("[AppIntentsBridge] ✅ 已发送 \(AppIntentsBridge.pendingEvents.count) 个缓存事件")
            }
            AppIntentsBridge.pendingEvents.removeAll()
        }

        return nil
    }

    func onCancel(withArguments arguments: Any?) -> FlutterError? {
        AppIntentsBridge.eventSink = nil
        return nil
    }
}
