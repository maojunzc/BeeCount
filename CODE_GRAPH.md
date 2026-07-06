# Code Graph: BeeCount (蜜蜂记账)

> 生成时间: 2026-07-06 | 工具: ZCode CodeGraph

---

## 项目概览

| 指标 | 数值 |
|------|------|
| **项目名称** | BeeCount (蜜蜂记账) |
| **描述** | 跨平台个人/家庭记账应用 |
| **框架** | Flutter 3.x (Dart) |
| **Dart 源文件** | 450 个 |
| **Dart 代码行** | ~189,988 行 |
| **状态管理** | Riverpod (flutter_riverpod) |
| **本地数据库** | Drift (SQLite) |
| **云后端** | Supabase |
| **Android 原生** | 6 个 Kotlin 文件 |
| **iOS 原生** | 7 个 Swift 文件 |
| **测试文件** | 45 个 |
| **本地包** | 8 个 (`packages/`) |

---

## 目录结构

```
lib/
├── main.dart                    # 应用入口
├── app.dart                     # BeeApp 主组件 (1150行)
├── theme.dart                   # 主题配置
├── providers.dart               # Provider 汇总
│
├── ai/                          # AI 功能模块 (10 文件)
│   ├── core/
│   │   ├── ai_extraction_context.dart
│   │   ├── ai_extraction_engine.dart
│   │   ├── bill_info.dart
│   │   ├── json_response_parser.dart
│   │   └── prompt_builder.dart
│   ├── privacy/
│   │   └── ai_privacy_consent.dart
│   └── providers/
│       ├── ai_constants.dart
│       ├── ai_provider_config.dart
│       ├── ai_provider_factory.dart
│       └── ai_provider_manager.dart
│
├── cloud/                       # 云同步模块 (19 文件)
│   ├── sync_service.dart
│   ├── transactions_sync_manager.dart
│   └── sync/
│       ├── sync_engine.dart
│       ├── change_tracker.dart
│       ├── sync_coordinator.dart
│       ├── sync_conflict_resolver.dart
│       └── ...
│
├── data/                        # 数据层 (30 文件)
│   ├── models/
│   └── repositories/
│       ├── account_repository.dart
│       ├── transaction_repository.dart
│       ├── category_repository.dart
│       ├── budget_repository.dart
│       ├── ledger_repository.dart
│       ├── tag_repository.dart
│       ├── ... (repositories)
│       └── local/               # 本地实现
│           ├── local_account_repository.dart
│           ├── local_transaction_repository.dart
│           └── ...
│
├── l10n/                        # 本地化 (3 文件)
│   ├── app_en.arb
│   ├── app_zh.arb
│   └── app_zh_TW.arb
│
├── models/                      # 共享模型 (2 文件)
│
├── pages/                       # 页面层 (74 文件)
│   ├── account/                 # 账户管理
│   ├── ai/                      # AI 聊天/设置
│   ├── auth/                    # 登录/锁屏/欢迎
│   ├── automation/              # 自动记账
│   ├── budget/                  # 预算
│   ├── calendar/                # 日历
│   ├── category/                # 分类管理
│   ├── cloud/                   # 云同步页面
│   ├── currency/                # 汇率
│   ├── data/                    # 导入/导出
│   ├── donation/                # 捐赠
│   ├── main/                    # 主页/分析/我的
│   ├── report/                  # 年度报告
│   ├── settings/                # 设置 (19 文件)
│   ├── tag/                     # 标签管理
│   └── transaction/             # 交易编辑/搜索
│
├── providers/                   # Riverpod Provider (29 文件)
│   ├── all_providers.dart
│   ├── database_providers.dart
│   ├── theme_providers.dart
│   ├── sync_providers.dart
│   ├── security_providers.dart
│   ├── language_provider.dart
│   ├── font_scale_provider.dart
│   └── ...
│
├── services/                    # 业务服务 (58 文件)
│   ├── ai/                      # AI 记账/聊天
│   ├── automation/              # 自动记账/提醒
│   ├── billing/                 # 账单创建/解析
│   ├── currency/                # 汇率服务
│   ├── data/                    # 数据服务/分类匹配
│   ├── export/                  # 导出/分享
│   ├── import/                  # 导入/迁移
│   ├── maintenance/             # 孤立文件清理
│   ├── payment/                 # 内购
│   ├── platform/                # AppLink/锁屏
│   ├── security/                # 安全
│   ├── system/                  # 日志/UI
│   └── update/                  # OTA 更新
│
├── styles/                      # 设计系统 (14 文件)
│   ├── tokens.dart
│   └── header_skins/            # 12 种头部皮肤
│
├── utils/                       # 工具 (22 文件)
│   ├── date_helper.dart
│   ├── currency_helper.dart
│   ├── notification_factory.dart
│   └── ...
│
├── widget/                      # 遗留 widget (2 文件)
│
└── widgets/                     # 可复用 UI (62 文件)
    ├── ai/
    ├── analytics/
    ├── biz/                     # 业务 widget (27 文件)
    ├── category/
    ├── charts/
    ├── currency/
    ├── posters/                 # 年度/月度海报
    ├── transaction/
    └── ui/                      # 通用 UI 组件

packages/                        # 本地包
├── flutter_ai_kit/              # AI 能力抽象层 (13 文件)
├── flutter_ai_kit_openai/       # OpenAI 兼容 provider (14 文件)
├── flutter_ai_kit_zhipu/        # 智谱 GLM provider (2 文件)
├── flutter_cloud_sync/          # 云端同步框架 (22 文件)
├── flutter_cloud_sync_supabase/ # Supabase provider (7 文件)
├── flutter_cloud_sync_webdav/   # WebDAV provider (5 文件)
├── flutter_cloud_sync_icloud/   # iCloud provider (5 文件)
└── flutter_cloud_sync_s3/       # S3 provider (7 文件)

android/                         # Android 原生
└── app/src/main/kotlin/com/tntlikely/beecount/
    ├── MainActivity.kt          # (622 行)
    ├── NotificationReceiver.kt
    ├── NotificationClickReceiver.kt
    ├── ScreenshotObserver.kt   # (331 行)
    ├── BeeCountWidgetProvider.kt
    └── LoggerPlugin.kt

ios/                             # iOS 原生
└── Runner/
    ├── AppDelegate.swift
    ├── AppIntentsBridge.swift   # (136 行)
    ├── AutoBillingAppIntent.swift
    ├── LoggerPlugin.swift
    └── BeeCountWidget/          # iOS 桌面小组件
        ├── BeeCountWidget.swift
        └── BeeCountWidgetBundle.swift

test/                            # 测试 (45 文件)
├── ai/                          # AI 核心测试
├── cloud/sync/                  # 同步引擎测试
├── data/repositories/           # 数据仓库测试
├── providers/                   # Provider 测试
├── services/                    # 服务测试
├── utils/                       # 工具测试
└── widgets/                     # Widget 测试
```

---

## 架构模式

```
┌──────────────────────────────────────────────────────────┐
│                     UI Layer (pages/)                      │
│  Account / AI / Budget / Calendar / Cloud / Settings ...   │
└──────────┬──────────────────────────────────┬──────────────┘
           │ watch(ref)                        │ 用户交互
           ▼                                   ▼
┌──────────────────┐              ┌────────────────────────┐
│  Riverpod State   │◄────────────│    Services (services/) │
│  Providers        │              │  AI / Sync / Update     │
│  (providers/)     │              │  Export / Billing ...   │
└────────┬─────────┘              └───────────┬────────────┘
         │                                    │
         ▼                                    ▼
┌────────────────────────────────────────────────────────────┐
│                   Data Layer (data/)                        │
│  Repositories ──→ Local Repositories ──→ Drift (SQLite)     │
│  Account / Transaction / Category / Budget / Ledger / Tag   │
└────────────────────────────────────────────────────────────┘
```

---

## 关键依赖

| 包 | 版本 | 用途 |
|----|------|------|
| flutter_riverpod | ^2.5.1 | 状态管理 |
| drift | ^2.20.2 | SQLite ORM |
| supabase_flutter | ^2.5.6 | 云后端 |
| fl_chart | ^0.68.0 | 图表 |
| flutter_local_notifications | ^17.2.2 | 本地通知 |
| local_auth | ^2.3.0 | 生物识别 |
| in_app_purchase | ^3.1.0 | 内购 |
| home_widget | ^0.7.0 | 桌面小组件 |
| app_links | ^6.4.1 | 深度链接 |
| record | ^5.1.2 | 语音记账 |
| share_plus | ^12.0.1 | 分享 |
| flutter_ai_kit | (local) | AI 能力 |
| flutter_cloud_sync | (local) | 云同步 |

---

## Android 原生能力

| 功能 | 类 | 说明 |
|------|-----|------|
| 应用入口 | `MainActivity.kt` | FlutterFragmentActivity, MethodChannel 桥接 |
| 通知调度 | `NotificationReceiver.kt` | BroadcastReceiver, AlarmManager |
| 通知点击 | `NotificationClickReceiver.kt` | BroadcastReceiver |
| 截图监听 | `ScreenshotObserver.kt` | ContentObserver, MediaStore |
| 桌面小组件 | `BeeCountWidgetProvider.kt` | AppWidgetProvider |
| 日志桥接 | `LoggerPlugin.kt` | MethodChannel 日志转发 |

## iOS 原生能力

| 功能 | 文件 | 说明 |
|------|------|------|
| 应用入口 | `AppDelegate.swift` | FlutterAppDelegate, 通知代理 |
| App Intents | `AppIntentsBridge.swift` | FlutterPlugin, 事件通道 |
| 快捷指令 | `AutoBillingAppIntent.swift` | Siri 自动记账 |
| 日志桥接 | `LoggerPlugin.swift` | MethodChannel 日志转发 |
| 桌面小组件 | `BeeCountWidget.swift` | SwiftUI Widget |

---

## 测试覆盖

- **测试文件**: 45 个
- **重点测试领域**:
  - 云同步引擎 (sync change tracker, conflict resolver, e2e)
  - AI 提取引擎 (prompt builder, JSON parser)
  - 数据仓库 (exclude flags, budget stats, exchange rate)
  - 服务层 (billing creation, recurring transaction)
  - 工具函数 (date parser, currency, analytics)
