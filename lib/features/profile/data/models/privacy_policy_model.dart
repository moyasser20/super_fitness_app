import 'dart:convert';

import 'package:flutter/cupertino.dart';

class PrivacyPolicyModel {
  final List<PrivacySection> sections;

  PrivacyPolicyModel({required this.sections});

  factory PrivacyPolicyModel.fromJson(Map<String, dynamic> json) {
    return PrivacyPolicyModel(
      sections: (json['privacy_policy'] as List)
          .map((e) => PrivacySection.fromJson(e))
          .toList(),
    );
  }

  static Future<PrivacyPolicyModel> loadFromAssets() async {
    await Future.delayed(const Duration(seconds: 1));
    final jsonString =
    await DefaultAssetBundle.of(globalContext).loadString('assets/json/privacy_and_security.json');
    final Map<String, dynamic> jsonMap = jsonDecode(jsonString);
    return PrivacyPolicyModel.fromJson(jsonMap);
  }
}

class PrivacySection {
  final String section;
  final Map<String, String>? title;
  final Map<String, String>? content;
  final PrivacyStyle? style;
  final List<PrivacySubSection>? subSections;

  PrivacySection({
    required this.section,
    this.title,
    this.content,
    this.style,
    this.subSections,
  });

  factory PrivacySection.fromJson(Map<String, dynamic> json) {
    return PrivacySection(
      section: json['section'],
      title: (json['title'] as Map?)?.map((k, v) => MapEntry(k.toString(), v.toString())),
      content: (json['content'] as Map?)?.map((k, v) => MapEntry(k.toString(), v.toString())),
      style: json['style'] != null ? PrivacyStyle.fromJson(json['style']) : null,
      subSections: (json['sub_sections'] as List?)
          ?.map((e) => PrivacySubSection.fromJson(e))
          .toList(),
    );
  }
}

class PrivacySubSection {
  final String type;
  final Map<String, String>? title;
  final Map<String, String>? content;

  PrivacySubSection({required this.type, this.title, this.content});

  factory PrivacySubSection.fromJson(Map<String, dynamic> json) {
    return PrivacySubSection(
      type: json['type'],
      title: (json['title'] as Map?)?.map((k, v) => MapEntry(k.toString(), v.toString())),
      content: (json['content'] as Map?)?.map((k, v) => MapEntry(k.toString(), v.toString())),
    );
  }
}

class PrivacyStyle {
  final Map<String, dynamic>? title;
  final double? fontSize;
  final String? fontWeight;
  final String? color;
  final Map<String, String>? textAlign;
  final String? backgroundColor;

  PrivacyStyle({
    this.title,
    this.fontSize,
    this.fontWeight,
    this.color,
    this.textAlign,
    this.backgroundColor,
  });

  factory PrivacyStyle.fromJson(Map<String, dynamic> json) {
    return PrivacyStyle(
      title: json['title'] != null ? json['title'] as Map<String, dynamic> : null,
      fontSize: (json['fontSize'] as num?)?.toDouble(),
      fontWeight: json['fontWeight']?.toString(),
      color: json['color']?.toString(),
      textAlign: (json['textAlign'] as Map?)?.map(
            (k, v) => MapEntry(k.toString(), v.toString()),
      ),
      backgroundColor: json['backgroundColor']?.toString(),
    );
  }
}

late BuildContext globalContext;
