import 'dart:ui';
import 'package:flutter/material.dart';

class ContainerWithBlurWidget extends StatelessWidget {
  const ContainerWithBlurWidget({
    super.key,
    required this.child,
    this.blurIntensity = 15.0,
    this.borderRadius = 50.0,
    this.padding = const EdgeInsets.all(20.0),
    this.width,
    this.isCenterWidget = false,
  });

  final Widget child;
  final double blurIntensity;
  final double borderRadius;
  final EdgeInsetsGeometry padding;
  final double? width;
  final bool isCenterWidget;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
          border: Border.all(
            color: Colors.white.withValues(alpha: 0.8),
            width: 1.0,
          ),
        ),
        child: Stack(
          children: [
            BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: blurIntensity,
                sigmaY: blurIntensity,
              ),
              child: Container(color: Colors.transparent),
            ),
            Padding(
              padding: padding,
              child: isCenterWidget ? Center(child: child) : child,
            ),
          ],
        ),
      ),
    );
  }
}
