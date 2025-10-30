import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../core/theme/app_colors.dart';

class IngredientRow extends StatelessWidget {
  final String name;
  final String quantity;

  const IngredientRow({
    super.key,
    required this.name,
    required this.quantity,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Icon(
            Icons.circle,
            size: 6,
            color: Colors.white70,
          ),
          const SizedBox(width: 10),

          Expanded(
            child: Text(
              name,
              style: GoogleFonts.balooThambi2(
                color: AppColors.white,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
              overflow: TextOverflow.ellipsis,
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
    );
  }
}
