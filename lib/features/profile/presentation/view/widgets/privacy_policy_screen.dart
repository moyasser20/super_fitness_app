import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:super_fitness_app/core/common/widgets/custome_loading_indicator.dart';
import '../../../../../core/contants/app_icons.dart';
import '../../../../../core/contants/app_images.dart';
import '../../../../../core/l10n/translation/app_localizations.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/utils/styles.dart';
import '../../../data/models/privacy_policy_model.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

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
          languageCode == 'ar' ? 'سياسة الخصوصية' : 'Privacy Policy',
          style: balooThambi2SemiBold.copyWith(
            fontSize: 26,
            color: Colors.white,
          ),
        ),
      ),
      body: FutureBuilder<PrivacyPolicyModel>(
        future: PrivacyPolicyModel.loadFromAssets(),
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

          final policy = snapshot.data!;
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
                  itemCount: policy.sections.length,
                  itemBuilder: (context, index) {
                    final section = policy.sections[index];
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

  Widget _buildSection(PrivacySection section, String lang) {
    final title = section.title?[lang];
    final content = section.content?[lang];
    final subSections = section.subSections;
    final textAlign =
        (section.style?.textAlign?[lang] == 'right' || lang == 'ar')
            ? TextAlign.right
            : (section.style?.textAlign?[lang] == 'center'
                ? TextAlign.center
                : TextAlign.left);

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      color: Colors.black.withOpacity(0.2),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment:
              lang == 'ar' ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            if (title != null)
              Text(
                title,
                textAlign: textAlign,
                style: TextStyle(
                  fontSize: section.style?.title?['fontSize']?.toDouble() ?? 20,
                  fontWeight: _mapFontWeight(
                    section.style?.title?['fontWeight'],
                  ),
                  color: AppColors.main,
                ),
              ),
            if (content != null)
              Padding(
                padding: const EdgeInsets.only(top: 6),
                child: Text(
                  content,
                  textAlign: textAlign,
                  style: TextStyle(
                    fontSize: section.style?.fontSize ?? 16,
                    fontWeight: _mapFontWeight(section.style?.fontWeight),
                    color: Colors.white70,
                  ),
                ),
              ),
            if (subSections != null)
              ...subSections.map(
                (sub) => Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Column(
                    crossAxisAlignment:
                        lang == 'ar'
                            ? CrossAxisAlignment.end
                            : CrossAxisAlignment.start,
                    children: [
                      if (sub.title != null)
                        Text(
                          sub.title?[lang] ?? '',
                          textAlign: textAlign,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      if (sub.content != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 4),
                          child: Text(
                            sub.content?[lang] ?? '',
                            textAlign: textAlign,
                            style: const TextStyle(color: Colors.white70),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  FontWeight _mapFontWeight(dynamic weight) {
    if (weight == null) return FontWeight.normal;
    final value = weight.toString().toLowerCase();
    switch (value) {
      case 'bold':
        return FontWeight.bold;
      case 'w500':
        return FontWeight.w500;
      default:
        return FontWeight.normal;
    }
  }
}
