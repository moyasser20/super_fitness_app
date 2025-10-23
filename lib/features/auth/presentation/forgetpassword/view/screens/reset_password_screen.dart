import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../core/Widgets/custom_Elevated_Button.dart';
import '../../../../../../core/Widgets/custom_text_field.dart';
import '../../../../../../core/common/widgets/container_with_blur_widget.dart';
import '../../../../../../core/contants/app_icons.dart';
import '../../../../../../core/contants/app_images.dart';
import '../../../../../../core/extensions/validations.dart';
import '../../../../../../core/l10n/translation/app_localizations.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../viewmodel/reset_password_viewmodel.dart';
import '../../viewmodel/states/reset_code_states.dart';

class ResetPasswordScreen extends StatefulWidget {
  final String email;
  const ResetPasswordScreen({super.key, required this.email});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    context.read<ResetPasswordCubit>().initializeListeners();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    context.read<ResetPasswordCubit>().setEmail(widget.email);
  }

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;

    return BlocConsumer<ResetPasswordCubit, ResetPasswordState>(
      listener: (context, state) {
        if (state is ResetPasswordSuccessState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(local.passwordResetSuccess),
              backgroundColor: Colors.green,
            ),
          );
          Navigator.popUntil(context, (route) => route.isFirst);
        } else if (state is ResetPasswordErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      builder: (context, state) {
        final cubit = context.watch<ResetPasswordCubit>();

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
                              controller: cubit.passwordController,
                              hint: local.newPasswordHint,
                              obscureText: true,
                              prefixIcon: Icon(
                                Icons.lock_outline_sharp,
                                color: AppColors.white.withValues(alpha: 0.5),
                              ),
                              keyboardType: TextInputType.visiblePassword,
                              validator: cubit.validatePassword,
                            ),
                            const SizedBox(height: 25),
                            CustomTextFormField(
                              controller: cubit.confirmPasswordController,
                              hint: local.confirmPasswordHint,
                              obscureText: true,
                              prefixIcon: Icon(
                                Icons.lock_outline_sharp,
                                color: AppColors.white.withValues(alpha: 0.5),
                              ),
                              keyboardType: TextInputType.visiblePassword,
                              validator: cubit.validateConfirmPassword,
                            ),
                            const SizedBox(height: 25),
                            CustomElevatedButton(
                              width: double.infinity,
                              isLoading: state is ResetPasswordLoadingState,
                              onPressed: cubit.isFormValid
                                  ? () {
                                if (_formKey.currentState!.validate()) {
                                  cubit.resetPassword();
                                }
                              }
                                  : null,
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
      },
    );
  }
}
