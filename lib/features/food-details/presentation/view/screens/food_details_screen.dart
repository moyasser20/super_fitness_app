import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:super_fitness_app/core/l10n/translation/app_localizations.dart';
import 'package:super_fitness_app/core/theme/app_colors.dart';
import 'package:super_fitness_app/core/contants/app_images.dart';
import 'package:super_fitness_app/features/food-details/presentation/view/widgets/ingredients_custom_container.dart';
import 'package:super_fitness_app/features/food-details/presentation/view/widgets/custom_container_value.dart';
import 'package:super_fitness_app/features/food-details/presentation/view/widgets/recommendation_widget.dart';

import '../../viewmodel/meals_details_cubit.dart';
import '../../viewmodel/meals_details_states.dart';

class FoodDetailsScreen extends StatelessWidget {
  const FoodDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;

    return Scaffold(
      body: BlocBuilder<MealDetailsCubit, MealDetailsState>(
        builder: (context, state) {
          if (state is MealDetailsLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          else if (state is MealDetailsError) {
            return Center(
              child: Text(
                state.message,
                style: const TextStyle(color: Colors.red, fontSize: 16),
              ),
            );
          }

          else if (state is MealDetailsLoaded) {
            final meal = state.meal;

            return SingleChildScrollView(
              child: Stack(
                children: [
                  Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 1.5,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(AppImages.foodDetailsImageBg),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),

                  Positioned(
                    top: 40,
                    left: 0,
                    right: 0,
                    child: Image.network(
                      meal.strMealThumb,
                      fit: BoxFit.fitWidth,
                      errorBuilder: (context, error, stackTrace) =>
                      const Icon(Icons.broken_image,
                          size: 80, color: Colors.white),
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return const Center(
                            child: CircularProgressIndicator());
                      },
                    ),
                  ),

                  Positioned(
                    top: 50,
                    left: 20,
                    child: GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Image.asset(
                        "assets/icons/back_fitness_icon.png",
                        height: 40,
                        width: 40,
                      ),
                    ),
                  ),

                  Positioned(
                    top: 240,
                    left: 24,
                    child: Text(
                      meal.strMeal,
                      style: GoogleFonts.balooThambi2(
                        color: AppColors.white,
                        fontSize: 32,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),

                  Positioned(
                    top: 290,
                    left: 24,
                    right: 24,
                    child: Text(
                      meal.strInstructions,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.balooThambi2(
                        color: AppColors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),

                  Positioned(
                    top: 350,
                    left: 0,
                    right: 0,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          CustomContainerValues(value: "100 K", label: "Energy"),
                          CustomContainerValues(value: "15 G", label: "Protein"),
                          CustomContainerValues(value: "58 G", label: "Carbs"),
                          CustomContainerValues(value: "20 G", label: "Fat"),
                        ],
                      ),
                    ),
                  ),

                  Positioned(
                    top: 430,
                    left: 0,
                    right: 0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 15.0),
                          child: Text(
                            local.ingredients,
                            style: GoogleFonts.balooThambi2(
                              color: AppColors.white,
                              fontSize: 28,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Center(child: IngredientsCustomContainer()),
                      ],
                    ),
                  ),

                  Positioned(
                    top: 730,
                    left: 0,
                    right: 0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 15.0),
                          child: Text(
                            local.recommendation,
                            style: GoogleFonts.balooThambi2(
                              color: AppColors.white,
                              fontSize: 28,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          height: 250,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: 6,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: EdgeInsets.only(
                                  left: index == 0 ? 15.0 : 8.0,
                                  right: index == 5 ? 15.0 : 8.0,
                                ),
                                child: const RecommendationWidget(
                                  foodName: "Pasta with chicks",
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }

          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
