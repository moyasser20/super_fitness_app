import 'dart:ui';
import 'package:flutter/material.dart';
import '../../../domain/entities/meal_details_entity.dart';
import 'ingredient_row.dart';

class IngredientsCustomContainer extends StatelessWidget {
  final MealDetailsEntity meal;
  const IngredientsCustomContainer({super.key, required this.meal});

  static const double blurIntensity = 85.0;
  static const double borderRadius = 50.0;
  static const EdgeInsetsGeometry padding =
  EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0);

  @override
  Widget build(BuildContext context) {
    final ingredients = <Map<String, String>>[];

    for (int i = 1; i <= 20; i++) {
      final ingredient = _getProperty(meal, 'strIngredient$i');
      final measure = _getProperty(meal, 'strMeasure$i');

      if (ingredient != null &&
          ingredient.trim().isNotEmpty &&
          ingredient != '') {
        ingredients.add({
          'name': ingredient,
          'quantity': measure ?? '',
        });
      }
    }


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
                    color: Colors.white.withOpacity(0.15),
                    width: 1.0,
                  ),
                ),
              ),
              Padding(
                padding: padding,
                child: ingredients.isNotEmpty
                    ? SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: ingredients
                        .map((ing) => IngredientRow(
                      name: ing['name']!,
                      quantity: ing['quantity']!,
                    ))
                        .toList(),
                  ),
                )
                    : const Center(
                  child: Text(
                    "No Ingredients Found",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  dynamic _getProperty(MealDetailsEntity meal, String fieldName) {
    switch (fieldName) {
      case 'strIngredient1':
        return meal.strIngredient1;
      case 'strIngredient2':
        return meal.strIngredient2;
      case 'strIngredient3':
        return meal.strIngredient3;
      case 'strIngredient4':
        return meal.strIngredient4;
      case 'strIngredient5':
        return meal.strIngredient5;
      case 'strIngredient6':
        return meal.strIngredient6;
      case 'strIngredient7':
        return meal.strIngredient7;
      case 'strIngredient8':
        return meal.strIngredient8;
      case 'strIngredient9':
        return meal.strIngredient9;
      case 'strIngredient10':
        return meal.strIngredient10;
      case 'strIngredient11':
        return meal.strIngredient11;
      case 'strIngredient12':
        return meal.strIngredient12;
      case 'strIngredient13':
        return meal.strIngredient13;
      case 'strIngredient14':
        return meal.strIngredient14;
      case 'strIngredient15':
        return meal.strIngredient15;
      case 'strIngredient16':
        return meal.strIngredient16;
      case 'strIngredient17':
        return meal.strIngredient17;
      case 'strIngredient18':
        return meal.strIngredient18;
      case 'strIngredient19':
        return meal.strIngredient19;
      case 'strIngredient20':
        return meal.strIngredient20;
      case 'strMeasure1':
        return meal.strMeasure1;
      case 'strMeasure2':
        return meal.strMeasure2;
      case 'strMeasure3':
        return meal.strMeasure3;
      case 'strMeasure4':
        return meal.strMeasure4;
      case 'strMeasure5':
        return meal.strMeasure5;
      case 'strMeasure6':
        return meal.strMeasure6;
      case 'strMeasure7':
        return meal.strMeasure7;
      case 'strMeasure8':
        return meal.strMeasure8;
      case 'strMeasure9':
        return meal.strMeasure9;
      case 'strMeasure10':
        return meal.strMeasure10;
      case 'strMeasure11':
        return meal.strMeasure11;
      case 'strMeasure12':
        return meal.strMeasure12;
      case 'strMeasure13':
        return meal.strMeasure13;
      case 'strMeasure14':
        return meal.strMeasure14;
      case 'strMeasure15':
        return meal.strMeasure15;
      case 'strMeasure16':
        return meal.strMeasure16;
      case 'strMeasure17':
        return meal.strMeasure17;
      case 'strMeasure18':
        return meal.strMeasure18;
      case 'strMeasure19':
        return meal.strMeasure19;
      case 'strMeasure20':
        return meal.strMeasure20;
      default:
        return null;
    }
  }
}
