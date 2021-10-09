// To parse this JSON data, do
//
//     final emailTemplate = emailTemplateFromMap(jsonString);

import 'dart:convert';

class EmailTemplate {
  EmailTemplate({
    this.display,
    this.icon,
    this.options,
  });

  String display;
  String icon;
  Options options;

  factory EmailTemplate.fromJson(String str) =>
      EmailTemplate.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory EmailTemplate.fromMap(Map<String, dynamic> json) => EmailTemplate(
        display: json["display"] == null ? null : json["display"],
        icon: json["icon"] == null ? null : json["icon"],
        options:
            json["options"] == null ? null : Options.fromMap(json["options"]),
      );

  Map<String, dynamic> toMap() => {
        "display": display == null ? null : display,
        "icon": icon == null ? null : icon,
        "options": options == null ? null : options.toMap(),
      };
}

class Options {
  Options({
    this.from,
    this.responseEmail,
    this.object,
    this.message,
  });

  From from;
  String responseEmail;
  String object;
  String message;

  factory Options.fromJson(String str) => Options.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Options.fromMap(Map<String, dynamic> json) => Options(
        from: json["from"] == null ? null : From.fromMap(json["from"]),
        responseEmail:
            json["response_email"] == null ? null : json["response_email"],
        object: json["object"] == null ? null : json["object"],
        message: json["message"] == null ? null : json["message"],
      );

  Map<String, dynamic> toMap() => {
        "from": from == null ? null : from.toMap(),
        "response_email": responseEmail == null ? null : responseEmail,
        "object": object == null ? null : object,
        "message": message == null ? null : message,
      };
}

class From {
  From({
    this.name,
    this.email,
  });

  String name;
  String email;

  factory From.fromJson(String str) => From.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory From.fromMap(Map<String, dynamic> json) => From(
        name: json["name"] == null ? null : json["name"],
        email: json["email"] == null ? null : json["email"],
      );

  Map<String, dynamic> toMap() => {
        "name": name == null ? null : name,
        "email": email == null ? null : email,
      };
}
