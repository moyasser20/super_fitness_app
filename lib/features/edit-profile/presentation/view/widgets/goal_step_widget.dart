import 'package:flutter/material.dart';
import 'package:super_fitness_app/core/common/widgets/container_with_blur_widget.dart';
import 'package:super_fitness_app/core/common/widgets/custom_radio_button.dart';
import 'package:super_fitness_app/core/theme/app_colors.dart';
import '../../../../../core/widgets/custom_elevated_button.dart';
import '../../../../../core/l10n/translation/app_localizations.dart';

class GoalStepWidget extends StatelessWidget {
  final List<String> goals;
  final String? selectedGoal;
  final ValueChanged<String> onGoalSelected;
  final VoidCallback onNext;

  const GoalStepWidget({
    super.key,
    required this.goals,
    required this.selectedGoal,
    required this.onGoalSelected,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context);

    return ContainerWithBlurWidget(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: goals.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                final goal = goals[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: GestureDetector(
                    onTap: () => onGoalSelected(goal),
                    child: CustomRadioButton(
                      selectedGoal: selectedGoal,
                      value: goal,
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 20),
          CustomElevatedButton(
            color: AppColors.main,
            width: double.infinity,
            text: locale!.next,
            onPressed: onNext,
          ),
        ],
      ),
    );
  }
}
