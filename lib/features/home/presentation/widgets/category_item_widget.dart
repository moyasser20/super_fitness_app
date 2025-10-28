import 'package:flutter/material.dart';

import '../../../../core/utils/styles.dart';

class CategoryItemWidget extends StatelessWidget {
  const CategoryItemWidget({
    super.key,
    required this.catName,
    required this.icon,
    required this.showDivider,
  });

  final String catName;
  final String icon;
  final bool showDivider;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: double.infinity,
      child: Row(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(icon, width: 50, height: 50),
                SizedBox(height: 4),
                Text(catName, style: balooThambi2Regular),
              ],
            ),
          ),
          if (showDivider)
            Container(
              height: MediaQuery.of(context).size.height * 0.08,
              width: 1,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white.withOpacity(0.1),
              ),
            ),
        ],
      ),
    );
  }
}
