import 'package:flutter/material.dart';
import 'package:super_fitness_app/core/Widgets/custom_text_field.dart';
import 'package:super_fitness_app/core/extensions/extensions.dart';
import 'package:super_fitness_app/core/theme/app_colors.dart';
import 'package:super_fitness_app/core/utils/styles.dart';
import 'package:super_fitness_app/core/l10n/translation/app_localizations.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/profile_bg.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 55),

              Row(
                children: [
                  Image.asset(
                    "assets/icons/back_fitness_icon.png",
                    height: 30,
                  ),
                  const SizedBox(width: 100),
                  Text(
                    locale.editProfile,
                    style: balooThambi2RegularLarge.copyWith(fontSize: 26),
                  ),
                  const Spacer(flex: 2),
                ],
              ),
              const SizedBox(height: 50),

              Stack(
                alignment: Alignment.center,
                children: [
                  const CircleAvatar(
                    radius: 60,
                    backgroundImage: AssetImage("assets/images/test_food.png"),
                    backgroundColor: AppColors.grey,
                  ),
                  Positioned(
                    bottom: 95,
                    right: 2,
                    child: Image.asset(
                      "assets/images/edit_photo_pen.png",
                      width: 28,
                      height: 28,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              Text(
                "Mohamed Yasser",
                style: balooThambi2RegularLarge.copyWith(
                  fontSize: 22,
                  color: AppColors.white,
                ),
              ),
              const SizedBox(height: 50),

              CustomTextFormField(
                hint: "Mohamed",
                prefixIcon: Icon(
                  Icons.person_2_outlined,
                  color: AppColors.white.withOpacity(0.5),
                ).setHorizontalPadding(context, 0.06),
              ),
              const SizedBox(height: 20),

              CustomTextFormField(
                hint: "Yasser",
                prefixIcon: Icon(
                  Icons.person_2_outlined,
                  color: AppColors.white.withOpacity(0.5),
                ).setHorizontalPadding(context, 0.06),
              ),
              const SizedBox(height: 20),

              CustomTextFormField(
                hint: "moyasser@gmail.com",
                prefixIcon: Icon(
                  Icons.email_outlined,
                  color: AppColors.white.withOpacity(0.5),
                ).setHorizontalPadding(context, 0.06),
              ),
              const SizedBox(height: 50),

              Row(
                children: [
                  Text(
                    locale.yourWeight,
                    style: balooThambi2Bold.copyWith(
                      fontSize: 18,
                      color: AppColors.white,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Text(
                      locale.tapToEdit,
                      style: balooThambi2Bold.copyWith(
                        fontSize: 18,
                        color: AppColors.orange,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              CustomTextFormField(
                readonly: true,
                fillColor: AppColors.white.withOpacity(0.15),
                hintColor: AppColors.white,
                hint: "90 ${locale.kilo}",
              ),
              const SizedBox(height: 30),

              Row(
                children: [
                  Text(
                    locale.yourGoal,
                    style: balooThambi2Bold.copyWith(
                      fontSize: 18,
                      color: AppColors.white,
                    ),
                  ),
                  Text(
                    locale.tapToEdit,
                    style: balooThambi2Bold.copyWith(
                      fontSize: 18,
                      color: AppColors.orange,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              CustomTextFormField(
                readonly: true,
                fillColor: AppColors.white.withOpacity(0.15),
                hintColor: AppColors.white,
                hint: locale.gainWeight,
              ),
              const SizedBox(height: 30),

              Row(
                children: [
                  Text(
                    locale.yourActivityLevel,
                    style: balooThambi2Bold.copyWith(
                      fontSize: 18,
                      color: AppColors.white,
                    ),
                  ),
                  Text(
                    locale.tapToEdit,
                    style: balooThambi2Bold.copyWith(
                      fontSize: 18,
                      color: AppColors.orange,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              CustomTextFormField(
                readonly: true,
                fillColor: AppColors.white.withOpacity(0.15),
                hintColor: AppColors.white,
                hint: locale.rookie, // "Rookie"
              ),

              const SizedBox(height: 50),
            ],
          ).setHorizontalPadding(context, 0.06),
        ),
      ),
    );
  }
}
