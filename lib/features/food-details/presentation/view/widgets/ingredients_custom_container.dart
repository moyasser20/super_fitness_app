import 'dart:ui';
import 'package:flutter/material.dart';

import '../../../../../core/theme/app_colors.dart';
import 'ingredient_row.dart';



class IngredientsCustomContainer extends StatelessWidget {
  const IngredientsCustomContainer({super.key});

  static const double blurIntensity = 85.0;
  static const double borderRadius = 50.0;
  static const EdgeInsetsGeometry padding = EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 380,
      height: 242,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: Container(
          child: Stack(
            children: [
              BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: blurIntensity,
                  sigmaY: blurIntensity,
                ),
                child: Container(color: Colors.transparent),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(borderRadius),
                  border: Border.all(
                    color: Colors.transparent,
                    width: 1.0,
                  ),
                ),
              ),

              Padding(
                padding: padding,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: const [
                    IngredientRow(name: "Meal Breasts", quantity: "250g"),
                    IngredientRow(name: "Unsalted Butter", quantity: "1tbsp"),
                    IngredientRow(name: "Sesame Or Vegetable Oil", quantity: "2 Tsp"),
                    IngredientRow(name: "Fresh Ginger", quantity: "2 Tsp"),
                    IngredientRow(name: "Large Eggs", quantity: "100 G"),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}