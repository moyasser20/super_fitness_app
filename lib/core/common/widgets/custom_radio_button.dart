import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';

class CustomRadioButton extends StatelessWidget {
  const CustomRadioButton({
    super.key,
    required String? selectedGoal,
    required this.value,
  }) : _selectedItem = selectedGoal;

  final String? _selectedItem;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(40),
        color: Colors.white.withValues(alpha: 0.09),
        border: Border.all(
          color: AppColors.white.withValues(alpha: 0.8),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 12,
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.transparent,
              border: Border.all(color: AppColors.white, width: 1),
            ),
            child: Container(
              padding: const EdgeInsets.all(3),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                border:
                    _selectedItem == value
                        ? Border.all(color: AppColors.white, width: 1)
                        : null,
                color:
                    _selectedItem == value ? AppColors.main : Colors.transparent,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
