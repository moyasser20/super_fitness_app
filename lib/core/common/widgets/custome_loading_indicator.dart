import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import '../../theme/app_colors.dart';

class AppLoadingIndicator extends StatelessWidget {
  final double size;
  final Color color;

  const AppLoadingIndicator({
    super.key,
    this.size = 80,
    this.color = AppColors.main,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: size,
        width: size,
        child: LoadingIndicator(
          indicatorType: Indicator.lineScalePulseOut,
          colors: [color],
          strokeWidth: 2,
          backgroundColor: Colors.transparent,
        ),
      ),
    );
  }
}
