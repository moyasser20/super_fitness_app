import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:super_fitness_app/core/common/widgets/container_with_blur_widget.dart';
import 'package:super_fitness_app/core/theme/app_colors.dart';
import 'package:super_fitness_app/core/widgets/custom_elevated_button.dart';
import 'package:super_fitness_app/features/auth/presentation/register/views/register_screen.dart';
import '../../core/contants/prefs.dart';

class OnBoardModel {
  final String image;
  final String title;
  final String body;

  OnBoardModel({required this.image, required this.title, required this.body});
}

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  List<OnBoardModel> onboard = [
    OnBoardModel(
      image: "assets/images/onboard-1.png",
      title: "Stay Fit and Active",
      body:
          "Our fitness app is designed to help you achieve your fitness goals and maintain a healthy lifestyle.With a wide range of exercises and personalized workout plans",
    ),
    OnBoardModel(
      image: "assets/images/onboard-2.png",
      title: "Transform Your Body",
      body:
          "Our fitness app is designed to help you stay fit and active on the go. With a wide range of exercises and workouts, you can train anywhere, anytime. ",
    ),
    OnBoardModel(
      image: "assets/images/onboard-3.png",
      title: "Achieve Your Fitness Goals",
      body:
          "Are you looking to lose weight, build muscle, or improve your overall fitness? Our fitness app is here to help you achieve your goals. With a library of workouts",
    ),
  ];

  var boardController = PageController();
  bool isLast = false;

  void _skipOnboarding() async {
    log('=== SKIPPING ONBOARDING ===');
    await Prefs.setOnboardingSeen();
    final bool check = Prefs.isOnboardingSeen();
    log('Onboarding marked as seen: $check');
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const RegisterScreen()),
      (Route<dynamic> route) => false,
    );
  }

  void _completeOnboarding() async {
    log('=== COMPLETING ONBOARDING ===');
    await Prefs.setOnboardingSeen();
    final bool check = Prefs.isOnboardingSeen();
    log('Onboarding marked as seen: $check');
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const RegisterScreen()),
      (Route<dynamic> route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenHeight = mediaQuery.size.height;
    final screenWidth = mediaQuery.size.width;

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          TextButton(
            onPressed: _skipOnboarding,
            child: Text(
              "Skip",
              style: TextStyle(
                color: AppColors.white,
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/board-bg.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final maxHeight = constraints.maxHeight;
            final maxWidth = constraints.maxWidth;

            return Padding(
              padding: EdgeInsets.all(maxWidth * 0.03),
              child: Column(
                children: [
                  SizedBox(height: maxHeight * 0.02),
                  Expanded(
                    child: PageView.builder(
                      onPageChanged: (index) {
                        setState(() {
                          isLast = index == onboard.length - 1;
                        });
                      },
                      controller: boardController,
                      physics: const BouncingScrollPhysics(),
                      itemCount: onboard.length,
                      itemBuilder: (context, index) {
                        return buildOnBoardingWidget(
                          onboard[index],
                          isLast,
                          screenHeight,
                          screenWidth,
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget buildOnBoardingWidget(
    OnBoardModel model,
    bool isLast,
    double screenHeight,
    double screenWidth,
  ) {
    return Column(
      children: [
        Expanded(
          child: Center(
            child: Image.asset(
              model.image,
              fit: BoxFit.contain,
              height: screenHeight * 0.5,
              width: double.infinity,
            ),
          ),
        ),
        ContainerWithBlurWidget(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                model.title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: screenHeight * 0.02),
              Text(
                model.body,
                textAlign: TextAlign.center,
                style: TextStyle(color: AppColors.white, fontSize: 15),
              ),
              SizedBox(height: screenHeight * 0.02),
              SmoothPageIndicator(
                controller: boardController,
                count: onboard.length,
                effect: ExpandingDotsEffect(
                  dotColor: const Color(0xFFF6F6F6),
                  activeDotColor: AppColors.main,
                  expansionFactor: 2.5,
                  dotHeight: screenHeight * 0.012,
                  dotWidth: screenWidth * 0.03,
                  spacing: screenWidth * 0.05,
                ),
              ),
              SizedBox(height: screenHeight * 0.02),
              CustomElevatedButton(
                width: double.infinity,
                color: AppColors.main,
                text: isLast ? "Get Started" : "Next",
                onPressed: () {
                  if (isLast) {
                    _completeOnboarding();
                  } else {
                    boardController.nextPage(
                      duration: const Duration(milliseconds: 750),
                      curve: Curves.fastLinearToSlowEaseIn,
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
