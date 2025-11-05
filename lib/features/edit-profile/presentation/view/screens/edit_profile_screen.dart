import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_fitness_app/core/Widgets/custom_Elevated_Button.dart';
import 'package:super_fitness_app/core/Widgets/custom_text_field.dart';
import 'package:super_fitness_app/core/extensions/extensions.dart';
import 'package:super_fitness_app/core/theme/app_colors.dart';
import 'package:super_fitness_app/core/utils/styles.dart';
import 'package:super_fitness_app/core/l10n/translation/app_localizations.dart';
import 'package:super_fitness_app/features/edit-profile/presentation/view/widgets/weight_step_widget.dart';
import 'package:super_fitness_app/features/edit-profile/presentation/view/widgets/goal_step_widget.dart';
import 'package:super_fitness_app/features/edit-profile/presentation/view/widgets/activity_step_widget.dart';
import 'package:super_fitness_app/features/edit-profile/presentation/viewmodel/edit_profile_cubit.dart';
import 'package:super_fitness_app/features/edit-profile/presentation/viewmodel/edit_profile_states.dart';

import '../../../../../core/common/widgets/custome_loading_indicator.dart'; // import your loading widget

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final Map<String, String> activityLevelMap = {
    "Rookie": "level1",
    "Beginner": "level2",
    "Intermediate": "level3",
    "Advance": "level4",
    "True Beast": "level5",
  };

  @override
  void initState() {
    super.initState();
    context.read<EditProfileViewModel>().loadUserData();
  }

  Future<void> _onRefresh() async {
    await context.read<EditProfileViewModel>().loadUserData();
  }

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!;

    return Scaffold(
      body: BlocBuilder<EditProfileViewModel, EditProfileState>(
        builder: (context, state) {
          final cubit = context.read<EditProfileViewModel>();

          if (state is EditProfileLoading) {
            return AppLoadingIndicator(color: AppColors.main);
          }

          return Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/profile_bg.png"),
                fit: BoxFit.cover,
              ),
            ),
            child: RefreshIndicator(
              onRefresh: _onRefresh,
              color: AppColors.main,
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
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
                    const SizedBox(height: 40),
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        CircleAvatar(
                          radius: 60,
                          backgroundImage: cubit.profilePhotoUrl != null
                              ? (cubit.profilePhotoUrl!.startsWith('assets/')
                              ? AssetImage(cubit.profilePhotoUrl!)
                              : Image.file(
                            File(cubit.profilePhotoUrl!),
                          ).image)
                              : const AssetImage("assets/images/test_food.png"),
                          backgroundColor: AppColors.grey,
                        ),
                        Positioned(
                          bottom: 95,
                          right: 2,
                          child: GestureDetector(
                            onTap: () => cubit.changeProfilePhoto(),
                            child: Image.asset(
                              "assets/images/edit_photo_pen.png",
                              width: 28,
                              height: 28,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Text(
                      "${cubit.firstNameController.text} ${cubit.lastNameController.text}",
                      style: balooThambi2RegularLarge.copyWith(
                        fontSize: 22,
                        color: AppColors.white,
                      ),
                    ),
                    const SizedBox(height: 40),
                    CustomTextFormField(
                      controller: cubit.firstNameController,
                      hint: "First Name",
                      prefixIcon: Icon(
                        Icons.person_2_outlined,
                        color: AppColors.white.withOpacity(0.5),
                      ).setHorizontalPadding(context, 0.06),
                    ),
                    const SizedBox(height: 20),
                    CustomTextFormField(
                      controller: cubit.lastNameController,
                      hint: "Last Name",
                      prefixIcon: Icon(
                        Icons.person_2_outlined,
                        color: AppColors.white.withOpacity(0.5),
                      ).setHorizontalPadding(context, 0.06),
                    ),
                    const SizedBox(height: 20),
                    CustomTextFormField(
                      controller: cubit.emailController,
                      hint: "Email",
                      prefixIcon: Icon(
                        Icons.email_outlined,
                        color: AppColors.white.withOpacity(0.5),
                      ).setHorizontalPadding(context, 0.06),
                    ),
                    const SizedBox(height: 40),
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
                                  selectedWeight: cubit.selectedWeight,
                                  onWeightChanged: (value) {
                                    setState(() {
                                      cubit.selectedWeight = value;
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
                      hint: "${cubit.selectedWeight} ${locale.kilo}",
                    ),
                    const SizedBox(height: 20),
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
                                  selectedGoal: cubit.selectedGoal,
                                  onGoalSelected: (goal) {
                                    setState(() {
                                      cubit.selectedGoal = goal;
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
                      hint: cubit.selectedGoal,
                    ),
                    const SizedBox(height: 20),
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
                                  selectedActivityDisplay:
                                  cubit.selectedActivity,
                                  onActivitySelected: (activity) {
                                    setState(() {
                                      cubit.selectedActivity =
                                      activityLevelMap[activity["display"]!]!;
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
                      hint: activityLevelMap.keys.firstWhere(
                            (key) =>
                        activityLevelMap[key] == cubit.selectedActivity,
                        orElse: () => cubit.selectedActivity,
                      ),
                    ),
                    const SizedBox(height: 35),
                    CustomElevatedButton(
                      text: locale.done,
                      width: 400,
                      onPressed: () => cubit.submitProfile(context),
                    ),
                    const SizedBox(height: 50),
                  ],
                ).setHorizontalPadding(context, 0.06),
              ),
            ),
          );
        },
      ),
    );
  }
}
