// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'setting.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Setting _$SettingFromJson(Map<String, dynamic> json) {
  return Setting(
    pluginName: json['plugin_name'] as String,
    language: json['language'] as String,
    data: json['data'] == null ? null : DataScreen.fromJson(json['data'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$SettingToJson(Setting instance) => <String, dynamic>{
      'plugin_name': instance.pluginName,
      'language': instance.language,
      'data': Setting.dataToJson(instance.data),
    };

DataScreen _$DataScreenFromJson(Map<String, dynamic> json) {
  return DataScreen(
    screens: (json['screens'] as Map<String, dynamic>)?.map(
      (k, e) => MapEntry(k, e == null ? null : Data.fromJson(e as Map<String, dynamic>)),
    ),
    settings: (json['settings'] as Map<String, dynamic>)?.map(
      (k, e) => MapEntry(k, e == null ? null : Data.fromJson(e as Map<String, dynamic>)),
    ),
    extraScreens: (json['extraScreens'] as Map<String, dynamic>)?.map(
      (k, e) => MapEntry(k, e == null ? null : Data.fromJson(e as Map<String, dynamic>)),
    ),
  );
}

Map<String, dynamic> _$DataScreenToJson(DataScreen instance) => <String, dynamic>{
      'screens': DataScreen.dataToJson(instance.screens),
      'settings': DataScreen.dataToJson(instance.settings),
      'extraScreens': DataScreen.dataToJson(instance.extraScreens),
    };

Data _$DataFromJson(Map<String, dynamic> json) {
  return Data(
    widgets: (json['widgets'] as Map<String, dynamic>)?.map(
      (k, e) => MapEntry(k, e == null ? null : WidgetConfig.fromJson(e as Map<String, dynamic>)),
    ),
    widgetIds: (json['widgetIds'] as List)?.map((e) => e as String)?.toList() ?? [],
    configs: json['configs'] as Map<String, dynamic> ?? {},
  );
}

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'widgets': Data.dataToJson(instance.widgets),
      'widgetIds': instance.widgetIds,
      'configs': instance.configs,
    };

WidgetConfig _$WidgetConfigFromJson(Map<String, dynamic> json) {
  return WidgetConfig(
    id: json['id'] as String,
    type: json['type'] as String,
    fields: json['fields'] as Map<String, dynamic>,
    styles: json['styles'] as Map<String, dynamic>,
    layout: json['layout'] as String,
  );
}

Map<String, dynamic> _$WidgetConfigToJson(WidgetConfig instance) => <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'fields': instance.fields,
      'styles': instance.styles,
      'layout': instance.layout,
    };
