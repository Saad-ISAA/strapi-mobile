// To parse this JSON data, do
//
//     final role = roleFromMap(jsonString);

import 'dart:convert';

class Role {
  Role({
    this.id,
    this.name,
    this.description,
    this.type,
    this.createdBy,
    this.updatedBy,
    this.nbUsers,
  });

  int id;
  String name;
  String description;
  String type;
  dynamic createdBy;
  dynamic updatedBy;
  int nbUsers;

  factory Role.fromJson(String str) => Role.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Role.fromMap(Map<String, dynamic> json) => Role(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        description: json["description"] == null ? null : json["description"],
        type: json["type"] == null ? null : json["type"],
        createdBy: json["created_by"],
        updatedBy: json["updated_by"],
        nbUsers: json["nb_users"] == null ? null : json["nb_users"],
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "description": description == null ? null : description,
        "type": type == null ? null : type,
        "created_by": createdBy,
        "updated_by": updatedBy,
        "nb_users": nbUsers == null ? null : nbUsers,
      };
}

class AdminRole {
  AdminRole({
    this.code,
    this.createdAt,
    this.description,
    this.id,
    this.name,
    this.updatedAt,
    this.usersCount,
  });

  String code;
  DateTime createdAt;
  String description;
  int id;
  String name;
  DateTime updatedAt;
  int usersCount;

  factory AdminRole.fromJson(String str) => AdminRole.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AdminRole.fromMap(Map<String, dynamic> json) => AdminRole(
        code: json["code"] == null ? null : json["code"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        description: json["description"] == null ? null : json["description"],
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        usersCount: json["usersCount"] == null ? null : json["usersCount"],
      );

  Map<String, dynamic> toMap() => {
        "code": code == null ? null : code,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "description": description == null ? null : description,
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
        "usersCount": usersCount == null ? null : usersCount,
      };
}
