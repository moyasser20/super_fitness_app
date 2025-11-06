import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../core/theme/app_colors.dart';

class CustomContainerValues extends StatelessWidget {
  final String value;
  final String label;
  final Color? labelColor;

  const CustomContainerValues({
    super.key,
    required this.value,
    required this.label,
    this.labelColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.white.withOpacity(0.6), width: 2),
      ),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              value,
              textAlign: TextAlign.center,
              style: GoogleFonts.balooThambi2(
                color: AppColors.white,
                fontSize: 12,
                fontWeight: FontWeight.w300,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              label,
              textAlign: TextAlign.center,
              style: GoogleFonts.balooThambi2(
                color: AppColors.main,
                fontSize: 12,
                fontWeight: FontWeight.w300,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
