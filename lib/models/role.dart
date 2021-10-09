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
