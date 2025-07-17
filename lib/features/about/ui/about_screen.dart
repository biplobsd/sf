import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../../constants/constants.dart';
import '../../../extensions/build_context_extension.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/app_theme.dart';
import '../../../theme/gaps.dart';
import '../../common/ui/widgets/common_header.dart';

class About extends StatelessWidget {
  static const String pathName = '/about';
  static const String pageName = 'About';

  const About({super.key});

  @override
  Widget build(BuildContext context) {
    double sizedRPadding = _isSmallScreen(context) ? 10 : 25;
    var primaryColor = Theme.of(context).colorScheme.primary.withAlpha(200);

    return Scaffold(
      backgroundColor: context.secondaryBackgroundColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.sp),
        child: CommonHeader(
          header: 'About Us',
        ),
      ),
      body: Container(
        margin: EdgeInsets.only(
          left: sizedRPadding,
          right: sizedRPadding,
          bottom: 10,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              gap4,
              Center(
                child: Image.asset(
                  'assets/images/logo.png',
                  height: 100.sp,
                ),
              ),
              const SizedBox(height: 10),
              FutureBuilder<PackageInfo>(
                future: _getAppInfo(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    String appInfoText =
                        "${Constants.shopName} ${Constants.tag} v${snapshot.data!.version} #${snapshot.data!.buildNumber}";
                    return Column(
                      children: [
                        InkWell(
                          onTap: () {
                            _copyToClipboard(context, appInfoText);
                          },
                          child: Column(
                            children: [
                              Text(
                                Constants.shopName,
                                style: AppTheme.titleLarge20Colored,
                              ),
                              Text(
                                "${Constants.tag} v${snapshot.data!.version} #${snapshot.data!.buildNumber}",
                                style: AppTheme.bodyLarge16,
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  } else {
                    return const CircularProgressIndicator();
                  }
                },
              ),
              TextButton(
                onPressed: () => _openUrl(context, 'https://biplobsd.me'),
                child: Text(
                  "Developed by SpeedOut Source, 2025",
                  style: AppTheme.bodySmall12.copyWith(
                    color: context.isDarkMode
                        ? AppColors.mono40
                        : AppColors.mono100,
                  ),
                ),
              ),
              const Divider(),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Platform Supported",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.sp),
                margin: EdgeInsets.symmetric(vertical: 5.sp),
                decoration: BoxDecoration(
                  color:
                      context.isDarkMode ? AppColors.mono80 : AppColors.mono0,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      color: !kIsWeb && _isAndroid() ? primaryColor : null,
                      tooltip: 'Android',
                      onPressed: () => _openUrl(context, 'https://biplobsd.me'),
                      icon: const Icon(
                        Icons.android,
                      ),
                    ),
                    const SizedBox(width: 5),
                    IconButton(
                      color: !kIsWeb && _isIOS() ? primaryColor : null,
                      tooltip: 'iOS',
                      onPressed: null,
                      icon: const Icon(Icons.apple),
                    ),
                    const SizedBox(width: 5),
                    IconButton(
                      color: !kIsWeb && _isWindows() ? primaryColor : null,
                      tooltip: 'Windows',
                      onPressed: null,
                      icon: const Icon(Icons.window),
                    ),
                    const SizedBox(width: 5),
                    IconButton(
                      color: kIsWeb ? primaryColor : null,
                      tooltip: 'Progressive Web App',
                      onPressed: null,
                      icon: const Icon(Icons.web),
                    )
                  ],
                ),
              ),
              gap0_2,
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Contract Info",
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ),
              gap0_2,
              _DevInfoTile(
                name: "A Client",
                email: "aClient@gmail.com",
                role: "Client",
              ),
              _DevInfoTile(
                profileUrl:
                    'https://avatars.githubusercontent.com/u/43641536?v=4',
                name: "Biplob Kumar Sutradhar",
                email: "biplobsd11@gmail.com",
                role: "Lead developer",
                devGithubUrl: 'https://github.com/biplobsd',
              ),
              const SizedBox(height: 20),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Issue or Bug report",
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ),
              const SizedBox(height: 5),
              ListTile(
                leading: const Icon(Icons.bug_report),
                title: Text(
                  "Report on Github issue tab",
                  style: AppTheme.bodyLarge16.copyWith(
                    color: context.isDarkMode
                        ? AppColors.mono40
                        : AppColors.mono100,
                  ),
                ),
                subtitle: Text(
                    "Before reporting any issue or bug report please add proper description and screenshots to help fix the problem.",
                    style: AppTheme.bodySmall12.copyWith(
                      color: context.isDarkMode
                          ? AppColors.mono60
                          : AppColors.mono100,
                    )),
                trailing: TextButton(
                  onPressed: () => _openUrl(context, 'https://biplobsd.me'),
                  child: const Text('Issue'),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  // Helper methods
  bool _isSmallScreen(BuildContext context) {
    return MediaQuery.of(context).size.width < 600;
  }

  bool _isAndroid() {
    return defaultTargetPlatform == TargetPlatform.android;
  }

  bool _isIOS() {
    return defaultTargetPlatform == TargetPlatform.iOS;
  }

  bool _isWindows() {
    return defaultTargetPlatform == TargetPlatform.windows;
  }

  Future<void> _copyToClipboard(BuildContext context, String text) async {
    await Clipboard.setData(ClipboardData(text: text));
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Copied to clipboard')),
      );
    }
  }

  void _openUrl(BuildContext context, String url) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor:
              context.isDarkMode ? AppColors.mono90 : AppColors.mono0,
          title: const Text('Open URL'),
          content: Text('Would you like to open: $url?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                // This displays information about the URL rather than opening it
                // since we removed the URL launcher dependency
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('URL: $url')),
                );
              },
              child: const Text('Open'),
            ),
          ],
        );
      },
    );
  }

  Future<PackageInfo> _getAppInfo() async {
    return await PackageInfo.fromPlatform();
  }
}

// Simple data class to replace the package_info dependency
class AppInfo {
  final String version;
  final String buildNumber;

  AppInfo({required this.version, required this.buildNumber});
}

class _DevInfoTile extends StatelessWidget {
  final String? profileUrl;
  final String name;
  final String? email;
  final String role;
  final String? devGithubUrl;

  const _DevInfoTile({
    this.profileUrl,
    this.email,
    required this.name,
    required this.role,
    this.devGithubUrl,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: null,
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: profileUrl != null
              ? Image.network(
                  profileUrl!,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                              loadingProgress.expectedTotalBytes!
                          : null,
                    );
                  },
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(Icons.person, size: 60);
                  },
                )
              : Image.asset(
                  'assets/images/logo.png',
                  width: 60,
                  height: 60,
                  fit: BoxFit.cover,
                ),
        ),
        title: Text(
          name,
          style: AppTheme.bodyLarge16.copyWith(
            color: context.isDarkMode ? AppColors.mono40 : AppColors.mono100,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 3),
            Text(role,
                style: AppTheme.bodySmall12.copyWith(
                  color:
                      context.isDarkMode ? AppColors.mono60 : AppColors.mono100,
                )),
            if (email != null)
              Text(
                email!,
                style: AppTheme.bodySmall12.copyWith(
                  color:
                      context.isDarkMode ? AppColors.mono60 : AppColors.mono100,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
