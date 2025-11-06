import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:super_fitness_app/core/common/widgets/custome_loading_indicator.dart';
import '../../../../../core/contants/app_icons.dart';
import '../../../../../core/contants/app_images.dart';
import '../../../../../core/l10n/translation/app_localizations.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/utils/styles.dart';
import '../../../data/models/security_rules_model.dart';

class SecurityRolesScreen extends StatelessWidget {
  const SecurityRolesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final languageCode = AppLocalizations.of(context)?.localeName ?? 'en';
    globalContext = context;

    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(10),
          child: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: AppColors.main,
                borderRadius: BorderRadius.circular(20),
              ),
              child: SvgPicture.asset(AppIcons.backIcon),
            ),
          ),
        ),
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text(
          languageCode == 'ar'
              ? 'أدوار وصلاحيات المستخدمين'
              : 'User Roles & Permissions',
          style: balooThambi2SemiBold.copyWith(fontSize: 26),
        ),
      ),
      body: FutureBuilder<SecurityRolesConfig>(
        future: SecurityRolesConfig.loadFromAssets(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return AppLoadingIndicator();
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                'Error: ${snapshot.error}',
                style: const TextStyle(color: Colors.white70),
              ),
            );
          } else if (!snapshot.hasData) {
            return const Center(
              child: Text(
                'No data found',
                style: TextStyle(color: Colors.white70),
              ),
            );
          }

          final rolesConfig = snapshot.data!;
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
                child: ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: rolesConfig.sections.length,
                  itemBuilder: (context, index) {
                    final section = rolesConfig.sections[index];
                    return _buildSection(section, languageCode);
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildSection(SecuritySection section, String lang) {
    final textAlign =
        (section.style?.textAlign?[lang] == 'right' || lang == 'ar')
            ? TextAlign.right
            : (section.style?.textAlign?[lang] == 'center'
                ? TextAlign.center
                : TextAlign.left);

    switch (section.section) {
      case 'page_title':
      case 'page_description':
      case 'role_list_title':
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Text(
            section.content?[lang] ?? section.title?[lang] ?? '',
            textAlign: textAlign,
            style: TextStyle(
              fontSize: section.style?.fontSize ?? 18,
              fontWeight: _mapFontWeight(section.style?.fontWeight),
              color: Colors.white.withOpacity(0.9),
            ),
          ),
        );

      case 'role_definition':
        return Card(
          margin: const EdgeInsets.only(bottom: 16),
          color: Colors.black.withOpacity(0.2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 2,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment:
                  lang == 'ar'
                      ? CrossAxisAlignment.end
                      : CrossAxisAlignment.start,
              children: [
                Text(
                  section.name?[lang] ?? '',
                  textAlign: textAlign,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: _mapFontWeight(section.style?.fontWeight),
                    color: AppColors.main,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  section.description?[lang] ?? '',
                  textAlign: textAlign,
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.white.withOpacity(0.8),
                  ),
                ),
                if (section.permissions != null) ...[
                  const SizedBox(height: 12),
                  Text(
                    lang == 'ar' ? 'الأذونات' : 'Permissions',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  ...section.permissions!.map(
                    (perm) => _buildPermission(perm, lang),
                  ),
                ],
              ],
            ),
          ),
        );

      default:
        return const SizedBox.shrink();
    }
  }

  Widget _buildPermission(RolePermission perm, String lang) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment:
            lang == 'ar' ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(
            perm.name[lang] ?? '',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Text(
            perm.description[lang] ?? '',
            style: TextStyle(
              fontSize: 14,
              color: Colors.white.withOpacity(0.7),
            ),
          ),
        ],
      ),
    );
  }

  FontWeight _mapFontWeight(String? weight) {
    if (weight == null) return FontWeight.normal;
    switch (weight.toLowerCase()) {
      case 'bold':
        return FontWeight.bold;
      case 'w500':
        return FontWeight.w500;
      default:
        return FontWeight.normal;
    }
  }
}
