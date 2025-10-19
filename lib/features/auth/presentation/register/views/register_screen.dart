import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_fitness_app/core/common/widgets/custom_snackbar_widget.dart';
import 'package:super_fitness_app/core/contants/app_images.dart';
import 'package:super_fitness_app/core/theme/app_colors.dart';
import 'package:super_fitness_app/core/widgets/custom_elevated_button.dart';
import 'package:super_fitness_app/core/widgets/custom_text_field.dart';
import '../../../../../core/common/widgets/container_with_blur_widget.dart';
import '../../../../../core/contants/app_icons.dart';
import '../viewmodel/register_viewmodel/register_cubit.dart';

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
  final rePasswordController = TextEditingController();

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    rePasswordController.dispose();
    super.dispose();
  }

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
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
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
                          hint: 'First Name',
                          controller: firstNameController,
                          prefixIcon: const Icon(
                            Icons.person_outline_sharp,
                            color: Colors.white,
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your first name';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        CustomTextFormField(
                          hint: 'Last Name',
                          controller: lastNameController,
                          prefixIcon: const Icon(
                            Icons.person_outline_sharp,
                            color: Colors.white,
                          ),
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
                          prefixIcon: const Icon(
                            Icons.email_outlined,
                            color: Colors.white,
                          ),
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your email';
                            }
                            if (!RegExp(
                              r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                            ).hasMatch(value)) {
                              return 'Please enter a valid email';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        CustomTextFormField(
                          hint: 'Password',
                          controller: passwordController,
                          prefixIcon: const Icon(
                            Icons.lock_outline_sharp,
                            color: Colors.white,
                          ),
                          obscureText: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your password';
                            }
                            if (value.length < 6) {
                              return 'Password must be at least 6 characters';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        CustomTextFormField(
                          hint: 'Confirm Password',
                          controller: rePasswordController,
                          prefixIcon: const Icon(
                            Icons.lock_outline_sharp,
                            color: Colors.white,
                          ),
                          obscureText: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please confirm your password';
                            }
                            if (value != passwordController.text) {
                              return 'Passwords do not match';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 40),

                        BlocConsumer<RegisterCubit, RegisterState>(
                          listener: (context, state) {
                            if (state is RegisterError) {
                              showCustomSnackBar(context, state.message);
                            }

                            if (state is RegisterLoaded) {
                              showCustomSnackBar(
                                context,
                                state.registerResponse.message,
                                isError: false
                              );
                            }
                          },
                          builder: (context, state) {
                            return CustomElevatedButton(
                              width: double.infinity,
                              color: AppColors.main,
                              isLoading: state is RegisterLoading,
                              text: 'Register',
                              onPressed:
                                  state is RegisterLoading ? () {} : _register,
                            );
                          },
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Already have an account?',
                              style: TextStyle(
                                color: Colors.white,
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
        ),
      ),
    );
  }

  void _register() {
    if (!formKey.currentState!.validate()) return;

    context.read<RegisterCubit>().register(
      firstName: firstNameController.text.trim(),
      lastName: lastNameController.text.trim(),
      email: emailController.text.trim(),
      password: passwordController.text,
      rePassword: rePasswordController.text,
    );
  }
}
