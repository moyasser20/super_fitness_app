import 'dart:convert';

HelpSectionModel helpSectionModelFromJson(String str) =>
    HelpSectionModel.fromJson(json.decode(str));

String helpSectionModelToJson(HelpSectionModel data) =>
    json.encode(data.toJson());

class HelpSectionModel {
  List<HelpSection> helpScreenContent;

  HelpSectionModel({required this.helpScreenContent});

  factory HelpSectionModel.fromJson(Map<String, dynamic> json) =>
      HelpSectionModel(
        helpScreenContent: List<HelpSection>.from(
          json["help_screen_content"].map((x) => HelpSection.fromJson(x)),
        ),
      );

  Map<String, dynamic> toJson() => {
    "help_screen_content": List<dynamic>.from(
      helpScreenContent.map((x) => x.toJson()),
    ),
  };
}

class HelpSection {
  String section;
  LocalizedText? title;
  LocalizedText? content;
  Map<String, dynamic>? style;
  List<HelpItem>? contentList;

  HelpSection({
    required this.section,
    this.title,
    this.content,
    this.style,
    this.contentList,
  });

  factory HelpSection.fromJson(Map<String, dynamic> json) => HelpSection(
    section: json["section"] ?? "",
    title: json["title"] != null ? LocalizedText.fromJson(json["title"]) : null,
    content:
        json["content"] is Map ? LocalizedText.fromJson(json["content"]) : null,
    style:
        json["style"] != null ? Map<String, dynamic>.from(json["style"]) : null,
    contentList:
        json["content"] is List
            ? List<HelpItem>.from(
              json["content"].map((x) => HelpItem.fromJson(x)),
            )
            : null,
  );

  Map<String, dynamic> toJson() => {
    "section": section,
    "title": title?.toJson(),
    "content": content?.toJson(),
    "style": style,
    "content":
        contentList != null
            ? List<dynamic>.from(contentList!.map((x) => x.toJson()))
            : content?.toJson(),
  };
}

class HelpItem {
  String? id;
  LocalizedText? method;
  LocalizedText? details;
  LocalizedText? question;
  LocalizedText? answer;
  String? value;
  Map<String, dynamic>? style;

  HelpItem({
    this.id,
    this.method,
    this.details,
    this.question,
    this.answer,
    this.value,
    this.style,
  });

  factory HelpItem.fromJson(Map<String, dynamic> json) => HelpItem(
    id: json["id"],
    method:
        json["method"] != null ? LocalizedText.fromJson(json["method"]) : null,
    details:
        json["details"] != null
            ? LocalizedText.fromJson(json["details"])
            : null,
    question:
        json["question"] != null
            ? LocalizedText.fromJson(json["question"])
            : null,
    answer:
        json["answer"] != null ? LocalizedText.fromJson(json["answer"]) : null,
    value: json["value"],
    style:
        json["style"] != null ? Map<String, dynamic>.from(json["style"]) : null,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "method": method?.toJson(),
    "details": details?.toJson(),
    "question": question?.toJson(),
    "answer": answer?.toJson(),
    "value": value,
    "style": style,
  };
}

class LocalizedText {
  String en;
  String ar;

  LocalizedText({required this.en, required this.ar});

  factory LocalizedText.fromJson(Map<String, dynamic> json) =>
      LocalizedText(en: json["en"] ?? "", ar: json["ar"] ?? "");

  Map<String, dynamic> toJson() => {"en": en, "ar": ar};
}
