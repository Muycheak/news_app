import 'package:news_app/app/data/models/base.dart';
import 'package:json_annotation/json_annotation.dart';

part 'source.g.dart';

@JsonSerializable()
class Source implements Base {
  @JsonKey(name: "id")
  final int? id;

  @JsonKey(name: "name")
  final String? name;

  Source({required this.id, required this.name});

  factory Source.fromJson(Map<String, dynamic> json) => _$SourceFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$SourceToJson(this);

  @override
  fromJson(Map<String, dynamic> json) {
    return Source.fromJson(json);
  }
}
