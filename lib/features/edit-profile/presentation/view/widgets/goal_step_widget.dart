import 'package:flutter/material.dart';
import 'package:super_fitness_app/core/common/widgets/container_with_blur_widget.dart';
import 'package:super_fitness_app/core/common/widgets/custom_radio_button.dart';
import 'package:super_fitness_app/core/extensions/extensions.dart';
import 'package:super_fitness_app/core/theme/app_colors.dart';
import '../../../../../core/contants/app_icons.dart';
import '../../../../../core/contants/app_images.dart';
import '../../../../../core/utils/styles.dart';
import '../../../../../core/widgets/custom_elevated_button.dart';
import '../../../../../core/l10n/translation/app_localizations.dart';

class GoalStepScreen extends StatefulWidget {
  final List<String> goals;
  final String? selectedGoal;
  final ValueChanged<String> onGoalSelected;
  final VoidCallback onNext;

  const GoalStepScreen({
    super.key,
    required this.goals,
    required this.selectedGoal,
    required this.onGoalSelected,
    required this.onNext,
  });

  @override
  State<GoalStepScreen> createState() => _GoalStepScreenState();
}

class _GoalStepScreenState extends State<GoalStepScreen> {
  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context);

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppImages.fitnessBc),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            const SizedBox(height: 70,),
            Image.asset(AppIcons.mainIcon),
            const SizedBox(height: 100,),
            Align(
              alignment: Alignment.centerLeft,
              child: Text("WHAT IS YOUR GOAL ?" , style: balooThambi2BoldLarge.copyWith(
                fontSize: 24,
                color: AppColors.white,
              ),),
            ).setHorizontalPadding(context, 0.045),
            const SizedBox(height: 2,),
            Align(
              alignment: Alignment.centerLeft,
              child: Text("This Helps Us Create Your Personalized Plan" , style: balooThambi2Regular.copyWith(
                fontSize: 18,
                color: AppColors.white,
              ),),
            ).setHorizontalPadding(context, 0.045),
            const SizedBox(height: 25,),
            Center(
              child: ContainerWithBlurWidget(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: widget.goals.length,
                      itemBuilder: (context, index) {
                        final goal = widget.goals[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 18.0),
                          child: GestureDetector(
                            onTap: () => widget.onGoalSelected(goal),
                            child: CustomRadioButton(
                              selectedGoal: widget.selectedGoal,
                              value: goal,
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 20),
                    CustomElevatedButton(
                      color: AppColors.main,
                      width: double.infinity,
                      text: locale!.done,
                      onPressed: widget.onNext,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
