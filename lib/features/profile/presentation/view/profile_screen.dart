import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:super_fitness_app/core/common/widgets/custome_loading_indicator.dart';
import 'package:super_fitness_app/core/extensions/extensions.dart';
import 'package:super_fitness_app/features/profile/presentation/view/widgets/menu_item_widget.dart';
import 'package:super_fitness_app/features/profile/presentation/view/widgets/language_toggle_widget.dart';
import '../../../../core/config/di.dart';
import '../../../../core/contants/app_icons.dart';
import '../../../../core/contants/app_images.dart';
import '../../../../core/l10n/translation/app_localizations.dart';
import '../../../../core/routes/route_names.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/styles.dart';
import '../../../auth/presentation/logout/viewmodel/logout_viewmodel.dart';
import '../../../auth/presentation/logout/views/logout_widget.dart';
import '../viewmodel/profile_viewmodel.dart';
import '../viewmodel/states/profile_states.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          local.profileTitle,
          style: balooThambi2SemiBold.copyWith(fontSize: 26),
        ),
      ),
      body: BlocBuilder<ProfileViewModel, ProfileStates>(
        builder: (context, state) {
          if (state is ProfileLoadingState) {
            return const AppLoadingIndicator();
          } else if (state is ProfileSuccessState) {
            final profile = state.user;

            return Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(AppImages.homeBc),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SafeArea(
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () async {
                            final updated = await Navigator.pushNamed(
                              context,
                              AppRoutes.editProfileScreen,
                              arguments: profile,
                            );
                            if (updated == true) {
                              context.read<ProfileViewModel>().clearProfileCache();
                              context.read<ProfileViewModel>().getProfile();
                            }
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                radius: 50,
                                backgroundImage: NetworkImage(profile.photo),
                                backgroundColor: AppColors.grey,
                              ),
                              const SizedBox(height: 18),
                              Text(
                                "${profile.firstName} ${profile.lastName}",
                                style: balooThambi2SemiBold.copyWith(fontSize: 22),
                              ),
                              const SizedBox(height: 40),
                            ],
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: const Color(0xff242424).withOpacity(0.8),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              MenuItemWidget(
                                leading: SvgPicture.asset(AppIcons.editProfileIcon, width: 24, height: 24),
                                title: local.editProfile,
                                onTap: () async {
                                  final updated = await Navigator.pushNamed(
                                    context,
                                    AppRoutes.editProfileScreen,
                                  );

                                  if (updated == true) {
                                    context.read<ProfileViewModel>().clearProfileCache();
                                    await context.read<ProfileViewModel>().getProfile();
                                  }
                                },
                              ),

                              _divider(),

                              MenuItemWidget(
                                leading: SvgPicture.asset(
                                  AppIcons.changePassIcon,
                                  width: 24,
                                  height: 24,
                                ),
                                title: local.changePassword,
                                onTap: () {
                                  Navigator.pushNamed(context,AppRoutes.changePasswordScreen);
                                },
                              ),

                              _divider(),

                              const LanguageToggleWidget(),

                              _divider(),

                              MenuItemWidget(
                                leading: SvgPicture.asset(
                                  AppIcons.securityIcon,
                                  width: 24,
                                  height: 24,
                                ),
                                title: local.security,
                                onTap: () {
                                  Navigator.pushNamed(context, AppRoutes.securityScreen);
                                },
                              ),

                              _divider(),

                              MenuItemWidget(
                                leading: SvgPicture.asset(
                                  AppIcons.privacyIcon,
                                  width: 24,
                                  height: 24,
                                ),
                                title: local.privacyPolicy,
                                onTap: () {
                                  Navigator.pushNamed(context, AppRoutes.privacyPolicyScreen);
                                },
                              ),

                              _divider(),

                              MenuItemWidget(
                                leading: SvgPicture.asset(
                                  AppIcons.helpIcon,
                                  width: 24,
                                  height: 24,
                                ),
                                title: local.help,
                                onTap: () {
                                  Navigator.pushNamed(context, AppRoutes.helpScreen);
                                },
                              ),

                              _divider(),

                              MenuItemWidget(
                                leading: SvgPicture.asset(
                                  AppIcons.logoutIcon,
                                  width: 24,
                                  height: 24,
                                ),
                                title: local.logout,
                                isLogout: true,
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder:
                                        (context) => BlocProvider(
                                      create: (context) => getIt<LogoutViewModel>(),
                                      child: const LogoutDialogWidget(),
                                    ),
                                  );
                                },
                              ),

                              _divider(),

                              const SizedBox(height: 10),
                            ],
                          ),
                        )
                      ],
                    ).setHorizontalAndVerticalPadding(context, 0.03, 0.02),
                  ),
                ),
              ],
            );
          } else if (state is ProfileErrorState) {
            return Center(child: Text("${local.error}: ${state.message}"));
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }

  Widget _divider() => Container(
    height: 1,
    color: Colors.white.withOpacity(0.1),
    margin: const EdgeInsets.symmetric(horizontal: 16),
  );
}
