import 'dart:convert';

class ProviderModel {
  ProviderModel({
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

  Email email;
  Provider discord;
  Provider facebook;
  Provider google;
  Provider github;
  Provider microsoft;
  Provider twitter;
  Provider instagram;
  Provider vk;
  Provider twitch;
  Provider linkedin;
  Provider cognito;
  Provider reddit;
  Provider auth0;
  Provider cas;

  factory ProviderModel.fromRawJson(String str) => ProviderModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ProviderModel.fromJson(Map<String, dynamic> json) => ProviderModel(
        email: json["email"] == null ? null : Email.fromJson(json["email"]),
        discord: json["discord"] == null ? null : Provider.fromJson(json["discord"]),
        facebook: json["facebook"] == null ? null : Provider.fromJson(json["facebook"]),
        google: json["google"] == null ? null : Provider.fromJson(json["google"]),
        github: json["github"] == null ? null : Provider.fromJson(json["github"]),
        microsoft: json["microsoft"] == null ? null : Provider.fromJson(json["microsoft"]),
        twitter: json["twitter"] == null ? null : Provider.fromJson(json["twitter"]),
        instagram: json["instagram"] == null ? null : Provider.fromJson(json["instagram"]),
        vk: json["vk"] == null ? null : Provider.fromJson(json["vk"]),
        twitch: json["twitch"] == null ? null : Provider.fromJson(json["twitch"]),
        linkedin: json["linkedin"] == null ? null : Provider.fromJson(json["linkedin"]),
        cognito: json["cognito"] == null ? null : Provider.fromJson(json["cognito"]),
        reddit: json["reddit"] == null ? null : Provider.fromJson(json["reddit"]),
        auth0: json["auth0"] == null ? null : Provider.fromJson(json["auth0"]),
        cas: json["cas"] == null ? null : Provider.fromJson(json["cas"]),
      );

  Map<String, dynamic> toJson() => {
        "email": email == null ? null : email.toJson(),
        "discord": discord == null ? null : discord.toJson(),
        "facebook": facebook == null ? null : facebook.toJson(),
        "google": google == null ? null : google.toJson(),
        "github": github == null ? null : github.toJson(),
        "microsoft": microsoft == null ? null : microsoft.toJson(),
        "twitter": twitter == null ? null : twitter.toJson(),
        "instagram": instagram == null ? null : instagram.toJson(),
        "vk": vk == null ? null : vk.toJson(),
        "twitch": twitch == null ? null : twitch.toJson(),
        "linkedin": linkedin == null ? null : linkedin.toJson(),
        "cognito": cognito == null ? null : cognito.toJson(),
        "reddit": reddit == null ? null : reddit.toJson(),
        "auth0": auth0 == null ? null : auth0.toJson(),
        "cas": cas == null ? null : cas.toJson(),
      };
}

class Provider {
  Provider({
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
  Key key;
  Secret secret;
  String subdomain;
  String callback;
  List<String> scope;
  String redirectUri;
  bool state;

  factory Provider.fromRawJson(String str) => Provider.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Provider.fromJson(Map<String, dynamic> json) => Provider(
        enabled: json["enabled"] == null ? null : json["enabled"],
        icon: json["icon"] == null ? null : json["icon"],
        key: json["key"] == null ? null : keyValues.map[json["key"]],
        secret: json["secret"] == null ? null : secretValues.map[json["secret"]],
        subdomain: json["subdomain"] == null ? null : json["subdomain"],
        callback: json["callback"] == null ? null : json["callback"],
        scope: json["scope"] == null ? null : List<String>.from(json["scope"].map((x) => x)),
        redirectUri: json["redirectUri"] == null ? null : json["redirectUri"],
        state: json["state"] == null ? null : json["state"],
      );

  Map<String, dynamic> toJson() => {
        "enabled": enabled == null ? null : enabled,
        "icon": icon == null ? null : icon,
        "key": key == null ? null : keyValues.reverse[key],
        "secret": secret == null ? null : secretValues.reverse[secret],
        "subdomain": subdomain == null ? null : subdomain,
        "callback": callback == null ? null : callback,
        "scope": scope == null ? null : List<dynamic>.from(scope.map((x) => x)),
        "redirectUri": redirectUri == null ? null : redirectUri,
        "state": state == null ? null : state,
      };
}

enum Key { EMPTY, ADS }

final keyValues = EnumValues({"ads": Key.ADS, "": Key.EMPTY});

enum Secret { EMPTY, ASD }

final secretValues = EnumValues({"asd": Secret.ASD, "": Secret.EMPTY});

class Email {
  Email({
    this.enabled,
    this.icon,
  });

  bool enabled;
  String icon;

  factory Email.fromRawJson(String str) => Email.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Email.fromJson(Map<String, dynamic> json) => Email(
        enabled: json["enabled"] == null ? null : json["enabled"],
        icon: json["icon"] == null ? null : json["icon"],
      );

  Map<String, dynamic> toJson() => {
        "enabled": enabled == null ? null : enabled,
        "icon": icon == null ? null : icon,
      };
}

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
