import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_svg/svg.dart';
import 'dart:convert';
import '../../../../../core/contants/app_icons.dart';
import '../../../../../core/contants/app_images.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/l10n/translation/app_localizations.dart';
import '../../../../../core/utils/styles.dart';
import '../../../data/models/help_section_model.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});

  Future<HelpSectionModel> _loadHelp() async {
    final jsonString = await rootBundle.loadString('assets/json/help.json');
    return HelpSectionModel.fromJson(json.decode(jsonString));
  }

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)?.localeName ?? 'en';

    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        centerTitle: true,
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
        title: Text(
          locale.startsWith('ar') ? 'المساعدة والدعم' : 'Help & Support',
          style: balooThambi2SemiBold.copyWith(fontSize: 26, color: Colors.white),
        ),
      ),
      body: FutureBuilder<HelpSectionModel>(
        future: _loadHelp(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator(color: Colors.white70));
          } else if (snapshot.hasError) {
            return Center(
                child: Text('Error: ${snapshot.error}',
                    style: const TextStyle(color: Colors.white70)));
          } else if (!snapshot.hasData) {
            return const Center(
                child: Text("Can't get data", style: TextStyle(color: Colors.white70)));
          }

          final help = snapshot.data!;
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
                  itemCount: help.helpScreenContent.length,
                  itemBuilder: (context, index) {
                    final section = help.helpScreenContent[index];
                    return _buildSection(section, locale);
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildSection(HelpSection section, String locale) {
    final lang = locale.startsWith('ar') ? 'ar' : 'en';

    if (section.section == 'page_title' || section.section == 'page_subtitle') {
      final text = lang == 'ar' ? section.content?.ar : section.content?.en;
      return Container(
        decoration:
        BoxDecoration(borderRadius: BorderRadius.circular(12), color: Colors.black54),
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.only(bottom: 16),
        child: Text(
          text ?? '',
          style: _parseTextStyle(section.style ?? {}).copyWith(color: Colors.white70),
          textAlign: _parseTextAlign(section.style ?? {}, lang),
        ),
      );
    }

    if (section.section == 'contact_us') {
      return Container(
        decoration:
        BoxDecoration(borderRadius: BorderRadius.circular(12), color: Colors.black54),
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (section.title != null)
              Text(
                lang == 'ar' ? section.title!.ar : section.title!.en,
                style: _parseTextStyle(section.style?['title'] ?? {}),
              ),
            const SizedBox(height: 8),
            ...section.contentList?.map((e) {
              final method = lang == 'ar' ? e.method?.ar : e.method?.en;
              final details = lang == 'ar' ? e.details?.ar : e.details?.en;
              return Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(method ?? '',
                        style: _parseTextStyle(e.style?['method'] ?? {})),
                    Text(details ?? '',
                        style: _parseTextStyle(e.style?['details'] ?? {})
                            .copyWith(color: Colors.white70)),
                    if (e.value != null)
                      Text(
                        e.value!,
                        style: const TextStyle(
                            color: Colors.lightBlueAccent, fontWeight: FontWeight.bold),
                      ),
                  ],
                ),
              );
            }).toList() ??
                [],
          ],
        ),
      );
    }

    if (section.section == 'faq') {
      return Container(
        decoration:
        BoxDecoration(borderRadius: BorderRadius.circular(12), color: Colors.black54),
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (section.title != null)
              Text(
                lang == 'ar' ? section.title!.ar : section.title!.en,
                style: _parseTextStyle(section.style?['title'] ?? {}),
              ),
            const SizedBox(height: 8),
            ...section.contentList?.map((faq) {
              final q = lang == 'ar' ? faq.question?.ar : faq.question?.en;
              final a = lang == 'ar' ? faq.answer?.ar : faq.answer?.en;
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(q ?? '',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16,color: Colors.white)),
                    const SizedBox(height: 4),
                    Text(a ?? '',
                        style:
                        const TextStyle(fontSize: 14, color: Colors.white70)),
                  ],
                ),
              );
            }).toList() ??
                [],
          ],
        ),
      );
    }

    return const SizedBox.shrink();
  }

  TextStyle _parseTextStyle(Map<String, dynamic> style) {
    return TextStyle(
      fontSize: (style['fontSize'] is int
          ? style['fontSize'].toDouble()
          : style['fontSize']?.toDouble()) ??
          16,
      fontWeight: style['fontWeight'] == 'bold' ? FontWeight.bold : FontWeight.normal,
      color: _parseColor(style['color'] ?? '#FFFFFF'),
    );
  }

  TextAlign _parseTextAlign(Map<String, dynamic> style, String lang) {
    final align = style['textAlign'];
    if (align is Map) {
      return align[lang] == 'center'
          ? TextAlign.center
          : align[lang] == 'right'
          ? TextAlign.right
          : TextAlign.left;
    } else if (align is String) {
      return align == 'center'
          ? TextAlign.center
          : align == 'right'
          ? TextAlign.right
          : TextAlign.left;
    }
    return TextAlign.left;
  }

  Color _parseColor(String hexColor) {
    hexColor = hexColor.replaceAll('#', '');
    if (hexColor.length == 6) hexColor = 'FF$hexColor';
    return Color(int.parse(hexColor, radix: 16));
  }
}
