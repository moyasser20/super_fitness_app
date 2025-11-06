import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_fitness_app/core/common/widgets/container_with_blur_widget.dart';
import 'package:super_fitness_app/core/common/widgets/custome_loading_indicator.dart';
import 'package:super_fitness_app/core/extensions/extensions.dart';
import 'package:super_fitness_app/core/utils/styles.dart';
import '../../../../../../core/common/widgets/custom_snackbar_widget.dart';
import '../../../../../../core/contants/app_icons.dart';
import '../../../../../../core/contants/app_images.dart';
import '../../../../../../core/contants/secure_storage.dart';
import '../../../../../../core/extensions/validations.dart';
import '../../../../../../core/l10n/translation/app_localizations.dart';
import '../../../../../../core/routes/route_names.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/widgets/custom_elevated_button.dart';
import '../../../../../../core/widgets/custom_text_field.dart';
import '../viewmodel/login_states.dart';
import '../viewmodel/login_viewmodel.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoadingCredentials = true;
  bool _rememberMe = false;

  @override
  void initState() {
    super.initState();
    _loadRememberedCredentials();
  }

  Future<void> _loadRememberedCredentials() async {
    final viewModel = context.read<LoginViewModel>();

    // Check if we're coming from a logout by checking if token exists
    final hasToken = await SecureStorage.read('auth_token') != null;

    if (!hasToken) {
      // If no token exists, we're likely coming from logout - clear fields
      viewModel.clearFormFields();
    } else {
      // Only load remembered credentials if we have a token
      await viewModel.loadRememberedCredentials();
    }

    setState(() {
      _rememberMe = viewModel.rememberMe;
      _isLoadingCredentials = false;
    });
  }

  void _toggleRememberMe(bool value) {
    setState(() {
      _rememberMe = value;
    });
    final viewModel = context.read<LoginViewModel>();
    viewModel.toggleRememberMe(value);
  }

  @override
  Widget build(BuildContext context) {
    var local = AppLocalizations.of(context);

    return Scaffold(
      body: BlocConsumer<LoginViewModel, LoginStates>(
        listener: (context, state) {
          if (state is LoginLoadingState) {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (_) => AppLoadingIndicator(color: AppColors.orange),
            );
          } else if (state is LoginSuccessState) {
            Navigator.pop(context);
            Navigator.pushNamedAndRemoveUntil(
              context,
              AppRoutes.dashboard,
              (route) => false,
            );
          } else if (state is LoginErrorState) {
            Navigator.pop(context);
            showCustomSnackBar(context, state.errorMsg, isError: true);
          }
        },
        builder: (BuildContext context, LoginStates state) {
          final viewModel = context.read<LoginViewModel>();

          if (_isLoadingCredentials) {
            return Scaffold(
              backgroundColor: AppColors.black,
              body: Center(child: AppLoadingIndicator(color: AppColors.orange)),
            );
          }

          return Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(AppImages.fitnessBc),
                fit: BoxFit.cover,
              ),
            ),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20),
                    SafeArea(
                      child: Center(
                        child: Image.asset(AppIcons.fitnessLogo, width: 90),
                      ),
                    ),
                    const SizedBox(height: 80),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Text(
                        local!.greeting,
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Text(
                        local.welcomeBack,
                        style: const TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w800,
                          fontFamily: "Inter",
                          fontStyle: FontStyle.normal,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(height: 26),
                    ContainerWithBlurWidget(
                      child: Column(
                        children: [
                          Text(
                            local.login,
                            style: const TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.w800,
                              fontFamily: "Inter",
                              fontStyle: FontStyle.normal,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 20),
                          CustomTextFormField(
                            controller: viewModel.emailController,
                            label: local.emailLabel,
                            hint: local.emailHintText,
                            prefixIcon: const Icon(
                              Icons.email_outlined,
                              color: Color(0xffD9D9D9),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return local.emailIsEmptyErrorMessage;
                              }
                              if (!Validations.validateEmail(value)) {
                                return local.emailValidationErrorMsg;
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 18),
                          CustomTextFormField(
                            controller: viewModel.passwordController,
                            label: local.passwordLabel,
                            hint: local.passwordHintText,
                            obscureText: true,
                            prefixIcon: const Icon(
                              Icons.lock_outline_sharp,
                              color: Color(0xffD9D9D9),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return local.passwordRequiredErrorMsg;
                              }
                              // if (!Validations.validatePassword(value)) {
                              //   return local.passwordValidationErrorMsg;
                              // }
                              return null;
                            },
                          ),
                          const SizedBox(height: 5),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Checkbox(
                                    checkColor: AppColors.white,
                                    activeColor: AppColors.orange,

                                    value: _rememberMe,
                                    onChanged: (value) {
                                      _toggleRememberMe(value ?? false);
                                    },
                                  ),
                                  Text(
                                    local.rememberMe,
                                    style: balooThambi2Medium,
                                  ),
                                ],
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.pushNamed(
                                    context,
                                    AppRoutes.forgetPassword,
                                  );
                                },
                                child: Text(
                                  local.forgetPasswordTextButton,
                                  style: TextStyle(
                                    color: AppColors.orange,
                                    decoration: TextDecoration.underline,
                                    decorationThickness: 1.8,
                                    fontWeight: FontWeight.w400,
                                    decorationColor: AppColors.orange,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 30),
                          CustomElevatedButton(
                            width: double.infinity,
                            text: local.login,
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                viewModel.login(
                                  viewModel.emailController.text.trim(),
                                  viewModel.passwordController.text.trim(),
                                );
                              }
                            },
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                local.dontHaveAnAccount,
                                style: const TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.pushNamed(
                                    context,
                                    AppRoutes.register,
                                  );
                                },
                                child: Text(
                                  local.signUp,
                                  style: TextStyle(
                                    color: AppColors.orange,
                                    decoration: TextDecoration.underline,
                                    decorationThickness: 1.5,
                                    decorationColor: AppColors.orange,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ).setHorizontalPadding(context, 0.02),
              ),
            ),
          );
        },
      ),
    );
  }
}
