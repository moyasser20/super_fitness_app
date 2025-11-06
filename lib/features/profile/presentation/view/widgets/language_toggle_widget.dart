import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../../core/contants/app_icons.dart';
import '../../../../../core/l10n/translation/app_localizations.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/utils/styles.dart';
import '../../../../localization/localization_controller/localization_cubit.dart';

class LanguageToggleWidget extends StatefulWidget {
  const LanguageToggleWidget({super.key});

  @override
  State<LanguageToggleWidget> createState() => _LanguageToggleWidgetState();
}

class _LanguageToggleWidgetState extends State<LanguageToggleWidget> {
  bool _enabled = true;

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;
    return ListTile(
      leading: SvgPicture.asset(AppIcons.languageIcon, width: 24, height: 24),
      title: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: '${local.selectLanguage}  ',
              style: balooThambi2SemiBold.copyWith(
                fontSize: 16,
                color: Colors.white,
              ),
            ),
            TextSpan(
              text: '(',
              style: balooThambi2SemiBold.copyWith(
                fontSize: 16,
                color: Colors.white,
              ),
            ),
            TextSpan(
              text:
                  context
                      .read<LocalizationCubit>()
                      .getSelectedLanguageDisplayName(),
              style: balooThambi2SemiBold.copyWith(
                fontSize: 16,
                color: AppColors.orange,
              ),
            ),
            TextSpan(
              text: ')',
              style: balooThambi2SemiBold.copyWith(
                fontSize: 16,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
      trailing: Switch(
        value: _enabled,
        onChanged: (val) {
          setState(() {
            _enabled = val;
          });
        },
        thumbColor: WidgetStateProperty.all(Colors.white),
        activeTrackColor: AppColors.orange,
        inactiveThumbColor: Colors.white,
        inactiveTrackColor: Colors.grey.shade400,
      ),
      onTap: () {
        showModalBottomSheet(
          backgroundColor: AppColors.black,
          context: context,
          builder: (context) {
            return Container(
              decoration: BoxDecoration(
                color: const Color(0xff242424).withOpacity(0.6),
                borderRadius: BorderRadius.circular(20),
              ),
              width: double.infinity,
              height: 300,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  spacing: 16.0,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Align(
                      alignment: AlignmentDirectional.centerStart,
                      child: Text(
                        textAlign: TextAlign.start,
                        local.changeLanguage,
                        style: balooThambi2BoldLarge.copyWith(
                          color: AppColors.orange,
                          fontSize: 26,
                        ),
                      ),
                    ),
                    Card(
                      color: const Color(0xff242424),
                      child: SizedBox(
                        height: 60,
                        width: double.infinity,
                        child: InkWell(
                          onTap: () {
                            context.read<LocalizationCubit>().selectLanguage(
                              "Arabic",
                            );
                            Navigator.pop(context);
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  local.arabic,
                                  style: Theme.of(
                                    context,
                                  ).textTheme.bodyLarge?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                Icon(
                                  context.read<LocalizationCubit>().isSelected(
                                        "Arabic",
                                      )
                                      ? Icons.radio_button_checked
                                      : Icons.radio_button_unchecked,
                                  color: AppColors.orange,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Card(
                      color: const Color(0xff242424),
                      child: SizedBox(
                        height: 60,
                        width: double.infinity,
                        child: InkWell(
                          onTap: () {
                            context.read<LocalizationCubit>().selectLanguage(
                              "English",
                            );
                            Navigator.pop(context);
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  local.english,
                                  style: Theme.of(
                                    context,
                                  ).textTheme.bodyLarge?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                Icon(
                                  context.read<LocalizationCubit>().isSelected(
                                        "English",
                                      )
                                      ? Icons.radio_button_checked
                                      : Icons.radio_button_unchecked,
                                  color: AppColors.orange,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
