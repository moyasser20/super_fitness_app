import 'package:flutter/material.dart';
import 'package:super_fitness_app/core/l10n/translation/app_localizations.dart';
import 'package:super_fitness_app/core/theme/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:super_fitness_app/features/food-details/presentation/view/widgets/ingredients_custom_container.dart';
import '../widgets/custom_container_value.dart';
import '../../../../../core/contants/app_images.dart';
import '../widgets/recommendation_widget.dart';

class FoodDetailsScreen extends StatelessWidget {
  const FoodDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var local = AppLocalizations.of(context)!;
    final List<String> recommendedFoods =
    List.generate(6, (index) => 'Pasta with chicks');

    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: 1000,
          child: Stack(
            children: [
              Container(
                width: double.infinity,
                height: double.infinity,
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
                child: Image.asset(
                  "assets/images/food_details_stack_image.png",
                  fit: BoxFit.fitWidth,
                ),
              ),
              Positioned(
                top: 50,
                left: 20,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
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
                  "Pasta with meat",
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
                child: SizedBox(
                  width: MediaQuery.of(context).size.width - 48,
                  child: Text(
                    "Lorem ipsum dolor sit amet consectetur . Tempus volutpat ut nisi morbi.",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.balooThambi2(
                      color: AppColors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w300,
                    ),
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
                    Center(
                      child: IngredientsCustomContainer(),
                    ),
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
                        itemCount: recommendedFoods.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.only(
                              left: index == 0 ? 15.0 : 8.0,
                              right: index == recommendedFoods.length - 1
                                  ? 15.0
                                  : 8.0,
                            ),
                            child: RecommendationWidget(
                              foodName: recommendedFoods[index],
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
        ),
      ),
    );
  }
}