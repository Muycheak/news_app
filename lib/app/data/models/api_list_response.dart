import 'package:news_app/app/data/models/base.dart';

class ApiListResponse<T extends Base> {
  String status;
  String code;
  String message;
  int totalResults;
  List<T>? articles;

  ApiListResponse({
    required this.status,
    required this.code,
    required this.message,
    required this.totalResults,
    required this.articles,
  });

  factory ApiListResponse.fromJson(Map<String, dynamic> json) {
    var rawData = json['articles'];
    List<dynamic> listData = [];

    if (rawData is List) {
      listData = rawData;
    } else if (rawData is Map<String, dynamic>) {
      if (rawData.containsKey('articles') && rawData['articles'] is List) {
        listData = rawData['articles'];
      }
    }

    List<T> lists = listData.map((item) => unmarshal<T>(item)).toList();

    return ApiListResponse<T>(
      status: json["status"] ?? "",
      code: json["code"] ?? "",
      message: json["message"] ?? "",
      totalResults: json["totalResults"] ?? 0,
      articles: lists,
    );
  }

  Map<String, dynamic> toJson() => {
    "status": status,
    "code": code,
    "message": message,
    "totalResults": totalResults,
    "articles": articles,
  };
}
