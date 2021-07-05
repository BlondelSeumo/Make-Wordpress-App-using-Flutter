import 'package:json_annotation/json_annotation.dart';

part 'attributes.g.dart';

@JsonSerializable(createToJson: false)
class Option {
  @JsonKey(name: 'term_id')
  int termId;

  String taxonomy;

  String name;

  String slug;

  int count;

  @JsonKey(nullable: true)
  String value;

  Option({this.termId, this.taxonomy, this.name, this.slug, this.count, this.value});

  factory Option.fromJson(Map<String, dynamic> json) => _$OptionFromJson(json);
}

@JsonSerializable(createToJson: false, createFactory: false)
class AttributeOptions {
  final List<Option> options;

  AttributeOptions({
    this.options,
  });

  factory AttributeOptions.fromJson(List<dynamic> json) {
    List<Option> options = <Option>[];
    options = json.map((option) => Option.fromJson(option)).toList();

    return AttributeOptions(
      options: options,
    );
  }
}

@JsonSerializable(createToJson: false)
class Attribute {
  int id;
  String name;
  String slug;
  String type;
  @JsonKey(name: 'has_archives')
  bool hasArchives;
  AttributeOptions options;
  AttributeOptions terms;

  Attribute({this.id, this.name, this.slug, this.type, this.hasArchives, this.options});

  factory Attribute.fromJson(Map<String, dynamic> json) => _$AttributeFromJson(json);
}

@JsonSerializable(createToJson: false, createFactory: false)
class Attributes {
  final List<Attribute> attributes;

  Attributes({
    this.attributes,
  });

  factory Attributes.fromJson(List<dynamic> json) {
    List<Attribute> attributes = <Attribute>[];
    attributes = json.map((attribute) => Attribute.fromJson(attribute)).toList();

    return Attributes(
      attributes: attributes,
    );
  }
}

class ItemAttributeSelected {
  String taxonomy;

  String field;

  int terms;

  String title = '';

  ItemAttributeSelected({this.taxonomy, this.field, this.terms, this.title});

  Map get query => {'taxonomy': taxonomy, 'field': field, 'terms': terms};
}
