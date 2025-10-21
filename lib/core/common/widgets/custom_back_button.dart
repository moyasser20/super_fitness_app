import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../contants/app_icons.dart';
import '../../theme/app_colors.dart';

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 60,
      left: 16,
      child: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: AppColors.main,
            borderRadius: BorderRadius.circular(50),
          ),
          child: SvgPicture.asset(AppIcons.backIcon),
        ),
      ),
    );
  }
}
