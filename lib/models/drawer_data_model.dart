// To parse this JSON data, do
//
//     final drawerData = drawerDataFromJson(jsonString);

import 'dart:convert';

class DrawerData {
  DrawerData({
    this.uid,
    this.isDisplayed,
    this.apiId,
    this.kind,
    this.info,
    this.options,
    this.attributes,
  });

  String uid;
  bool isDisplayed;
  String apiId;
  String kind;
  Info info;
  Options options;
  Attributes attributes;

  DrawerData copyWith({
    String uid,
    bool isDisplayed,
    String apiId,
    String kind,
    Info info,
    Options options,
    Attributes attributes,
  }) =>
      DrawerData(
        uid: uid ?? this.uid,
        isDisplayed: isDisplayed ?? this.isDisplayed,
        apiId: apiId ?? this.apiId,
        kind: kind ?? this.kind,
        info: info ?? this.info,
        options: options ?? this.options,
        attributes: attributes ?? this.attributes,
      );

  factory DrawerData.fromRawJson(String str) =>
      DrawerData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DrawerData.fromJson(Map<String, dynamic> json) => DrawerData(
        uid: json["uid"],
        isDisplayed: json["isDisplayed"],
        apiId: json["apiID"],
        kind: json["kind"],
        info: Info.fromJson(json["info"]),
        options: Options.fromJson(json["options"]),
        attributes: Attributes.fromJson(json["attributes"]),
      );

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "isDisplayed": isDisplayed,
        "apiID": apiId,
        "kind": kind,
        "info": info.toJson(),
        "options": options.toJson(),
        "attributes": attributes.toJson(),
      };
}

class Attributes {
  Attributes({
    this.id,
    this.action,
    this.subject,
    this.fields,
    this.conditions,
    this.role,
    this.createdAt,
    this.updatedAt,
  });

  CreatedAt id;
  Action action;
  Action subject;
  Action fields;
  Action conditions;
  Role role;
  CreatedAt createdAt;
  CreatedAt updatedAt;

  Attributes copyWith({
    CreatedAt id,
    Action action,
    Action subject,
    Action fields,
    Action conditions,
    Role role,
    CreatedAt createdAt,
    CreatedAt updatedAt,
  }) =>
      Attributes(
        id: id ?? this.id,
        action: action ?? this.action,
        subject: subject ?? this.subject,
        fields: fields ?? this.fields,
        conditions: conditions ?? this.conditions,
        role: role ?? this.role,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory Attributes.fromRawJson(String str) =>
      Attributes.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Attributes.fromJson(Map<String, dynamic> json) => Attributes(
        id: CreatedAt.fromJson(json["id"]),
        action: Action.fromJson(json["action"]),
        subject: Action.fromJson(json["subject"]),
        fields: Action.fromJson(json["fields"]),
        conditions: Action.fromJson(json["conditions"]),
        role: Role.fromJson(json["role"]),
        createdAt: CreatedAt.fromJson(json["created_at"]),
        updatedAt: CreatedAt.fromJson(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id.toJson(),
        "action": action.toJson(),
        "subject": subject.toJson(),
        "fields": fields.toJson(),
        "conditions": conditions.toJson(),
        "role": role.toJson(),
        "created_at": createdAt.toJson(),
        "updated_at": updatedAt.toJson(),
      };
}

class Action {
  Action({
    this.type,
    this.minLength,
    this.configurable,
    this.required,
    this.actionDefault,
  });

  String type;
  int minLength;
  bool configurable;
  bool required;
  List<dynamic> actionDefault;

  Action copyWith({
    String type,
    int minLength,
    bool configurable,
    bool required,
    List<dynamic> actionDefault,
  }) =>
      Action(
        type: type ?? this.type,
        minLength: minLength ?? this.minLength,
        configurable: configurable ?? this.configurable,
        required: required ?? this.required,
        actionDefault: actionDefault ?? this.actionDefault,
      );

  factory Action.fromRawJson(String str) => Action.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Action.fromJson(Map<String, dynamic> json) => Action(
        type: json["type"],
        minLength: json["minLength"] == null ? null : json["minLength"],
        configurable: json["configurable"],
        required: json["required"],
        actionDefault: json["default"] == null
            ? null
            : List<dynamic>.from(json["default"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "minLength": minLength == null ? null : minLength,
        "configurable": configurable,
        "required": required,
        "default": actionDefault == null
            ? null
            : List<dynamic>.from(actionDefault.map((x) => x)),
      };
}

class CreatedAt {
  CreatedAt({
    this.type,
  });

  String type;

  CreatedAt copyWith({
    String type,
  }) =>
      CreatedAt(
        type: type ?? this.type,
      );

  factory CreatedAt.fromRawJson(String str) =>
      CreatedAt.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CreatedAt.fromJson(Map<String, dynamic> json) => CreatedAt(
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
      };
}

class Role {
  Role({
    this.configurable,
    this.model,
    this.plugin,
    this.type,
    this.targetModel,
    this.relationType,
  });

  bool configurable;
  String model;
  String plugin;
  String type;
  String targetModel;
  String relationType;

  Role copyWith({
    bool configurable,
    String model,
    String plugin,
    String type,
    String targetModel,
    String relationType,
  }) =>
      Role(
        configurable: configurable ?? this.configurable,
        model: model ?? this.model,
        plugin: plugin ?? this.plugin,
        type: type ?? this.type,
        targetModel: targetModel ?? this.targetModel,
        relationType: relationType ?? this.relationType,
      );

  factory Role.fromRawJson(String str) => Role.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Role.fromJson(Map<String, dynamic> json) => Role(
        configurable: json["configurable"],
        model: json["model"],
        plugin: json["plugin"],
        type: json["type"],
        targetModel: json["targetModel"],
        relationType: json["relationType"],
      );

  Map<String, dynamic> toJson() => {
        "configurable": configurable,
        "model": model,
        "plugin": plugin,
        "type": type,
        "targetModel": targetModel,
        "relationType": relationType,
      };
}

class Info {
  Info({
    this.name,
    this.description,
    this.label,
  });

  String name;
  String description;
  String label;

  Info copyWith({
    String name,
    String description,
    String label,
  }) =>
      Info(
        name: name ?? this.name,
        description: description ?? this.description,
        label: label ?? this.label,
      );

  factory Info.fromRawJson(String str) => Info.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Info.fromJson(Map<String, dynamic> json) => Info(
        name: json["name"],
        description: json["description"],
        label: json["label"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "description": description,
        "label": label,
      };
}

class Options {
  Options({
    this.timestamps,
  });

  List<String> timestamps;

  Options copyWith({
    List<String> timestamps,
  }) =>
      Options(
        timestamps: timestamps ?? this.timestamps,
      );

  factory Options.fromRawJson(String str) => Options.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Options.fromJson(Map<String, dynamic> json) => Options(
        timestamps: List<String>.from(json["timestamps"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "timestamps": List<dynamic>.from(timestamps.map((x) => x)),
      };
}
