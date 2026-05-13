# Privacy Policy for BeeCount

**Last updated**: 2025-10-26

BeeCount ("we", "our", or "the app") is committed to protecting your privacy. This Privacy Policy explains how we handle your data when you use our application.

## TL;DR (Summary)

- **We do NOT collect any personal data**
- **We do NOT use any analytics or tracking**
- **Your data stays on YOUR device or YOUR server**
- **We do NOT have access to your financial records**

---

## 1. Information We Collect

**We collect ZERO user data.**

BeeCount is designed with privacy-first principles:
- No user registration required (optional cloud sync only)
- No server-side data collection
- No analytics or crash reporting services
- No advertising SDKs
- No third-party tracking

## 2. How We Store Your Data

### Local Storage
- All your accounting records are stored in a local SQLite database on your device
- Data remains on your device unless you explicitly configure cloud synchronization
- We cannot access, view, or retrieve your local data

### Cloud Storage (Optional)
If you choose to enable cloud synchronization, your data is stored in:

**Option 1: Custom Supabase Instance**
- You configure your own Supabase project
- Data is stored in YOUR Supabase account
- We do NOT have access to your Supabase credentials or data
- You control the data retention and deletion

**Option 2: WebDAV Server**
- You configure your own WebDAV server (NAS, Nextcloud, etc.)
- Data is stored on YOUR server
- We do NOT have access to your WebDAV credentials or data
- You have full control over the data

**Important**: We are NOT a cloud service provider. We do not operate any servers that store your data.

## 3. Data Sharing

We do NOT share your data with anyone because we don't have access to your data in the first place.

- No data is sent to our servers (we don't have any)
- No data is shared with third parties
- No data is used for advertising or analytics
- No data is sold to anyone

## 4. Permissions We Request

The app requests the following Android permissions:

### Storage Permission (WRITE_EXTERNAL_STORAGE / READ_EXTERNAL_STORAGE)
- **Purpose**: To import/export CSV files for data backup
- **Optional**: You can still use the app without granting this permission
- **Scope**: Only accesses files you explicitly select

### Internet Permission (INTERNET)
- **Purpose**: To sync data with your own cloud service (if configured)
- **Optional**: The app works fully offline without this permission
- **Scope**: Only connects to servers YOU configure (Supabase/WebDAV)

### Notification Permission (POST_NOTIFICATIONS)
- **Purpose**: To show app update download notifications
- **Optional**: Not required for core functionality

### Reminder Permission (SCHEDULE_EXACT_ALARM / USE_EXACT_ALARM)
- **Purpose**: To send accounting reminders at the time you set
- **Optional**: Only requested if you enable the reminder feature

## 5. Data Security

While we don't collect your data, we implement security best practices:

- Local data is stored using SQLite with Android's built-in security
- Cloud sync uses HTTPS/TLS encryption when communicating with your servers
- Authentication credentials are stored securely using Android Keystore
- The app is open source - you can audit our code: [GitHub Repository](https://github.com/maojunzc/BeeCount)

## 6. Children's Privacy

The app does not knowingly collect any information from children under 13. Since we don't collect any data at all, the app can be used by anyone.

## 7. Your Rights

You have complete control over your data:

- **Access**: All your data is in plain SQLite format, you can access it anytime
- **Portability**: Export your data to CSV format
- **Deletion**: Uninstall the app or use the built-in data clearing feature
- **No Tracking**: We don't track you, so there's nothing to opt-out from

## 8. Open Source

BeeCount is fully open source under the MIT License. You can:

- Review our entire codebase: https://github.com/maojunzc/BeeCount
- Verify that we don't collect any data
- Build the app yourself from source
- Contribute improvements

## 9. Changes to This Policy

We may update this Privacy Policy from time to time. We will notify you of any changes by:
- Posting the new Privacy Policy in the app
- Updating the "Last updated" date
- Publishing changes on our GitHub repository

## 10. Third-Party Services

The app does NOT integrate with any third-party services for analytics, advertising, or crash reporting.

If you configure cloud sync:
- **Supabase**: Subject to [Supabase Privacy Policy](https://supabase.com/privacy)
- **WebDAV**: Subject to your own server's privacy policy

These services are configured and controlled entirely by YOU.

## 11. Contact Us

If you have any questions about this Privacy Policy, please contact us:

- **Email**: 2316562571@qq.com
- **GitHub Issues**: https://github.com/maojunzc/BeeCount/issues
- **GitHub Discussions**: https://github.com/maojunzc/BeeCount/discussions

## 12. Consent

By using BeeCount, you consent to this Privacy Policy.

Since we don't collect any data, there's actually nothing to consent to - your privacy is protected by default! 🔒

---

## Privacy Policy (简体中文)

**蜜蜂记账隐私政策**

**最后更新时间**: 2025-10-26

### 简要说明

- **我们不收集任何个人数据**
- **我们不使用任何分析或追踪服务**
- **您的数据保存在您的设备或您的服务器上**
- **我们无法访问您的财务记录**

### 1. 信息收集

**我们收集零用户数据。**

蜜蜂记账采用隐私优先原则设计：
- 无需用户注册（云同步功能可选）
- 无服务器端数据收集
- 无分析或崩溃报告服务
- 无广告SDK
- 无第三方追踪

### 2. 数据存储

**本地存储**
- 所有记账记录存储在您设备上的本地SQLite数据库中
- 除非您明确配置云同步，否则数据保留在您的设备上
- 我们无法访问、查看或检索您的本地数据

**云存储（可选）**
如果您选择启用云同步，您的数据将存储在：

- **自定义Supabase实例**：存储在您自己的Supabase账户中
- **WebDAV服务器**：存储在您自己的服务器上

重要：我们不是云服务提供商，不运营任何存储您数据的服务器。

### 3. 数据共享

我们不与任何人共享您的数据，因为我们首先无法访问您的数据。

### 4. 权限请求

应用请求以下Android权限：

- **存储权限**：用于导入/导出CSV文件（可选）
- **网络权限**：用于与您自己的云服务同步（可选）
- **通知权限**：用于显示应用更新通知（可选）
- **提醒权限**：用于发送您设置的记账提醒（可选）

### 5. 开源透明

蜜蜂记账完全开源（MIT许可）：
- 查看完整代码：https://github.com/maojunzc/BeeCount
- 验证我们不收集任何数据
- 从源代码自行构建
- 贡献改进

### 6. 联系我们

如有任何问题，请通过以下方式联系我们：

- **邮箱**: 2316562571@qq.com
- GitHub Issues: https://github.com/maojunzc/BeeCount/issues
- GitHub Discussions: https://github.com/maojunzc/BeeCount/discussions

---

**Your privacy is our priority. 您的隐私是我们的首要任务。🐝**
