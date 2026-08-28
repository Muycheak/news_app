import 'package:dio/dio.dart';
import 'package:news_app/app/data/providers/token_interceptor.dart';

Dio buildDioClient(String baseURL, String apiKey) {
  final dio = Dio()
    ..options = BaseOptions(
      baseUrl: baseURL,
      connectTimeout: Duration(seconds: 30),
      sendTimeout: Duration(seconds: 30),
      receiveTimeout: Duration(seconds: 30),
    );
  dio.interceptors.addAll([
    TokenInterceptor(apiKey: apiKey),
    // // If want to log all request and response, Uncomment PrettyDioLogger below
    //   PrettyDioLogger(
    //       request: false,
    //       requestBody: true,
    //       requestHeader: false,
    //       responseBody: true,
    //       responseHeader: false,
    //       error: true,
    //       logPrint: (object) {
    //         debugPrint(object.toString());
    //       })
  ]);
  return dio;
}
