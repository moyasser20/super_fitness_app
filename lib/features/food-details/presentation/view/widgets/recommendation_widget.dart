import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RecommendationWidget extends StatelessWidget {
  final String foodName;

  const RecommendationWidget({
    super.key,
    required this.foodName,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Stack(
        children: [
          Image.asset(
            "assets/images/test_food_image.png",
            width: 180,
            height: 180,
            fit: BoxFit.cover,
          ),

          Container(
            width: 180,
            height: 180,
            color: Colors.black.withOpacity(0.3),
          ),

          Positioned(
            bottom: 30,
            left: 0,
            right: 40,
            child: Text(
              foodName,
              textAlign: TextAlign.center,
              style: GoogleFonts.balooThambi2(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
                shadows: [
                  Shadow(
                    blurRadius: 6,
                    color: Colors.black.withOpacity(0.8),
                    offset: const Offset(1, 1),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}


