// To parse this JSON data, do
//
//     final selectedLocale = selectedLocaleFromMap(jsonString);

import 'dart:convert';

class SelectedLocale {
  SelectedLocale({
    this.id,
    this.name,
    this.code,
    this.createdAt,
    this.updatedAt,
    this.isDefault,
  });

  int id;
  String name;
  String code;
  DateTime createdAt;
  DateTime updatedAt;
  bool isDefault;

  factory SelectedLocale.fromJson(String str) =>
      SelectedLocale.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory SelectedLocale.fromMap(Map<String, dynamic> json) => SelectedLocale(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        code: json["code"] == null ? null : json["code"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        isDefault: json["isDefault"] == null ? null : json["isDefault"],
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "code": code == null ? null : code,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
        "isDefault": isDefault == null ? null : isDefault,
      };
}
