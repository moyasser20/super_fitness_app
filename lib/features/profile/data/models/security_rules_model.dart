import 'dart:convert';
import 'package:flutter/material.dart';

late BuildContext globalContext;

class SecurityRolesConfig {
  final List<SecuritySection> sections;

  SecurityRolesConfig({required this.sections});

  factory SecurityRolesConfig.fromJson(Map<String, dynamic> json) {
    return SecurityRolesConfig(
      sections: (json['security_roles_config'] as List)
          .map((e) => SecuritySection.fromJson(e))
          .toList(),
    );
  }

  static Future<SecurityRolesConfig> loadFromAssets() async {
    await Future.delayed(const Duration(seconds: 1));
    final jsonString =
    await DefaultAssetBundle.of(globalContext).loadString('assets/json/security_roles_config.json');
    final Map<String, dynamic> jsonMap = jsonDecode(jsonString);
    return SecurityRolesConfig.fromJson(jsonMap);
  }
}

class SecuritySection {
  final String section;
  final String? roleId;
  final Map<String, String>? title;
  final Map<String, String>? content;
  final Map<String, String>? name;
  final Map<String, String>? description;
  final SecurityStyle? style;
  final List<RolePermission>? permissions;

  SecuritySection({
    required this.section,
    this.roleId,
    this.title,
    this.content,
    this.name,
    this.description,
    this.style,
    this.permissions,
  });

  factory SecuritySection.fromJson(Map<String, dynamic> json) {
    return SecuritySection(
      section: json['section'],
      roleId: json['role_id'],
      title: (json['title'] as Map?)?.map((k, v) => MapEntry(k.toString(), v.toString())),
      content: (json['content'] as Map?)?.map((k, v) => MapEntry(k.toString(), v.toString())),
      name: (json['name'] as Map?)?.map((k, v) => MapEntry(k.toString(), v.toString())),
      description: (json['description'] as Map?)?.map((k, v) => MapEntry(k.toString(), v.toString())),
      style: json['style'] != null ? SecurityStyle.fromJson(json['style']) : null,
      permissions: (json['permissions'] as List?)
          ?.map((e) => RolePermission.fromJson(e))
          .toList(),
    );
  }
}

class RolePermission {
  final String key;
  final Map<String, String> name;
  final Map<String, String> description;

  RolePermission({
    required this.key,
    required this.name,
    required this.description,
  });

  factory RolePermission.fromJson(Map<String, dynamic> json) {
    return RolePermission(
      key: json['key'],
      name: (json['name'] as Map).map((k, v) => MapEntry(k.toString(), v.toString())),
      description: (json['description'] as Map).map((k, v) => MapEntry(k.toString(), v.toString())),
    );
  }
}

class SecurityStyle {
  final double? fontSize;
  final String? fontWeight;
  final String? color;
  final Map<String, String>? textAlign;
  final String? backgroundColor;
  final String? highlightColor;
  final Map<String, dynamic>? title;

  SecurityStyle({
    this.fontSize,
    this.fontWeight,
    this.color,
    this.textAlign,
    this.backgroundColor,
    this.highlightColor,
    this.title,
  });

  factory SecurityStyle.fromJson(Map<String, dynamic> json) {
    return SecurityStyle(
      fontSize: (json['fontSize'] as num?)?.toDouble(),
      fontWeight: json['fontWeight']?.toString(),
      color: json['color']?.toString(),
      textAlign: (json['textAlign'] as Map?)?.map((k, v) => MapEntry(k.toString(), v.toString())),
      backgroundColor: json['backgroundColor']?.toString(),
      highlightColor: json['highlightColor']?.toString(),
      title: json['title'] != null ? json['title'] as Map<String, dynamic> : null,
    );
  }
}
