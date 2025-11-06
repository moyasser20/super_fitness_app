import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:super_fitness_app/core/common/widgets/container_with_blur_widget.dart';
import 'package:super_fitness_app/core/theme/app_colors.dart';
import 'package:super_fitness_app/core/widgets/custom_elevated_button.dart';
import '../../core/contants/app_images.dart';
import '../../core/contants/prefs.dart';
import '../../core/routes/route_names.dart';

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
  int currentIndex = 0;
  List<OnBoardModel> onboard = [
    OnBoardModel(
      image: "assets/images/onboard-1.png",
      title: "The Price Of Excellence\nIs Discipline",
      body:
          "Our fitness app is designed to help you achieve your fitness goals and maintain a healthy lifestyle.With a wide range of exercises and personalized workout plans",
    ),
    OnBoardModel(
      image: "assets/images/onboard-2.png",
      title: "Fitness Has Never Been So\nMuch Fun",
      body:
          "Our fitness app is designed to help you stay fit and active on the go. With a wide range of exercises and workouts, you can train anywhere, anytime. ",
    ),
    OnBoardModel(
      image: "assets/images/onboard-3.png",
      title: "NO MORE EXCUSES\nDo It Now",
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
    Navigator.pushNamedAndRemoveUntil(
      context,
      AppRoutes.login,
      (Route<dynamic> route) => false,
    );
  }

  void _completeOnboarding() async {
    log('=== COMPLETING ONBOARDING ===');
    await Prefs.setOnboardingSeen();
    final bool check = Prefs.isOnboardingSeen();
    log('Onboarding marked as seen: $check');
    Navigator.pushNamedAndRemoveUntil(
      context,
      AppRoutes.login,
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
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppImages.fitnessBc),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SafeArea(
                  child: TextButton(
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
                ),
                Expanded(
                  child: PageView.builder(
                    onPageChanged: (index) {
                      setState(() {
                        currentIndex = index;
                        isLast = index == onboard.length - 1;
                      });
                    },
                    controller: boardController,
                    physics: const BouncingScrollPhysics(),
                    itemCount: onboard.length,
                    itemBuilder: (context, index) {
                      return Image.asset(
                        onboard[index].image,
                        fit: BoxFit.contain,
                        height: screenHeight * 0.8,
                        width: double.infinity,
                      );
                    },
                  ),
                ),
                SizedBox(height: screenHeight * 0.3),
              ],
            ),
            Positioned(
              bottom: 0,
              left: screenWidth * 0,
              right: screenWidth * 0,
              child: SizedBox(
                height: screenHeight * 0.35,
                child: _buildBottomContainer(screenHeight, screenWidth),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomContainer(double screenHeight, double screenWidth) {
    return ContainerWithBlurWidget(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            onboard[currentIndex].title,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: screenHeight * 0.01),
          Text(
            onboard[currentIndex].body,
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
          currentIndex != 0
              ? Row(
                children: [
                  CustomElevatedButton(
                    color: Colors.transparent,
                    width: screenWidth * 0.2,
                    borderColor: AppColors.orange,
                    text: "Back",
                    onPressed: () {
                      boardController.previousPage(
                        duration: const Duration(milliseconds: 750),
                        curve: Curves.fastLinearToSlowEaseIn,
                      );
                    },
                  ),
                  Spacer(),
                  CustomElevatedButton(
                    width: screenWidth * 0.2,
                    color: AppColors.main,
                    text: isLast ? "Do it" : "Next",
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
              )
              : CustomElevatedButton(
                width: double.infinity,
                color: AppColors.main,
                text: "Next",
                onPressed: () {
                  boardController.nextPage(
                    duration: const Duration(milliseconds: 750),
                    curve: Curves.fastLinearToSlowEaseIn,
                  );
                },
              ),
        ],
      ),
    );
  }
}
