import 'package:flutter/material.dart';
import 'package:super_fitness_app/core/common/widgets/container_with_blur_widget.dart';
import 'package:super_fitness_app/core/common/widgets/custom_picker_widget.dart';
import 'package:super_fitness_app/core/theme/app_colors.dart';
import '../../../../../core/l10n/translation/app_localizations.dart';
import '../../../../../core/widgets/custom_elevated_button.dart';

class WeightStepWidget extends StatelessWidget {
  final int selectedWeight;
  final ValueChanged<int> onWeightChanged;
  final VoidCallback onNext;

  const WeightStepWidget({
    super.key,
    required this.selectedWeight,
    required this.onWeightChanged,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context);
    return ContainerWithBlurWidget(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Text(
            locale!.kg,
            style: TextStyle(
              fontSize: 18,
              color: Colors.white.withValues(alpha: 0.8),
            ),
          ),
          const SizedBox(height: 20),
          CustomHorizontalPicker(
            initialValue: selectedWeight,
            minValue: 40,
            maxValue: 150,
            unit: 'kg',
            onValueChanged: onWeightChanged,
          ),
          const SizedBox(height: 30),
          CustomElevatedButton(
            color: AppColors.main,
            width: double.infinity,
            text: locale.next,
            onPressed: onNext,
          ),
        ],
      ),
    );
  }
}
