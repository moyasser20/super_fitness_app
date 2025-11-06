import 'package:flutter/material.dart';
import 'package:super_fitness_app/core/common/widgets/container_with_blur_widget.dart';
import 'package:super_fitness_app/core/common/widgets/custom_picker_widget.dart';
import 'package:super_fitness_app/core/contants/app_icons.dart';
import 'package:super_fitness_app/core/extensions/extensions.dart';
import 'package:super_fitness_app/core/theme/app_colors.dart';
import '../../../../../core/contants/app_images.dart';
import '../../../../../core/l10n/translation/app_localizations.dart';
import '../../../../../core/utils/styles.dart';
import '../../../../../core/widgets/custom_elevated_button.dart';

class WeightStepScreen extends StatefulWidget {
  final int selectedWeight;
  final ValueChanged<int> onWeightChanged;
  final VoidCallback onNext;

  const WeightStepScreen({
    super.key,
    required this.selectedWeight,
    required this.onWeightChanged,
    required this.onNext,
  });

  @override
  State<WeightStepScreen> createState() => _WeightStepScreenState();
}

class _WeightStepScreenState extends State<WeightStepScreen> {
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
            const SizedBox(height: 70),
            Image.asset(AppIcons.mainIcon),
            const SizedBox(height: 150),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "WHAT IS YOUR GOAL ?",
                style: balooThambi2BoldLarge.copyWith(
                  fontSize: 24,
                  color: AppColors.white,
                ),
              ),
            ).setHorizontalPadding(context, 0.045),
            const SizedBox(height: 2),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "This Helps Us Create Your Personalized Plan",
                style: balooThambi2Regular.copyWith(
                  fontSize: 18,
                  color: AppColors.white,
                ),
              ),
            ).setHorizontalPadding(context, 0.045),
            const SizedBox(height: 20),
            Center(
              child: ContainerWithBlurWidget(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      locale!.kg,
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white.withOpacity(0.8),
                      ),
                    ),
                    const SizedBox(height: 20),
                    CustomHorizontalPicker(
                      initialValue: widget.selectedWeight,
                      minValue: 40,
                      maxValue: 150,
                      unit: 'kg',
                      onValueChanged: widget.onWeightChanged,
                    ),
                    const SizedBox(height: 30),
                    CustomElevatedButton(
                      color: AppColors.main,
                      width: double.infinity,
                      text: locale.done,
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
