// To parse this JSON data, do
//
//     final adminInformation = adminInformationFromMap(jsonString);

import 'dart:convert';

class AdminInformation {
  AdminInformation({
    this.currentEnvironment,
    this.autoReload,
    this.strapiVersion,
    this.nodeVersion,
    this.communityEdition,
  });

  String currentEnvironment;
  bool autoReload;
  String strapiVersion;
  String nodeVersion;
  bool communityEdition;

  factory AdminInformation.fromJson(String str) =>
      AdminInformation.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AdminInformation.fromMap(Map<String, dynamic> json) =>
      AdminInformation(
        currentEnvironment: json["currentEnvironment"] == null
            ? null
            : json["currentEnvironment"],
        autoReload: json["autoReload"] == null ? null : json["autoReload"],
        strapiVersion:
            json["strapiVersion"] == null ? null : json["strapiVersion"],
        nodeVersion: json["nodeVersion"] == null ? null : json["nodeVersion"],
        communityEdition:
            json["communityEdition"] == null ? null : json["communityEdition"],
      );

  Map<String, dynamic> toMap() => {
        "currentEnvironment":
            currentEnvironment == null ? null : currentEnvironment,
        "autoReload": autoReload == null ? null : autoReload,
        "strapiVersion": strapiVersion == null ? null : strapiVersion,
        "nodeVersion": nodeVersion == null ? null : nodeVersion,
        "communityEdition": communityEdition == null ? null : communityEdition,
      };
}
