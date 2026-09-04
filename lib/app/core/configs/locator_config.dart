import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:news_app/app/data/providers/dio_client.dart';
import 'package:news_app/app/data/providers/news_api_client.dart'
    show NewsAPIClient;
import 'package:news_app/app/core/configs/app_config.dart';

final locatorConfig = GetIt.instance; // GetIt.I is also valid
Future<void> initLocatorConfig() async {
  const String apiKey = AppConfig.apiKey;
  const String baseUrl = AppConfig.baseUrl;
  final dio = buildDioClient(baseUrl, apiKey);
  // register the main Dio instance so other code (e.g. TokenInterceptor._retry)
  // can retrieve it from the service locator without throwing "Did you
  // forget to register it?" when calling `serviceLocator.get<Dio>()`.
  locatorConfig.registerLazySingleton<Dio>(() => dio);
  locatorConfig.registerLazySingleton<NewsAPIClient>(() => NewsAPIClient(dio));
}
