import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/Widgets/custom_Elevated_Button.dart';
import '../../../../../core/l10n/translation/app_localizations.dart';
import '../../../../../core/routes/route_names.dart';
import '../../../../../core/theme/app_colors.dart';
import '../viewmodel/logout_states.dart';
import '../viewmodel/logout_viewmodel.dart';

class LogoutDialogWidget extends StatelessWidget {
  const LogoutDialogWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context);

    return BlocConsumer<LogoutViewModel, LogoutStates>(
      listener: (context, state) {
        if (state is LogoutSuccess) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            AppRoutes.login,
            (route) => false,
          );
        } else if (state is LogoutError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      builder: (context, state) {
        return AlertDialog(
          backgroundColor: AppColors.grey,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          title: Text(
            locale!.logoutAlertMsg,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: "BalooThambi2",
              color: AppColors.white,
              fontSize: 20,
            ),
          ),
          content: Text(
            locale.logoutConfirmTextCenter,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: AppColors.white,
              fontSize: 18,
              fontWeight: FontWeight.w500,
              fontFamily: "BalooThambi2",
            ),
          ),
          actions: [
            Row(
              children: [
                CustomElevatedButton(
                  width: 120,
                  height: 50,
                  color: AppColors.white,
                  textColor: AppColors.orange,
                  borderColor: AppColors.orange,
                  text: locale.cancel,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                const SizedBox(width: 20),
                state is LogoutLoading
                    ? const SizedBox(
                      width: 40,
                      height: 40,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: AppColors.orange,
                      ),
                    )
                    : CustomElevatedButton(
                      width: 120,
                      height: 50,
                      text: locale.logout,
                      onPressed: () {
                        context.read<LogoutViewModel>().logout();
                      },
                    ),
              ],
            ),
          ],
        );
      },
    );
  }
}
