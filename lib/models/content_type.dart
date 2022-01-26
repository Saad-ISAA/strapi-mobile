// To parse this JSON data, do
//
//     final contentType = contentTypeFromMap(jsonString);

import 'dart:convert';

class ContentType {
  ContentType({
    this.uid,
    this.isDisplayed,
    this.apiId,
    this.kind,
    this.info,
    this.pluginOptions,
    this.attributes,
  });

  String uid;
  bool isDisplayed;
  String apiId;
  String kind;
  Info info;
  Map<String, dynamic> pluginOptions;
  Map<String, dynamic> attributes;

  factory ContentType.fromJson(String str) =>
      ContentType.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ContentType.fromMap(Map<String, dynamic> json) => ContentType(
        uid: json["uid"] == null ? null : json["uid"],
        isDisplayed: json["isDisplayed"] == null ? null : json["isDisplayed"],
        apiId: json["apiID"] == null ? null : json["apiID"],
        kind: json["kind"] == null ? null : json["kind"],
        info: json["info"] == null ? null : Info.fromMap(json["info"]),
        pluginOptions: json["pluginOptions"],
        attributes: json["attributes"],
      );

  Map<String, dynamic> toMap() => {
        "uid": uid == null ? null : uid,
        "isDisplayed": isDisplayed == null ? null : isDisplayed,
        "apiID": apiId == null ? null : apiId,
        "kind": kind == null ? null : kind,
        "info": info == null ? null : info.toMap(),
        "pluginOptions": pluginOptions,
        "attributes": attributes,
      };
}

class Info {
  Info(
      {this.name,
      this.description,
      this.displayName,
      this.pluralName,
      this.singularName});

  String name;
  String description;
  String singularName;
  String pluralName;
  String displayName;

  factory Info.fromJson(String str) => Info.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Info.fromMap(Map<String, dynamic> json) => Info(
        name: json["name"] == null ? null : json["name"],
        description: json["description"] == null ? null : json["description"],
        singularName:
            json["singularName"] == null ? null : json["singularName"],
        pluralName: json["pluralName"] == null ? null : json["pluralName"],
        displayName: json["displayName"] == null ? null : json["displayName"],
      );

  Map<String, dynamic> toMap() => {
        "name": name == null ? null : name,
        "description": description == null ? null : description,
        "singularName": singularName == null ? null : singularName,
        "pluralName": pluralName == null ? null : pluralName,
        "displayName": displayName == null ? null : displayName,
      };
}
