import 'package:news_app/app/data/models/article.dart';
import 'package:news_app/app/data/models/source.dart';

abstract class Base {
  fromJson(Map<String, dynamic> json);
  Map<String, dynamic> toJson();
}

T unmarshal<T>(Map<String, dynamic> map, {Type? type}) {
  type ??= T;

  switch (type) {
    case const (Article):
      return Article.fromJson(map) as T;
    case const (Source):
      return Source.fromJson(map) as T;
    default:
      throw StateError('Unable to unmarshal value of type \'$type\'');
  }
}
