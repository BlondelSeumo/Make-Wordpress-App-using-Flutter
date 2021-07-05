import 'package:json_annotation/json_annotation.dart';

part 'setting.g.dart';

@JsonSerializable()
class Setting {
  @JsonKey(name: 'plugin_name')
  String pluginName;

  String language;

  @JsonKey(toJson: dataToJson)
  DataScreen data;

  Setting({
    this.pluginName,
    this.language,
    this.data,
  });

  factory Setting.fromJson(Map<String, dynamic> json) => _$SettingFromJson(json);

  Map<String, dynamic> toJson() => _$SettingToJson(this);

  static dataToJson(DataScreen data) => data.toJson();
}

@JsonSerializable()
class DataScreen {
  @JsonKey(toJson: dataToJson)
  Map<String, Data> screens;

  @JsonKey(toJson: dataToJson)
  Map<String, Data> settings;

  @JsonKey(toJson: dataToJson)
  Map<String, Data> extraScreens;

  DataScreen({
    this.screens,
    this.settings,
    this.extraScreens,
  });

  factory DataScreen.fromJson(Map<String, dynamic> json) => _$DataScreenFromJson(json);

  Map<String, dynamic> toJson() => _$DataScreenToJson(this);

  static Map<String, dynamic> dataToJson(Map<String, Data> json) {
    if (json == null) return {};
    final result = Map.fromEntries(json.keys.map((key) => MapEntry(key, json[key].toJson())));
    return result;
  }
}

@JsonSerializable()
class Data {
  @JsonKey(toJson: dataToJson)
  Map<String, WidgetConfig> widgets;

  @JsonKey(defaultValue: [])
  List<String> widgetIds;

  @JsonKey(defaultValue: {})
  Map<String, dynamic> configs;

  Data({
    this.widgets,
    this.widgetIds,
    this.configs,
  });

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);

  static Map<String, dynamic> dataToJson(Map<String, WidgetConfig> json) {
    if (json == null) return {};

    final result = Map.fromEntries(json.keys.map((key) => MapEntry(key, json[key].toJson())));
    return result;
  }
}

@JsonSerializable()
class WidgetConfig {
  String id;

  String type;

  Map<String, dynamic> fields;

  Map<String, dynamic> styles;

  String layout;

  WidgetConfig({
    this.id,
    this.type,
    this.fields,
    this.styles,
    this.layout,
  });

  factory WidgetConfig.fromJson(Map<String, dynamic> json) => _$WidgetConfigFromJson(json);

  Map<String, dynamic> toJson() => _$WidgetConfigToJson(this);
}
