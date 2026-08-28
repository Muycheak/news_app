import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:dio/src/form_data.dart' as form_data;

class TokenInterceptor extends QueuedInterceptor {
  final String apiKey;

  TokenInterceptor({required this.apiKey});

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    try {
      options.headers["X-Api-Key"] = apiKey;
    } catch (e) {
      debugPrint("TokenInterceptor error: ${e.toString()}");
    }

    debugPrint(
      "=========================START\n${options.method}: ${options.baseUrl}${options.path} \nQueries: ${options.queryParameters} \nBody: ${options.data} \n=========================END",
    );

    options.headers["Content-Type"] = "application/json";

    if (options.data is form_data.FormData) {
      form_data.FormData formData = options.data as form_data.FormData;
      Map<String, dynamic> fields = {};
      for (var entry in formData.fields) {
        fields[entry.key] = entry.value;
      }
    }
    super.onRequest(options, handler);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    debugPrint("TokenInterceptor onError $err");
    debugPrint("TokenInterceptor onError response ${err.response}");
    debugPrint("requestHeader : ${err.response?.headers}");

    //for status codes other than 401, 499, we send error to View
    var exceptionalStatusCodes = [401, 499];

    if (err.response?.statusCode == 401) {
      // refresh token here
    }

    if (err.response?.statusCode == 499) {
      // log out here
    }

    if (!exceptionalStatusCodes.contains(err.response?.statusCode)) {
      handler.next(err);
    }
  }
}
