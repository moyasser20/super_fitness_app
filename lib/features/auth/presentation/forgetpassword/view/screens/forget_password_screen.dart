import 'package:flutter/material.dart';
import 'package:super_fitness_app/core/theme/app_colors.dart';

import '../../../../../../core/common/widgets/container_with_blur_widget.dart';
import '../../../../../../core/contants/app_icons.dart';
import '../../../../../../core/contants/app_images.dart';
import '../../../../../../core/l10n/translation/app_localizations.dart';
import '../../../../../../core/routes/route_names.dart';
import '../../../../../../core/widgets/custom_elevated_button.dart';
import '../../../../../../core/widgets/custom_text_field.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});

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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SafeArea(
                child: Center(
                  child: Image.asset(AppIcons.fitnessLogo, width: 90),
                ),
              ),
              const SizedBox(height: 100),
              Text(
                local.enterYourEmail,
                style: const TextStyle(fontSize: 18, color:  AppColors.white),
              ),
              const SizedBox(height: 5),
              Text(
                local.forgetPassword,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color:  AppColors.white,
                ),
              ),
              const SizedBox(height: 20),
              ContainerWithBlurWidget(
                child: Column(
                  children: [
                    CustomTextFormField(
                      hint: local.emailHint,
                      controller: TextEditingController(),
                      prefixIcon: Icon(Icons.email_outlined, color: AppColors.white.withOpacity(0.5)),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return local.emailValidation;
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 30),
                    CustomElevatedButton(
                      width: double.infinity,
                      color: AppColors.main,
                      text: local.sendOtp,
                      onPressed: () {
                        Navigator.pushNamed(context, AppRoutes.emailVerification);
                      },
                    ),
                    const SizedBox(height: 10),
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
