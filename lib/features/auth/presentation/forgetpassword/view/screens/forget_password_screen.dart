import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_fitness_app/core/theme/app_colors.dart';

import '../../../../../../core/common/widgets/container_with_blur_widget.dart';
import '../../../../../../core/contants/app_icons.dart';
import '../../../../../../core/contants/app_images.dart';
import '../../../../../../core/l10n/translation/app_localizations.dart';
import '../../../../../../core/routes/route_names.dart';
import '../../../../../../core/widgets/custom_elevated_button.dart';
import '../../../../../../core/widgets/custom_text_field.dart';
import '../../viewmodel/forget_password_viewmodel.dart';
import '../../viewmodel/states/forget_password_states.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final GlobalKey<FormState> _formState = GlobalKey<FormState>();
  late ForgetPasswordCubit _cubit;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _cubit = context.read<ForgetPasswordCubit>();
    _cubit.emailController.addListener(() {
      _cubit.validateEmailField();
    });
  }

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;

    return BlocConsumer<ForgetPasswordCubit, ForgetPasswordStates>(
      listener: (context, state) {
        if (state is ForgetPasswordSuccessState) {
          Navigator.pushNamed(
            context,
            AppRoutes.emailVerification,
            arguments: _cubit.emailController.text,
          );
        } else if (state is ForgetPasswordErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      builder: (context, state) {
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
                    child: Form(
                      key: _formState,
                      child: Column(
                        children: [
                          CustomTextFormField(
                            hint: local.emailHint,
                            controller: _cubit.emailController,
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
                            isLoading: state is ForgetPasswordLoadingState,
                            onPressed: _cubit.isFormValid
                                ? () {
                                    if (_formState.currentState!.validate()) {
                                      _cubit.sendResetCode();
                                    }
                                  }
                                : null,
                          ),
                          const SizedBox(height: 10),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
