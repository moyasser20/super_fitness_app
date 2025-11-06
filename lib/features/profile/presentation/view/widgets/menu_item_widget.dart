import 'package:flutter/material.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/utils/styles.dart';

class MenuItemWidget extends StatelessWidget {
  final Widget? leading;
  final String title;
  final Widget? trailing;
  final VoidCallback? onTap;
  final bool isLogout;

  const MenuItemWidget({
    super.key,
    this.leading,
    required this.title,
    this.trailing,
    this.onTap,
    this.isLogout = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ListTile(
      leading: leading,
      title:
          isLogout
              ? Text(
                title,
                style: balooThambi2SemiBold.copyWith(
                  fontSize: 16,
                  color: AppColors.orange,
                ),
              )
              : Text(title, style: balooThambi2SemiBold.copyWith(fontSize: 16)),
      trailing:
          trailing ??
          const Icon(Icons.arrow_forward_ios, size: 20, color: AppColors.main),
      onTap: onTap,
    );
  }
}
