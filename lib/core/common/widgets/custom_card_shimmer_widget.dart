import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CustomCardShimmerWidget extends StatelessWidget {
  const CustomCardShimmerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width * 0.24;

    return Shimmer.fromColors(
      baseColor: Colors.grey.shade800,
      highlightColor: Colors.grey.shade700,
      child: Container(
        width: width,
        margin: const EdgeInsets.only(right: 16),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.grey.shade900,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 45,
              width: 45,
              decoration: BoxDecoration(
                color: Colors.grey.shade800,
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            const SizedBox(height: 8),
            Container(
              height: 8,
              width: width * 0.6,
              color: Colors.grey.shade800,
            ),
            const SizedBox(height: 4),
            Container(
              height: 8,
              width: width * 0.4,
              color: Colors.grey.shade800,
            ),
          ],
        ),
      ),
    );
  }
}
