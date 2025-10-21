import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_fitness_app/core/contants/app_images.dart';
import 'package:super_fitness_app/core/theme/app_colors.dart';
import 'package:super_fitness_app/core/widgets/custom_elevated_button.dart';
import 'package:super_fitness_app/core/widgets/custom_text_field.dart';
import '../../../../../core/common/widgets/container_with_blur_widget.dart';
import '../../../../../core/contants/app_icons.dart';
import '../../../../../core/l10n/translation/app_localizations.dart';
import '../../../../../core/routes/route_names.dart';
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

  void _startRegistrationFlow() {
    if (!formKey.currentState!.validate()) return;

    context.read<RegisterCubit>().setPersonalInfo(
      firstName: firstNameController.text.trim(),
      lastName: lastNameController.text.trim(),
      email: emailController.text.trim(),
      password: passwordController.text,
      rePassword: rePasswordController.text,
    );

    Navigator.pushNamed(context, AppRoutes.completeRegistration);
  }

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context);
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
                  Text(
                    locale!.hey_there,
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                  Text(
                    locale.create_account,
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
                          locale.title,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 20),
                        CustomTextFormField(
                          hint: locale.hint_first_name,
                          controller: firstNameController,
                          prefixIcon: const Icon(
                            Icons.person_outline_sharp,
                            color: Colors.white,
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return locale.error_first_name;
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        CustomTextFormField(
                          hint: locale.hint_last_name,
                          controller: lastNameController,
                          prefixIcon: const Icon(
                            Icons.person_outline_sharp,
                            color: Colors.white,
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return locale.error_last_name;
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        CustomTextFormField(
                          hint: locale.hint_email,
                          controller: emailController,
                          prefixIcon: const Icon(
                            Icons.email_outlined,
                            color: Colors.white,
                          ),
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return locale.error_email;
                            }
                            if (!RegExp(
                              r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                            ).hasMatch(value)) {
                              return locale.error_email_invalid;
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        CustomTextFormField(
                          hint: locale.hint_password,
                          controller: passwordController,
                          prefixIcon: const Icon(
                            Icons.lock_outline_sharp,
                            color: Colors.white,
                          ),
                          obscureText: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return locale.error_password;
                            }
                            if (value.length < 6) {
                              return locale.error_password_short;
                            }
                            if (!RegExp(
                              r'^(?=.*[A-Z])(?=.*[^A-Za-z0-9]).{7,}$',
                            ).hasMatch(value)) {
                              return locale.error_password_invalid;
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        CustomTextFormField(
                          hint: locale.hint_confirm_password,
                          controller: rePasswordController,
                          prefixIcon: const Icon(
                            Icons.lock_outline_sharp,
                            color: Colors.white,
                          ),
                          obscureText: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return locale.error_confirm_password;
                            }
                            if (value != passwordController.text) {
                              return locale.error_passwords_not_match;
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 30),
                        CustomElevatedButton(
                          width: double.infinity,
                          color: AppColors.main,
                          text: locale.btn_continue,
                          onPressed: _startRegistrationFlow,
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              locale.already_have_account,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pushNamed(context, AppRoutes.login);
                              },
                              child: Text(
                                locale.btn_login,
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
}
