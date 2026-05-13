import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:beecount/widgets/biz/bee_icon.dart';

import '../../providers.dart';
import '../../widgets/ui/ui.dart';
import '../../widgets/biz/biz.dart';
import '../../styles/tokens.dart';
import '../../services/system/logger_service.dart';
import '../../l10n/app_localizations.dart';
import '../../utils/ui_scale_extensions.dart';

import 'log_center_page.dart';

/// 关于页面
class AboutPage extends ConsumerStatefulWidget {
  const AboutPage({super.key});

  @override
  ConsumerState<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends ConsumerState<AboutPage> {
  String _version = '';
  String _versionDisplay = '';

  @override
  void initState() {
    super.initState();
    _loadVersion();
  }

  Future<void> _loadVersion() async {
    final info = await _getAppInfo();
    final versionText = info.version.startsWith('dev-')
        ? '${info.version} (${info.buildNumber})'
        : info.version;
    setState(() {
      _version = info.version;
      _versionDisplay = versionText;
    });
  }

  void _showDeveloperStory(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.aboutDeveloperStoryTitle),
        content: SingleChildScrollView(
          child: Text(
            l10n.aboutDeveloperStory,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: BeeTokens.textSecondary(context),
                  height: 1.7,
                ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(l10n.commonConfirm),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BeeTokens.scaffoldBackground(context),
      body: Column(
        children: [
          PrimaryHeader(
            title: AppLocalizations.of(context).aboutPageTitle,
            subtitle: AppLocalizations.of(context).aboutPageSubtitle,
            showBack: true,
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                // 顶部：图标 + 应用名称 + 版本号
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 24.0.scaled(context, ref),
                  ),
                  child: Column(
                    children: [
                      BeeIcon(
                        color: Theme.of(context).colorScheme.primary,
                        size: 80.0.scaled(context, ref),
                      ),
                      SizedBox(height: 16.0.scaled(context, ref)),
                      GestureDetector(
                        onTap: () => _showDeveloperStory(context),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              AppLocalizations.of(context).appName,
                              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: BeeTokens.textPrimary(context),
                                  ),
                            ),
                            SizedBox(width: 4.0.scaled(context, ref)),
                            Icon(
                              Icons.help_outline_rounded,
                              size: 18.0.scaled(context, ref),
                              color: BeeTokens.textTertiary(context),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 8.0.scaled(context, ref)),
                      Text(
                        _versionDisplay.isEmpty
                            ? AppLocalizations.of(context).aboutPageLoadingVersion
                            : _versionDisplay,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: BeeTokens.textSecondary(context),
                            ),
                      ),
                    ],
                  ),
                ),
                // 联系方式
                SectionCard(
                  margin: EdgeInsets.zero,
                  child: Column(
                    children: [
                      AppListTile(
                        leading: Icons.language_outlined,
                        title: AppLocalizations.of(context).aboutWebsite,
                        subtitle: 'github.com/maojunzc',
                        onTap: () async {
                          final url = Uri.parse('https://github.com/maojunzc');
                          await _tryOpenUrl(url);
                        },
                      ),
                      const Divider(height: 1, thickness: 0.5),
                      AppListTile(
                        leading: Icons.code_outlined,
                        title: AppLocalizations.of(context).aboutGitHubRepo,
                        subtitle: 'github.com/maojunzc/BeeCount',
                        onTap: () async {
                          final url = Uri.parse('https://github.com/maojunzc/BeeCount');
                          await _tryOpenUrl(url);
                        },
                      ),
                      // 微信公众号
                      if (Localizations.localeOf(context).languageCode == 'zh') ...[
                        const Divider(height: 1, thickness: 0.5),
                        AppListTile(
                          leading: Icons.chat_outlined,
                          title: AppLocalizations.of(context).aboutWechat,
                          subtitle: 'maojunzc',
                          onTap: () async {
                            // 微信公众号暂不支持直接跳转，显示提示
                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('微信公众号：maojunzc'),
                                  duration: const Duration(seconds: 2),
                                ),
                              );
                            }
                          },
                        ),
                        const Divider(height: 1, thickness: 0.5),
                        AppListTile(
                          leading: Icons.alternate_email_outlined,
                          title: AppLocalizations.of(context).aboutQQ,
                          subtitle: '2316562571',
                          onTap: () async {
                            // QQ号暂不支持直接跳转，显示提示
                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('QQ号：2316562571'),
                                  duration: const Duration(seconds: 2),
                                ),
                              );
                            }
                          },
                        ),
                      ],
                    ],
                  ),
                ),
                SizedBox(height: 8.0.scaled(context, ref)),
                // 功能
                SectionCard(
                  margin: EdgeInsets.zero,
                  child: Column(
                    children: [
                      AppListTile(
                        leading: Icons.feedback_outlined,
                        title: AppLocalizations.of(context).mineFeedback,
                        subtitle: AppLocalizations.of(context).mineFeedbackSubtitle,
                        onTap: () async {
                          final url = Uri.parse(
                              'https://github.com/maojunzc/BeeCount/issues');
                          await _tryOpenUrl(url);
                        },
                      ),
                      const Divider(height: 1, thickness: 0.5),
                      AppListTile(
                        leading: Icons.bug_report_outlined,
                        title: AppLocalizations.of(context).logCenterTitle,
                        subtitle: AppLocalizations.of(context).logCenterSubtitle,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const LogCenterPage(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),

              ],
            ),
          ),
        ],
      ),
    );
  }
}

// -------- 工具方法：关于与更新 --------
class _AppInfo {
  final String version;
  final String buildNumber;
  final String? commit;
  final String? buildTime;
  const _AppInfo(this.version, this.buildNumber, {this.commit, this.buildTime});
}

// 优先读取 CI 注入的 dart-define（CI_VERSION/GIT_COMMIT/BUILD_TIME），否则回退 PackageInfo
Future<_AppInfo> _getAppInfo() async {
  final p = await PackageInfo.fromPlatform();
  final commit = const String.fromEnvironment('GIT_COMMIT');
  final buildTime = const String.fromEnvironment('BUILD_TIME');
  final ciVersion = const String.fromEnvironment('CI_VERSION');

  // 版本号策略：CI版本优先，本地开发显示 "dev-{pubspec版本}"
  final version =
      ciVersion.isNotEmpty ? ciVersion : 'dev-${p.version}'; // 本地开发版本标识

  return _AppInfo(version, p.buildNumber,
      commit: commit.isEmpty ? null : commit,
      buildTime: buildTime.isEmpty ? null : buildTime);
}

// _BeeDNSCard 已抽到 lib/widgets/biz/product_promo_card.dart 通用化。
// 此处保留 _tryOpenUrl,因为本页其他链接(GitHub / Telegram / TestFlight 等)
// 还在用。

/// 尝试使用多种方式打开URL，提供更好的兼容性
Future<bool> _tryOpenUrl(Uri url) async {
  try {
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
      return true;
    }
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalNonBrowserApplication);
      return true;
    }
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.platformDefault);
      return true;
    }
    logger.error('AboutPage', '无法打开URL: $url');
    return false;
  } catch (e) {
    logger.error('AboutPage', '打开URL失败: $url', e);
    return false;
  }
}
