import 'package:flutter/material.dart';
import 'package:super_fitness_app/core/common/widgets/container_with_blur_widget.dart';
import 'package:super_fitness_app/core/common/widgets/custom_radio_button.dart';
import 'package:super_fitness_app/core/theme/app_colors.dart';
import '../../../../../core/widgets/custom_elevated_button.dart';
import '../../../../../core/l10n/translation/app_localizations.dart';

class ActivityStepWidget extends StatelessWidget {
  final List<Map<String, String>> activities;
  final String? selectedActivityDisplay;
  final ValueChanged<Map<String, String>> onActivitySelected;
  final VoidCallback onNext;

  const ActivityStepWidget({
    super.key,
    required this.activities,
    required this.selectedActivityDisplay,
    required this.onActivitySelected,
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
              itemCount: activities.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final activity = activities[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: GestureDetector(
                    onTap: () => onActivitySelected(activity),
                    child: CustomRadioButton(
                      selectedGoal: selectedActivityDisplay,
                      value: activity['display']!,
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
