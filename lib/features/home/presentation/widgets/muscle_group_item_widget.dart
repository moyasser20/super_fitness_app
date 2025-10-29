import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/styles.dart';

class MuscleGroupItemWidget extends StatelessWidget {
  final String title;
  final bool isSelected;

  const MuscleGroupItemWidget({
    super.key,
    required this.title,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected ? AppColors.orange : Colors.transparent,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Text(
        title,
        style: balooThambi2BoldLarge.copyWith(
          color: isSelected ? Colors.white : Colors.white.withOpacity(0.8),
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
