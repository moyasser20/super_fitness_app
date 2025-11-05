import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_fitness_app/core/common/widgets/custom_snackbar_widget.dart';
import '../../../../../core/Widgets/custom_Elevated_Button.dart';
import '../../../../../core/Widgets/custom_text_field.dart';
import '../../../../../core/common/widgets/container_with_blur_widget.dart';
import '../../../../../core/config/di.dart';
import '../../../../../core/contants/app_icons.dart';
import '../../../../../core/contants/app_images.dart';
import '../../../../../core/l10n/translation/app_localizations.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../domain/repo/auth_repo.dart';
import '../viewmodel/change_password_cubit.dart';
import '../viewmodel/change_password_state.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final formKey = GlobalKey<FormState>();
  final oldPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    oldPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  void _changePassword(BuildContext context) {
    if (formKey.currentState!.validate()) {
      final cubit = context.read<ChangePasswordCubit>();
      cubit.changePassword(
        oldPassword: oldPasswordController.text,
        newPassword: newPasswordController.text,
        confirmPassword: confirmPasswordController.text,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context);
    return BlocProvider(
      create: (context) => getIt<ChangePasswordCubit>(),
      child: BlocListener<ChangePasswordCubit, ChangePasswordState>(
        listener: (context, state) {
          if (state is ChangePasswordSuccess) {
            showCustomSnackBar(context, state.message, isError: false);
            Navigator.of(context).pop();
          } else if (state is ChangePasswordError) {
            log(state.message);
            showCustomSnackBar(context, state.message, isError: true);
          }
        },
        child: Scaffold(
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
                        'make sure its 8 characters or more',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                      Text(
                        'create new password',
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
                            CustomTextFormField(
                              hint: 'old password',
                              controller: oldPasswordController,
                              prefixIcon: const Icon(
                                Icons.lock_outline_sharp,
                                color: Colors.white,
                              ),
                              obscureText: true,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your old password';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 20),
                            CustomTextFormField(
                              hint: locale!.hint_password,
                              controller: newPasswordController,
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
                              controller: confirmPasswordController,
                              prefixIcon: const Icon(
                                Icons.lock_outline_sharp,
                                color: Colors.white,
                              ),
                              obscureText: true,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return locale.error_confirm_password;
                                }
                                if (value != newPasswordController.text) {
                                  return locale.error_passwords_not_match;
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 20),
                            BlocBuilder<
                              ChangePasswordCubit,
                              ChangePasswordState
                            >(
                              builder: (context, state) {
                                return CustomElevatedButton(
                                  isLoading: state is ChangePasswordLoading,
                                  width: double.infinity,
                                  color: AppColors.main,
                                  text: locale.done,
                                  onPressed:
                                      state is ChangePasswordLoading
                                          ? null
                                          : () => _changePassword(context),
                                );
                              },
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
        ),
      ),
    );
  }
}
