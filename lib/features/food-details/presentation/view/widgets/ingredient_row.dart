import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../core/theme/app_colors.dart';

class IngredientRow extends StatelessWidget {
  final String name;
  final String quantity;

  const IngredientRow({super.key, required this.name, required this.quantity});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              name,
              style: GoogleFonts.balooThambi2(
                color: AppColors.white,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              quantity,
              style: GoogleFonts.balooThambi2(
                color: AppColors.main,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        const Divider(color: Colors.white10, height: 16.0),
      ],
    );
  }
}
