import 'package:news_app/app/data/models/base.dart';

class ApiResponse<T extends Base> {
  String status;
  List<T>? articles;

  ApiResponse({required this.status, required this.articles});

  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    // debugPrint("json: ${json}");

    return ApiResponse<T>(
      status: json["status"],
      articles: json.containsKey("data")
          ? (T == Base ? json["data"] : unmarshal<T>(json["data"]))
          : null,
    );
  }

  Map<String, dynamic> toJson() => {"status": status, "articles": articles};
}
