import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../extensions/build_context_extension.dart';
import '../../../../features/common/ui/widgets/primary_button.dart';
import '../../../../features/common/ui/widgets/secondary_button.dart';
import '../../../../theme/app_colors.dart';
import '../../../../theme/app_theme.dart';
import '../../../../theme/gaps.dart';

class CommonBottomSheet extends ConsumerWidget {
  final String title;
  final String content;
  final String primaryButtonLabel;
  final Function()? primaryButtonAction;
  final Color primaryButtonBackground;
  final String? secondaryButtonLabel;
  final Function()? secondaryButtonAction;

  const CommonBottomSheet({
    super.key,
    required this.title,
    required this.content,
    required this.primaryButtonLabel,
    this.primaryButtonAction,
    this.primaryButtonBackground = AppColors.blueberry100,
    this.secondaryButtonLabel,
    this.secondaryButtonAction,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: EdgeInsets.only(
        bottom:
            MediaQuery.of(context).viewInsets.bottom, // To push with keyboard
        left: 16,
        right: 16,
        top: 20,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: AppTheme.titleSmall16,
          ),
          const SizedBox(height: 16),
          Text(
            content,
            style: AppTheme.bodyMedium14,
          ),
          const SizedBox(height: 16),
          secondaryButtonLabel != null
              ? Row(
                  children: [
                    Expanded(
                      child: SecondaryButton(
                        text: secondaryButtonLabel ?? '',
                        onPressed: () {
                          secondaryButtonAction?.call();
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: PrimaryButton(
                        text: primaryButtonLabel,
                        backgroundColor: primaryButtonBackground,
                        onPressed: () {
                          primaryButtonAction?.call();
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                  ],
                )
              : PrimaryButton(
                  text: primaryButtonLabel,
                  backgroundColor: primaryButtonBackground,
                  onPressed: () {
                    primaryButtonAction?.call();
                    Navigator.of(context).pop();
                  },
                ),
          gap4,
        ],
      ),
    );
  }
}

void showCommonBottomSheet(
  BuildContext context, {
  required String title,
  required String content,
  required String primaryButtonLabel,
  Function()? primaryButtonAction,
  Color primaryButtonBackground = AppColors.blueberry100,
  String? secondaryButtonLabel,
  Function()? secondaryButtonAction,
}) {
  showModalBottomSheet(
    backgroundColor: context.isDarkMode ? AppColors.mono90 : Colors.white,
    context: context,
    isScrollControlled: true, // For full height if needed with keyboard
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) {
      return CommonBottomSheet(
        title: title,
        content: content,
        primaryButtonLabel: primaryButtonLabel,
        primaryButtonAction: primaryButtonAction,
        primaryButtonBackground: primaryButtonBackground,
        secondaryButtonLabel: secondaryButtonLabel,
        secondaryButtonAction: secondaryButtonAction,
      );
    },
  );
}
