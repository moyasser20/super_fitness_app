import 'package:flutter/material.dart';
import '../../../../../../core/Widgets/custom_Elevated_Button.dart';
import '../../../../../../core/Widgets/custom_text_field.dart';
import '../../../../../../core/common/widgets/container_with_blur_widget.dart';
import '../../../../../../core/contants/app_icons.dart';
import '../../../../../../core/contants/app_images.dart';
import '../../../../../../core/extensions/validations.dart';
import '../../../../../../core/l10n/translation/app_localizations.dart';
import '../../../../../../core/theme/app_colors.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();


  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;

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
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SafeArea(
                    child: Center(
                      child: Image.asset(AppIcons.fitnessLogo, width: 90),
                    ),
                  ),
                  const SizedBox(height: 50),
                  Text(
                    local.passwordRequirement,
                    style: const TextStyle(fontSize: 16, color: AppColors.white),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    local.createNewPassword,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 30),
                  ContainerWithBlurWidget(
                    child: Column(
                      children: [
                        const SizedBox(height: 20),
                        CustomTextFormField(
                          controller: _passwordController,
                          hint: local.newPasswordHint,
                          obscureText: true,
                          prefixIcon: Icon(
                            Icons.lock_outline_sharp,
                            color: AppColors.white.withValues(alpha: 0.5),
                          ),
                          keyboardType: TextInputType.visiblePassword,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return local.passwordRequiredError;
                            }
                            if (!Validations.validatePassword(value)) {
                              return local.passwordInvalidError;
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 25),
                        CustomTextFormField(
                          controller: _confirmPasswordController,
                          hint: local.confirmPasswordHint,
                          obscureText: true,
                          prefixIcon: Icon(
                            Icons.lock_outline_sharp,
                            color: AppColors.white.withValues(alpha: 0.5),
                          ),
                          keyboardType: TextInputType.visiblePassword,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return local.passwordRequiredError;
                            }
                            if (!Validations.validateRePassword(
                              _passwordController.text,
                              value,
                            )) {
                              return local.passwordMismatchError;
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 25),
                        CustomElevatedButton(
                          width: double.infinity,
                          onPressed: (){},
                          text: local.done,
                        ),
                        const SizedBox(height: 10),
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
