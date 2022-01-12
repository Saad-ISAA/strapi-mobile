// To parse this JSON data, do
//
//     final advancedSettings = advancedSettingsFromMap(jsonString);

import 'dart:convert';

import 'package:strapi_flutter_cms/models/role.dart';

class AdvancedSettings {
  AdvancedSettings({
    this.settings,
    this.roles,
  });

  Settings settings;
  List<Role> roles;

  factory AdvancedSettings.fromJson(String str) =>
      AdvancedSettings.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AdvancedSettings.fromMap(Map<String, dynamic> json) =>
      AdvancedSettings(
        settings: json["settings"] == null
            ? null
            : Settings.fromMap(json["settings"]),
        roles: json["roles"] == null
            ? null
            : List<Role>.from(json["roles"].map((x) => Role.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "settings": settings == null ? null : settings.toMap(),
        "roles": roles == null
            ? null
            : List<dynamic>.from(roles.map((x) => x.toMap())),
      };
}

class Settings {
  Settings({
    this.uniqueEmail,
    this.allowRegister,
    this.emailConfirmation,
    this.emailResetPassword,
    this.emailConfirmationRedirection,
    this.defaultRole,
  });

  bool uniqueEmail;
  bool allowRegister;
  bool emailConfirmation;
  String emailResetPassword;
  String emailConfirmationRedirection;
  String defaultRole;

  factory Settings.fromJson(String str) => Settings.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Settings.fromMap(Map<String, dynamic> json) => Settings(
        uniqueEmail: json["unique_email"] == null ? null : json["unique_email"],
        allowRegister:
            json["allow_register"] == null ? null : json["allow_register"],
        emailConfirmation: json["email_confirmation"] == null
            ? null
            : json["email_confirmation"],
        emailResetPassword: json["email_reset_password"] == null
            ? null
            : json["email_reset_password"],
        emailConfirmationRedirection:
            json["email_confirmation_redirection"] == null
                ? null
                : json["email_confirmation_redirection"],
        defaultRole: json["default_role"] == null ? null : json["default_role"],
      );

  Map<String, dynamic> toMap() => {
        "unique_email": uniqueEmail == null ? null : uniqueEmail,
        "allow_register": allowRegister == null ? null : allowRegister,
        "email_confirmation":
            emailConfirmation == null ? null : emailConfirmation,
        "email_reset_password":
            emailResetPassword == null ? null : emailResetPassword,
        "email_confirmation_redirection": emailConfirmationRedirection == null
            ? null
            : emailConfirmationRedirection,
        "default_role": defaultRole == null ? null : defaultRole,
      };
}
