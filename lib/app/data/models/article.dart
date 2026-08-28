import 'package:news_app/app/data/models/base.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:news_app/app/data/models/source.dart';

part 'article.g.dart';

@JsonSerializable()
class Article implements Base {
  @JsonKey(name: "author")
  final String? author;

  @JsonKey(name: "title")
  final String? title;

  @JsonKey(name: "description")
  final String? description;

  @JsonKey(name: "urlToImage")
  final String? urlToImage;

  @JsonKey(name: "url")
  final String? url;

  @JsonKey(name: "publishedAt")
  final String? publishedAt;

  @JsonKey(name: "source")
  final Source? source;

  Article({
    required this.author,
    required this.title,
    required this.description,
    required this.urlToImage,
    required this.url,
    required this.publishedAt,
    required this.source,
  });

  factory Article.fromJson(Map<String, dynamic> json) =>
      _$ArticleFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ArticleToJson(this);

  @override
  fromJson(Map<String, dynamic> json) {
    return Article.fromJson(json);
  }
}
