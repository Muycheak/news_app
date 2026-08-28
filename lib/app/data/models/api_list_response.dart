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
    // debugPrint("json: ${json}");
    var rawData = json['data'];
    List<dynamic> listData = [];

    if (rawData is List) {
      listData = rawData;
    } else if (rawData is Map<String, dynamic>) {
      // Handle Laravel/paginated response where data is wrapped
      if (rawData.containsKey('data') && rawData['data'] is List) {
        listData = rawData['data'];
      } else if (rawData.containsKey('items') && rawData['items'] is List) {
        listData = rawData['items'];
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
