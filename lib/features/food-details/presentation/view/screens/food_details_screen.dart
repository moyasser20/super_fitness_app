import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:super_fitness_app/core/theme/app_colors.dart';
import 'package:super_fitness_app/features/food-details/presentation/view/widgets/ingredients_custom_container.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../../core/common/widgets/custom_snackbar_widget.dart';
import '../../../../../core/common/widgets/custome_loading_indicator.dart';
import '../../../../../core/config/di.dart';
import '../../../../../core/l10n/translation/app_localizations.dart';
import '../../viewmodel/meals_details_cubit.dart';
import '../../viewmodel/meals_details_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widgets/custom_container_value.dart';
import '../widgets/recommendation_widget.dart';

class FoodDetailsScreen extends StatelessWidget {
  final String mealId;

  const FoodDetailsScreen({super.key, required this.mealId});

  @override
  Widget build(BuildContext context) {
    var local = AppLocalizations.of(context)!;

    return BlocProvider(
      create: (context) => getIt<MealDetailsCubit>()..getMealById(mealId),
      child: BlocBuilder<MealDetailsCubit, MealDetailsState>(
        builder: (context, state) {
          if (state is MealDetailsLoading) {
            return AppLoadingIndicator();
          }

          if (state is MealDetailsError) {
            return Scaffold(
              body: Center(
                child: Text(
                  "Error: ${state.message}",
                  style: const TextStyle(color: Colors.red),
                ),
              ),
            );
          }

          if (state is MealDetailsLoaded) {
            final meal = state.meal;

            return Scaffold(
              body: RefreshIndicator(
                onRefresh: () async {
                  context.read<MealDetailsCubit>().getMealById(mealId);
                  await context.read<MealDetailsCubit>().stream.firstWhere(
                    (state) => state is! MealDetailsLoading,
                  );
                },
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Stack(
                    children: [
                      // Background
                      Container(
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height * 1.15,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(
                              "assets/images/food_details_bg.png",
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),

                      // Meal Image
                      Positioned(
                        top: 40,
                        left: 0,
                        right: 0,
                        child: Image.network(
                          meal.strMealThumb,
                          fit: BoxFit.fitWidth,
                          errorBuilder:
                              (context, error, stackTrace) => Image.asset(
                                "assets/images/food_details_stack_image.png",
                                fit: BoxFit.fitWidth,
                              ),
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
                          top: 200,
                          left: 24,
                          child: GestureDetector(
                            onTap: () async {
                              final url = meal.strYoutube;

                              if (url != null && url.isNotEmpty) {
                                final uri = Uri.parse(url);
                                if (await canLaunchUrl(uri)) {
                                  await launchUrl(
                                    uri,
                                    mode: LaunchMode.externalApplication,
                                  );
                                  await showCustomSnackBar(context, local.video_opened_successfully, isError: false);
                                } else {
                                  await showCustomSnackBar(context,   local.could_not_open_video_link,
                                      isError: true);
                                }
                              } else {
                                await showCustomSnackBar(context,   local.video_link_not_available,
                                    isError: true);
                              }
                            },
                            child: Image.asset("assets/images/video_run.png"),
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
                        top: 390,
                        left: 0,
                        right: 0,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Builder(
                            builder: (context) {
                              final tags = meal.strTags?.split(",") ?? [];
                              final displayedTags = tags.take(4).toList();
                              final staticValues = [
                                "100 K",
                                "15 G",
                                "58 G",
                                "20 G",
                              ];

                              return Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: List.generate(
                                  4,
                                  (index) => CustomContainerValues(
                                    value: staticValues[index],
                                    label:
                                        index < displayedTags.length
                                            ? displayedTags[index]
                                            : "N/A",
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),

                      // Ingredients Title
                      Positioned(
                        top: 470,
                        left: 15,
                        child: Text(
                          local.ingredients,
                          style: GoogleFonts.balooThambi2(
                            color: AppColors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),

                      // Ingredients Container
                      Positioned(
                        top: 520,
                        left: 0,
                        right: 0,
                        child: Center(
                          child: IngredientsCustomContainer(meal: meal),
                        ),
                      ),

                      // Recommendations
                      Positioned(
                        top: 780,
                        left: 15,
                        right: 0,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              local.recommendation,
                              style: GoogleFonts.balooThambi2(
                                color: AppColors.white,
                                fontSize: 28,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 10),

                            SizedBox(
                              height: 190,
                              child: ListView.separated(
                                scrollDirection: Axis.horizontal,
                                itemCount: 6,
                                separatorBuilder:
                                    (_, __) => const SizedBox(width: 16),
                                itemBuilder: (context, index) {
                                  final recommendations = [
                                    "Salmon Bowl",
                                    "Tuna Pasta",
                                    "Grilled Chicken",
                                    "Avocado Salad",
                                    "Beef Steak",
                                    "Veggie Wrap",
                                  ];

                                  return RecommendationWidget(
                                    foodName: recommendations[index],
                                  );
                                },
                              ),
                            ),

                            const SizedBox(height: 10),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
