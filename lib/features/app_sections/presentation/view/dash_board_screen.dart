import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:super_fitness_app/features/workouts/presentation/view/workouts_screen.dart';
import 'package:super_fitness_app/core/theme/app_colors.dart';
import 'package:super_fitness_app/features/home/presentation/views/home_screen.dart';
import '../../../../core/Widgets/custom_Elevated_Button.dart';
import '../../../../core/contants/app_icons.dart';
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
  final ScrollController _scrollController = ScrollController();
  bool _showNavBar = true;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_handleScroll);
  }

  void _handleScroll() {
    if (_scrollController.position.userScrollDirection ==
        ScrollDirection.reverse) {
      if (_showNavBar) setState(() => _showNavBar = false);
    } else if (_scrollController.position.userScrollDirection ==
        ScrollDirection.forward) {
      if (!_showNavBar) setState(() => _showNavBar = true);
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_handleScroll);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          IndexedStack(
            index: currentPageIndex,
            children: <Widget>[
              HomeScreen(scrollController: _scrollController),
              Center(
                child: Text(
                  'Chat page',
                  key: const Key('chatPageText'),
                  style: theme.textTheme.titleLarge?.copyWith(
                    color: Colors.white,
                  ),
                ),
              ),
              WorkoutsScreen(isFromHome: false),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
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
            ],
          ),

          AnimatedPositioned(
            duration: const Duration(milliseconds: 250),
            left: 0,
            right: 0,
            bottom: _showNavBar ? 30 : -110,
            child: Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(25.0),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 35,
                    vertical: 12,
                  ),
                  width: 334.0,
                  height: 90.0,
                  decoration: const BoxDecoration(color: Color(0xff242424)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildNavItem(
                        imagePath: AppIcons.homeIcon,
                        label: 'Explore',
                        index: 0,
                      ),
                      _buildNavItem(
                        imagePath: AppIcons.chatIcon,
                        label: 'Chat',
                        index: 1,
                      ),
                      _buildNavItem(
                        imagePath: AppIcons.workoutIcon,
                        label: 'Workouts',
                        index: 2,
                      ),
                      _buildNavItem(
                        imagePath: AppIcons.profileIcon,
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
                isSelected ? AppColors.orange : Colors.white,
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
                color: AppColors.orange,
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
