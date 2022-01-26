// To parse this JSON data, do
//
//     final contentTypeConfiguration = contentTypeConfigurationFromMap(jsonString);

import 'dart:convert';

class ContentTypeConfiguration {
  ContentTypeConfiguration({
    this.contentType,
    this.components,
  });

  ContentType contentType;
  Components components;

  factory ContentTypeConfiguration.fromJson(String str) =>
      ContentTypeConfiguration.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ContentTypeConfiguration.fromMap(Map<String, dynamic> json) =>
      ContentTypeConfiguration(
        contentType: json["contentType"] == null
            ? null
            : ContentType.fromMap(json["contentType"]),
        components: json["components"] == null
            ? null
            : Components.fromMap(json["components"]),
      );

  Map<String, dynamic> toMap() => {
        "contentType": contentType == null ? null : contentType.toMap(),
        "components": components == null ? null : components.toMap(),
      };
}

class Components {
  Components();

  factory Components.fromJson(String str) =>
      Components.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Components.fromMap(Map<String, dynamic> json) => Components();

  Map<String, dynamic> toMap() => {};
}

class ContentType {
  ContentType({
    this.uid,
    this.settings,
    this.metadatas,
    this.layouts,
  });

  String uid;
  Settings settings;
  Map<String, dynamic> metadatas;
  Map<String, dynamic> layouts;

  factory ContentType.fromJson(String str) =>
      ContentType.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ContentType.fromMap(Map<String, dynamic> json) => ContentType(
        uid: json["uid"] == null ? null : json["uid"],
        settings: json["settings"] == null
            ? null
            : Settings.fromMap(json["settings"]),
        metadatas: json["metadatas"] == null ? null : json["metadatas"],
        layouts: json["layouts"] == null ? null : json["layouts"],
      );

  Map<String, dynamic> toMap() => {
        "uid": uid == null ? null : uid,
        "settings": settings == null ? null : settings.toMap(),
        "metadatas": metadatas == null ? null : metadatas,
        "layouts": layouts == null ? null : layouts,
      };
}

class Settings {
  Settings({
    this.bulkable,
    this.filterable,
    this.searchable,
    this.pageSize,
    this.mainField,
    this.defaultSortBy,
    this.defaultSortOrder,
  });

  bool bulkable;
  bool filterable;
  bool searchable;
  int pageSize;
  String mainField;
  String defaultSortBy;
  String defaultSortOrder;

  factory Settings.fromJson(String str) => Settings.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Settings.fromMap(Map<String, dynamic> json) => Settings(
        bulkable: json["bulkable"] == null ? null : json["bulkable"],
        filterable: json["filterable"] == null ? null : json["filterable"],
        searchable: json["searchable"] == null ? null : json["searchable"],
        pageSize: json["pageSize"] == null ? null : json["pageSize"],
        mainField: json["mainField"] == null ? null : json["mainField"],
        defaultSortBy:
            json["defaultSortBy"] == null ? null : json["defaultSortBy"],
        defaultSortOrder:
            json["defaultSortOrder"] == null ? null : json["defaultSortOrder"],
      );

  Map<String, dynamic> toMap() => {
        "bulkable": bulkable == null ? null : bulkable,
        "filterable": filterable == null ? null : filterable,
        "searchable": searchable == null ? null : searchable,
        "pageSize": pageSize == null ? null : pageSize,
        "mainField": mainField == null ? null : mainField,
        "defaultSortBy": defaultSortBy == null ? null : defaultSortBy,
        "defaultSortOrder": defaultSortOrder == null ? null : defaultSortOrder,
      };
}

class MetadataValue {
  MetadataValue({
    this.edit,
    this.list,
  });

  Edit edit;
  ListClass list;

  factory MetadataValue.fromJson(String str) =>
      MetadataValue.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory MetadataValue.fromMap(Map<String, dynamic> json) => MetadataValue(
        edit: json["edit"] == null ? null : Edit.fromMap(json["edit"]),
        list: json["list"] == null ? null : ListClass.fromMap(json["list"]),
      );

  Map<String, dynamic> toMap() => {
        "edit": edit == null ? null : edit.toMap(),
        "list": list == null ? null : list.toMap(),
      };
}

class Edit {
  Edit({
    this.label,
    this.description,
    this.placeholder,
    this.visible,
    this.editable,
    this.mainField,
  });

  String label;
  String description;
  String placeholder;
  bool visible;
  bool editable;
  String mainField;

  factory Edit.fromJson(String str) => Edit.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Edit.fromMap(Map<String, dynamic> json) => Edit(
        label: json["label"] == null ? null : json["label"],
        description: json["description"] == null ? null : json["description"],
        placeholder: json["placeholder"] == null ? null : json["placeholder"],
        visible: json["visible"] == null ? null : json["visible"],
        editable: json["editable"] == null ? null : json["editable"],
        mainField: json["mainField"] == null ? null : json["mainField"],
      );

  Map<String, dynamic> toMap() => {
        "label": label == null ? null : label,
        "description": description == null ? null : description,
        "placeholder": placeholder == null ? null : placeholder,
        "visible": visible == null ? null : visible,
        "editable": editable == null ? null : editable,
        "mainField": mainField == null ? null : mainField,
      };
}

class ListClass {
  ListClass({
    this.label,
    this.searchable,
    this.sortable,
    this.mainField,
  });

  String label;
  bool searchable;
  bool sortable;
  String mainField;

  factory ListClass.fromJson(String str) => ListClass.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ListClass.fromMap(Map<String, dynamic> json) => ListClass(
        label: json["label"] == null ? null : json["label"],
        searchable: json["searchable"] == null ? null : json["searchable"],
        sortable: json["sortable"] == null ? null : json["sortable"],
        mainField: json["mainField"] == null ? null : json["mainField"],
      );

  Map<String, dynamic> toMap() => {
        "label": label == null ? null : label,
        "searchable": searchable == null ? null : searchable,
        "sortable": sortable == null ? null : sortable,
        "mainField": mainField == null ? null : mainField,
      };
}

class LayoutValue {
  LayoutValue({
    this.edit,
    this.editRelations,
    this.list,
  });

  List<List<Edit>> edit;
  List<String> editRelations;
  List<String> list;

  factory LayoutValue.fromJson(String str) =>
      LayoutValue.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory LayoutValue.fromMap(Map<String, dynamic> json) => LayoutValue(
        edit: json["edit"] == null
            ? null
            : List<List<Edit>>.from(json["edit"]
                .map((x) => List<Edit>.from(x.map((x) => Edit.fromMap(x))))),
        editRelations: json["editRelations"] == null
            ? null
            : List<String>.from(json["editRelations"].map((x) => x)),
        list: json["list"] == null
            ? null
            : List<String>.from(json["list"].map((x) => x)),
      );

  Map<String, dynamic> toMap() => {
        "edit": edit == null
            ? null
            : List<dynamic>.from(
                edit.map((x) => List<dynamic>.from(x.map((x) => x.toMap())))),
        "editRelations": editRelations == null
            ? null
            : List<dynamic>.from(editRelations.map((x) => x)),
        "list": list == null ? null : List<dynamic>.from(list.map((x) => x)),
      };
}

class EditLayout {
  EditLayout({
    this.name,
    this.size,
  });

  String name;
  int size;

  factory EditLayout.fromJson(String str) =>
      EditLayout.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory EditLayout.fromMap(Map<String, dynamic> json) => EditLayout(
        name: json["name"] == null ? null : json["name"],
        size: json["size"] == null ? null : json["size"],
      );

  Map<String, dynamic> toMap() => {
        "name": name == null ? null : name,
        "size": size == null ? null : size,
      };
}
