// To parse this JSON data, do
//
//     final apiToken = apiTokenFromMap(jsonString);

import 'dart:convert';

class ApiToken {
    ApiToken({
        this.id,
        this.name,
        this.description,
        this.type,
        this.createdAt,
    });

    int id;
    String name;
    String description;
    String type;
    DateTime createdAt;

    factory ApiToken.fromJson(String str) => ApiToken.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory ApiToken.fromMap(Map<String, dynamic> json) => ApiToken(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        description: json["description"] == null ? null : json["description"],
        type: json["type"] == null ? null : json["type"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    );

    Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "description": description == null ? null : description,
        "type": type == null ? null : type,
        "createdAt": createdAt == null ? null : createdAt.toIso8601String(),
    };
}
