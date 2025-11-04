import 'package:flutter/material.dart';
import 'package:super_fitness_app/core/Widgets/custom_text_field.dart';
import 'package:super_fitness_app/core/extensions/extensions.dart';
import 'package:super_fitness_app/core/theme/app_colors.dart';
import 'package:super_fitness_app/core/utils/styles.dart';
import 'package:super_fitness_app/core/l10n/translation/app_localizations.dart';
import 'package:super_fitness_app/features/edit-profile/presentation/view/widgets/weight_step_widget.dart';
import 'package:super_fitness_app/features/edit-profile/presentation/view/widgets/goal_step_widget.dart';
import 'package:super_fitness_app/features/edit-profile/presentation/view/widgets/activity_step_widget.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  int selectedWeight = 90;
  String selectedGoal = "Gain Weight";
  String selectedActivity = "Rookie";

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/profile_bg.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 55),

              Row(
                children: [
                  Image.asset(
                    "assets/icons/back_fitness_icon.png",
                    height: 30,
                  ),
                  const SizedBox(width: 85),
                  Text(
                    locale.editProfile,
                    style: balooThambi2RegularLarge.copyWith(fontSize: 26),
                  ),
                  const Spacer(flex: 2),
                ],
              ),
              const SizedBox(height: 50),

              Stack(
                alignment: Alignment.center,
                children: [
                  const CircleAvatar(
                    radius: 60,
                    backgroundImage: AssetImage("assets/images/test_food.png"),
                    backgroundColor: AppColors.grey,
                  ),
                  Positioned(
                    bottom: 95,
                    right: 2,
                    child: Image.asset(
                      "assets/images/edit_photo_pen.png",
                      width: 28,
                      height: 28,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              Text(
                "Mohamed Yasser",
                style: balooThambi2RegularLarge.copyWith(
                  fontSize: 22,
                  color: AppColors.white,
                ),
              ),
              const SizedBox(height: 50),

              CustomTextFormField(
                hint: "Mohamed",
                prefixIcon: Icon(
                  Icons.person_2_outlined,
                  color: AppColors.white.withOpacity(0.5),
                ).setHorizontalPadding(context, 0.06),
              ),
              const SizedBox(height: 20),

              CustomTextFormField(
                hint: "Yasser",
                prefixIcon: Icon(
                  Icons.person_2_outlined,
                  color: AppColors.white.withOpacity(0.5),
                ).setHorizontalPadding(context, 0.06),
              ),
              const SizedBox(height: 20),

              CustomTextFormField(
                hint: "moyasser@gmail.com",
                prefixIcon: Icon(
                  Icons.email_outlined,
                  color: AppColors.white.withOpacity(0.5),
                ).setHorizontalPadding(context, 0.06),
              ),
              const SizedBox(height: 50),

              Row(
                children: [
                  Text(
                    locale.yourWeight,
                    style: balooThambi2Bold.copyWith(
                      fontSize: 18,
                      color: AppColors.white,
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => WeightStepScreen(
                            selectedWeight: selectedWeight,
                            onWeightChanged: (value) {
                              setState(() {
                                selectedWeight = value;
                              });
                            },
                            onNext: () => Navigator.pop(context),
                          ),
                        ),
                      );
                    },
                    child: Text(
                      locale.tapToEdit,
                      style: balooThambi2Bold.copyWith(
                        fontSize: 18,
                        color: AppColors.orange,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              CustomTextFormField(
                readonly: true,
                fillColor: AppColors.white.withOpacity(0.15),
                hintColor: AppColors.white,
                hint: "$selectedWeight ${locale.kilo}",
              ),
              const SizedBox(height: 30),

              Row(
                children: [
                  Text(
                    locale.yourGoal,
                    style: balooThambi2Bold.copyWith(
                      fontSize: 18,
                      color: AppColors.white,
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => GoalStepScreen(
                            goals: const [
                              "Gain Weight",
                              "Lose Weight",
                              "Get fitter",
                              "Gain more flexible",
                              "Learn the basic",
                            ],
                            selectedGoal: selectedGoal,
                            onGoalSelected: (goal) {
                              setState(() {
                                selectedGoal = goal;
                              });
                            },
                            onNext: () => Navigator.pop(context),
                          ),
                        ),
                      );
                    },
                    child: Text(
                      locale.tapToEdit,
                      style: balooThambi2Bold.copyWith(
                        fontSize: 18,
                        color: AppColors.orange,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              CustomTextFormField(
                readonly: true,
                fillColor: AppColors.white.withOpacity(0.15),
                hintColor: AppColors.white,
                hint: selectedGoal,
              ),
              const SizedBox(height: 30),

              Row(
                children: [
                  Text(
                    locale.yourActivityLevel,
                    style: balooThambi2Bold.copyWith(
                      fontSize: 18,
                      color: AppColors.white,
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ActivityStepScreen(
                            activities: const [
                              {"display": "Rookie"},
                              {"display": "Beginner"},
                              {"display": "Intermediate"},
                              {"display": "Advance"},
                              {"display": "True Beast"},
                            ],
                            selectedActivityDisplay: selectedActivity,
                            onActivitySelected: (activity) {
                              setState(() {
                                selectedActivity = activity["display"]!;
                              });
                            },
                            onNext: () => Navigator.pop(context),
                          ),
                        ),
                      );
                    },
                    child: Text(
                      locale.tapToEdit,
                      style: balooThambi2Bold.copyWith(
                        fontSize: 18,
                        color: AppColors.orange,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              CustomTextFormField(
                readonly: true,
                fillColor: AppColors.white.withOpacity(0.15),
                hintColor: AppColors.white,
                hint: selectedActivity,
              ),

              const SizedBox(height: 50),
            ],
          ).setHorizontalPadding(context, 0.06),
        ),
      ),
    );
  }
}
