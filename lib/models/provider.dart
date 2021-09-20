// To parse this JSON data, do
//
//     final provider = providerFromMap(jsonString);

import 'dart:convert';

class Provider {
  Provider({
    this.email,
    this.discord,
    this.facebook,
    this.google,
    this.github,
    this.microsoft,
    this.twitter,
    this.instagram,
    this.vk,
    this.twitch,
    this.linkedin,
    this.cognito,
    this.reddit,
    this.auth0,
    this.cas,
  });

  ProviderDetail email;
  ProviderDetail discord;
  ProviderDetail facebook;
  ProviderDetail google;
  ProviderDetail github;
  ProviderDetail microsoft;
  ProviderDetail twitter;
  ProviderDetail instagram;
  ProviderDetail vk;
  ProviderDetail twitch;
  ProviderDetail linkedin;
  ProviderDetail cognito;
  ProviderDetail reddit;
  ProviderDetail auth0;
  ProviderDetail cas;

  factory Provider.fromJson(String str) => Provider.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Provider.fromMap(Map<String, dynamic> json) => Provider(
        email: json["email"] == null
            ? null
            : ProviderDetail.fromMap(json["email"]),
        discord: json["discord"] == null
            ? null
            : ProviderDetail.fromMap(json["discord"]),
        facebook: json["facebook"] == null
            ? null
            : ProviderDetail.fromMap(json["facebook"]),
        google: json["google"] == null
            ? null
            : ProviderDetail.fromMap(json["google"]),
        github: json["github"] == null
            ? null
            : ProviderDetail.fromMap(json["github"]),
        microsoft: json["microsoft"] == null
            ? null
            : ProviderDetail.fromMap(json["microsoft"]),
        twitter: json["twitter"] == null
            ? null
            : ProviderDetail.fromMap(json["twitter"]),
        instagram: json["instagram"] == null
            ? null
            : ProviderDetail.fromMap(json["instagram"]),
        vk: json["vk"] == null ? null : ProviderDetail.fromMap(json["vk"]),
        twitch: json["twitch"] == null
            ? null
            : ProviderDetail.fromMap(json["twitch"]),
        linkedin: json["linkedin"] == null
            ? null
            : ProviderDetail.fromMap(json["linkedin"]),
        cognito: json["cognito"] == null
            ? null
            : ProviderDetail.fromMap(json["cognito"]),
        reddit: json["reddit"] == null
            ? null
            : ProviderDetail.fromMap(json["reddit"]),
        auth0: json["auth0"] == null
            ? null
            : ProviderDetail.fromMap(json["auth0"]),
        cas: json["cas"] == null ? null : ProviderDetail.fromMap(json["cas"]),
      );

  Map<String, dynamic> toMap() => {
        "email": email == null ? null : email.toMap(),
        "discord": discord == null ? null : discord.toMap(),
        "facebook": facebook == null ? null : facebook.toMap(),
        "google": google == null ? null : google.toMap(),
        "github": github == null ? null : github.toMap(),
        "microsoft": microsoft == null ? null : microsoft.toMap(),
        "twitter": twitter == null ? null : twitter.toMap(),
        "instagram": instagram == null ? null : instagram.toMap(),
        "vk": vk == null ? null : vk.toMap(),
        "twitch": twitch == null ? null : twitch.toMap(),
        "linkedin": linkedin == null ? null : linkedin.toMap(),
        "cognito": cognito == null ? null : cognito.toMap(),
        "reddit": reddit == null ? null : reddit.toMap(),
        "auth0": auth0 == null ? null : auth0.toMap(),
        "cas": cas == null ? null : cas.toMap(),
      };
}

class ProviderDetail {
  ProviderDetail({
    this.enabled,
    this.icon,
    this.key,
    this.secret,
    this.subdomain,
    this.callback,
    this.scope,
    this.redirectUri,
    this.state,
  });

  bool enabled;
  String icon;
  String key;
  String secret;
  String subdomain;
  String callback;
  List<String> scope;
  String redirectUri;
  bool state;

  factory ProviderDetail.fromJson(String str) =>
      ProviderDetail.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ProviderDetail.fromMap(Map<String, dynamic> json) => ProviderDetail(
        enabled: json["enabled"] == null ? null : json["enabled"],
        icon: json["icon"] == null ? null : json["icon"],
        key: json["key"] == null ? null : json["key"],
        secret: json["secret"] == null ? null : json["secret"],
        subdomain: json["subdomain"] == null ? null : json["subdomain"],
        callback: json["callback"] == null ? null : json["callback"],
        scope: json["scope"] == null
            ? null
            : List<String>.from(json["scope"].map((x) => x)),
        redirectUri: json["redirectUri"] == null ? null : json["redirectUri"],
        state: json["state"] == null ? null : json["state"],
      );

  Map<String, dynamic> toMap() => {
        "enabled": enabled == null ? null : enabled,
        "icon": icon == null ? null : icon,
        "key": key == null ? null : key,
        "secret": secret == null ? null : secret,
        "subdomain": subdomain == null ? null : subdomain,
        "callback": callback == null ? null : callback,
        "scope": scope == null ? null : List<dynamic>.from(scope.map((x) => x)),
        "redirectUri": redirectUri == null ? null : redirectUri,
        "state": state == null ? null : state,
      };
}

class Email {
  Email({
    this.enabled,
    this.icon,
  });

  bool enabled;
  String icon;

  factory Email.fromJson(String str) => Email.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Email.fromMap(Map<String, dynamic> json) => Email(
        enabled: json["enabled"] == null ? null : json["enabled"],
        icon: json["icon"] == null ? null : json["icon"],
      );

  Map<String, dynamic> toMap() => {
        "enabled": enabled == null ? null : enabled,
        "icon": icon == null ? null : icon,
      };
}
