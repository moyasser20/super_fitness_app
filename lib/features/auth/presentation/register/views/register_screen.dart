import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:super_fitness_app/core/contants/app_images.dart';
import 'package:super_fitness_app/core/widgets/custom_elevated_button.dart';
import 'package:super_fitness_app/core/widgets/custom_text_field.dart';

import '../../../../../core/common/widgets/container_with_blur_widget.dart';
import '../../../../../core/contants/app_icons.dart';
import '../../../../../core/theme/app_colors.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}


class _RegisterScreenState extends State<RegisterScreen> {
  final formKey = GlobalKey<FormState>();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppImages.fitnessBc),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SafeArea(
                child: Center(
                  child: Image.asset(AppIcons.fitnessLogo, width: 90),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                "Hey There",
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
              const Text(
                "CREATE AN ACCOUNT",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 20),
              ContainerWithBlurWidget(
                child: Column(
                  children: [
                    Text(
                      'Register',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 20),

                    CustomTextFormField(
                      hint: 'firstName',
                      controller: firstNameController,
                      prefixIcon: Icon(
                        Icons.person_outline_sharp,
                        color: AppColors.white,
                      ),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your first name';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    CustomTextFormField(
                      hint: 'lastName',
                      controller: lastNameController,
                      prefixIcon: Icon(
                        Icons.person_outline_sharp,
                        color: AppColors.white,
                      ),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your last name';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    CustomTextFormField(
                      hint: 'Email',
                      controller: emailController,
                      prefixIcon: Icon(
                        Icons.email_outlined,
                        color: AppColors.white,
                      ),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    CustomTextFormField(
                      hint: 'Password',
                      controller: passwordController,
                      prefixIcon: Icon(
                        Icons.lock_outline_sharp,
                        color: AppColors.white,
                      ),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 50),
                    CustomElevatedButton(
                      width: double.infinity,
                      color: AppColors.main,
                      text: 'Register',
                      onPressed: () {},
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Already have an account?',
                          style: TextStyle(
                            color: AppColors.white,
                            fontSize: 16,
                          ),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: Text(
                            'Login',
                            style: TextStyle(
                              color: AppColors.main[20],
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline,
                              decorationColor: AppColors.main[20],
                              decorationThickness: 0.8,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
