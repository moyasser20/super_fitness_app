import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/Widgets/custom_Elevated_Button.dart';
import '../../../../core/routes/route_names.dart';
import '../../../auth/domain/services/auth_services.dart';

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
          borderRadius: BorderRadius.circular(25.0),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 25.0, sigmaY: 25.0),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 12),
              width: 311.0,
              height: 90.0,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.white.withOpacity(0.18),
                    Colors.white.withOpacity(0.05),
                    Colors.white.withOpacity(0.02),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),

                boxShadow: [
                  BoxShadow(
                    color: Colors.white.withOpacity(0.05),
                    offset: const Offset(-2, -2),
                    blurRadius: 6,
                  ),
                  BoxShadow(
                    color: Colors.black.withOpacity(0.4),
                    offset: const Offset(3, 3),
                    blurRadius: 10,
                  ),
                ],
                border: Border.all(
                  color: Colors.white.withOpacity(0.25),
                  width: 1.2,
                ),
                borderRadius: BorderRadius.circular(25.0),
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
              key: const Key('explorePageText'),
              style: theme.textTheme.titleLarge?.copyWith(color: Colors.white),
            ),
          ),
          Center(
            child: Text(
              'Chat page',
              key: const Key('chatPageText'),
              style: theme.textTheme.titleLarge?.copyWith(color: Colors.white),
            ),
          ),
          Center(
            child: Text(
              'Workout page',
              key: const Key('workoutPageText'),
              style: theme.textTheme.titleLarge?.copyWith(color: Colors.white),
            ),
          ),
          Center(
            child: CustomElevatedButton(
              text: "Logout",
              onPressed: () async {
                await AuthService.logout();
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  AppRoutes.login,
                  (route) => false,
                );
              },
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
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedScale(
            scale: isSelected ? 1.15 : 1.0,
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeOutBack,
            child: SvgPicture.asset(
              imagePath,
              width: width,
              height: height,
              colorFilter: ColorFilter.mode(
                isSelected ? Colors.deepOrangeAccent : Colors.white70,
                BlendMode.srcIn,
              ),
            ),
          ),
          const SizedBox(height: 4),
          AnimatedOpacity(
            opacity: isSelected ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 200),
            child: Text(
              label,
              style: const TextStyle(
                color: Colors.deepOrangeAccent,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
