import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DashboardScreenApp extends StatelessWidget {
  const DashboardScreenApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DashboardScreen(),
    );
  }
}

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      backgroundColor: const Color(0xff222528),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(30.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20.0),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 15.0, sigmaY: 15.0),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 12),
              width: 311.0,
              height: 85.0,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.white.withOpacity(0.10),
                    Colors.white.withOpacity(0.03),
                    Colors.white.withOpacity(0.02),
                    Colors.white.withOpacity(0.10),
                    Colors.white.withOpacity(0.03),
                    Colors.white.withOpacity(0.02),
                    Colors.white.withOpacity(0.10),
                    Colors.white.withOpacity(0.03),
                    Colors.white.withOpacity(0.02),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                border: Border.all(color: Colors.white.withOpacity(0.05)),
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildNavItem(
                    imagePath: 'assets/icons/home.svg',
                    label: 'Explore',
                    index: 0,
                  ),
                  _buildNavItem(
                    imagePath: 'assets/icons/chat_ai.svg',
                    label: 'Chat',
                    index: 1,
                  ),
                  _buildNavItem(
                    imagePath: 'assets/icons/gym.svg',
                    label: 'Workouts',
                    index: 2,
                  ),
                  _buildNavItem(
                    imagePath: 'assets/icons/profile.svg',
                    width: 40,
                    height: 40,
                    label: 'Profile',
                    index: 3,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: IndexedStack(
        index: currentPageIndex,
        children: <Widget>[
          Center(
            child: Text(
              'Explore page',
              style: theme.textTheme.titleLarge?.copyWith(color: Colors.white),
            ),
          ),
          Center(
            child: Text(
              'Chat page',
              style: theme.textTheme.titleLarge?.copyWith(color: Colors.white),
            ),
          ),
          Center(
            child: Text(
              'Workout page',
              style: theme.textTheme.titleLarge?.copyWith(color: Colors.white),
            ),
          ),
          Center(
            child: Text(
              'Profile page',
              style: theme.textTheme.titleLarge?.copyWith(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem({
    required String imagePath,
    required String label,
    required int index,
    double width = 25,
    double height = 25,
  }) {
    final bool isSelected = currentPageIndex == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          currentPageIndex = index;
        });
      },
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              imagePath,
              width: width,
              height: height,
              colorFilter: ColorFilter.mode(
                isSelected ? Colors.deepOrange : Colors.white,
                BlendMode.srcIn,
              ),
            ),
            const SizedBox(height: 4),
            if (isSelected)
              Text(
                label,
                style: const TextStyle(
                  color: Colors.deepOrange,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
