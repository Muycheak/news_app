// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'article.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Article _$ArticleFromJson(Map<String, dynamic> json) => Article(
  author: json['author'] as String?,
  title: json['title'] as String?,
  description: json['description'] as String?,
  urlToImage: json['urlToImage'] as String?,
  url: json['url'] as String?,
  publishedAt: json['publishedAt'] as String?,
  source: json['source'] == null
      ? null
      : Source.fromJson(json['source'] as Map<String, dynamic>),
);

Map<String, dynamic> _$ArticleToJson(Article instance) => <String, dynamic>{
  'author': instance.author,
  'title': instance.title,
  'description': instance.description,
  'urlToImage': instance.urlToImage,
  'url': instance.url,
  'publishedAt': instance.publishedAt,
  'source': instance.source,
};
