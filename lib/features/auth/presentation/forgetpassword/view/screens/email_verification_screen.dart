import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../core/common/widgets/container_with_blur_widget.dart';
import '../../../../../../core/contants/app_icons.dart';
import '../../../../../../core/contants/app_images.dart';
import '../../../../../../core/l10n/translation/app_localizations.dart';
import '../../../../../../core/routes/route_names.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/widgets/custom_elevated_button.dart';
import '../../viewmodel/verify_code_viewmodel.dart';
import '../../viewmodel/states/verify_code_states.dart';
import '../widgets/verification_code_field.dart';

class EmailVerificationScreen extends StatefulWidget {
  final String email;
  const EmailVerificationScreen({super.key, required this.email});

  @override
  State<EmailVerificationScreen> createState() => _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (widget.email != "") {
      context.read<VerifyCodeCubit>().setEmail(widget.email);
    }
  }

  @override
  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;

    return BlocConsumer<VerifyCodeCubit, VerifyCodeStates>(
      listener: (context, state) {
        if (state is VerifyCodeSuccessStates) {
          Navigator.pushNamed(
            context,
            AppRoutes.resetPassword,
            arguments: widget.email,
          );
        } else if (state is VerifyCodeErrorStates) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.red,
            ),
          );
        } else if (state is VerifyCodeResendStates) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(local.resendCode),
              backgroundColor: Colors.green,
            ),
          );
        }
      },
      builder: (context, state) {
        final cubit = context.watch<VerifyCodeCubit>();

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
                      local.otpCode,
                      style: const TextStyle(
                        fontSize: 22,
                        color: AppColors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      local.enterOtpMessage,
                      style: const TextStyle(fontSize: 16, color: AppColors.white),
                    ),
                    const SizedBox(height: 20),
                    ContainerWithBlurWidget(
                      child: Column(
                        children: [
                          const SizedBox(height: 10),
                          VerificationCodeField(
                            onCodeChanged: (code) => cubit.updateCode(code),
                          ),
                          const SizedBox(height: 30),
                          CustomElevatedButton(
                            width: double.infinity,
                            color: AppColors.main,
                            text: local.confirm,
                            isLoading: state is VerifyCodeLoadingStates,
                            onPressed: () => cubit.verify(context),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            local.didntReceiveCode,
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: 5),
                          GestureDetector(
                            onTap: cubit.isResendEnabled
                                ? () => cubit.resendCode()
                                : null,
                            child: Text(
                              local.resendCode,
                              style: TextStyle(
                                color: cubit.isResendEnabled
                                    ? Colors.redAccent
                                    : Colors.grey,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(height: 5),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
