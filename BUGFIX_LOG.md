# BUGFIX_LOG

项目修复日志，记录本轮代码审计发现的 Bug 及修复情况。

> 审计期间: 2026-07-06

---

## 移动端 Bug 修复

| ID | 文件 | 平台 | 严重度 | 问题 | 修复 |
|----|------|------|--------|------|------|
| M1 | `AppDelegate.swift` | iOS | 🔴 高 | `as! FlutterViewController` 强制解包 | 改为 `as?` 安全解包 |
| M2 | `LoggerPlugin.swift` | iOS | 🔴 高 | channel nil 时静默失败 | 添加 guard let 保护 |
| M3 | `MainActivity.kt` | Android | 🔴 高 | `getParcelableExtra<Uri>()` API 33+ 废弃 | SDK 版本判断 + 新 API |
| M4 | `MainActivity.kt` | Android | 🔴 高 | installApk FLAG 散落 | 合并到 try 块内 |
| M5 | `Info.plist` | iOS | 🟡 中 | NSAllowsArbitraryLoads=true 完全禁用 ATS | 精确 NSExceptionDomains |
| M6 | `MainActivity.kt` | Android | 🟡 中 | Channel name 散落代码中 | 集中为 companion object |
| M7 | `MainActivity.kt` | Android | 🟡 中 | 通知 channel ID 3 处硬编码 | 统一 NOTIFICATION_CHANNEL_ID |
| MB1 | `MainActivity.kt` | Android | 🔴 高 | NotificationReceiver 绕过生命周期 | 改为 sendBroadcast |

## 第二批 (Dart 层)

| ID | 文件 | 严重度 | 问题 | 修复 |
|----|------|--------|------|------|
| B-BC7 | `transactions_sync_manager.dart` | 🔴 高 | deserialize/fingerprint 无 try/catch | 添加 jsonDecode 保护 |
| B-BC8 | `ai_chat_page.dart` | 🔴 高 | `m.metadata!` 强解包可崩 | 检查 null/空值后兜底 |
| B-BC10 | `transactions_json.dart` | 🔴 高 | parseJsonToImportData 无 try/catch | 添加 try/FormatException |
| B-BC11 | `LoggerPlugin.kt` | 🟡 中 | channel 字段无 @Volatile | 添加 @Volatile 注解 |
