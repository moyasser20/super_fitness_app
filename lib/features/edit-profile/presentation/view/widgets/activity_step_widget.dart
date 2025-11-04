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

class ActivityStepScreen extends StatelessWidget {
  final List<Map<String, String>> activities;
  final String? selectedActivityDisplay;
  final ValueChanged<Map<String, String>> onActivitySelected;
  final VoidCallback onNext;

  const ActivityStepScreen({
    super.key,
    required this.activities,
    required this.selectedActivityDisplay,
    required this.onActivitySelected,
    required this.onNext,
  });

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
              child: Text("YOUR REGULAR PHYSICAL ACTIVITY LEVEL ?" , style: balooThambi2ExtraBold.copyWith(
                fontSize: 24,
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
                      itemCount: activities.length,
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
                    const SizedBox(height: 20),
                    CustomElevatedButton(
                      color: AppColors.main,
                      width: double.infinity,
                      text: locale!.done,
                      onPressed: onNext,
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
