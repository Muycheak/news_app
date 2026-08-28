import 'package:dio/dio.dart';
import 'package:dotenv/dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:news_app/app/data/providers/dio_client.dart';
import 'package:news_app/app/data/providers/news_api_client.dart'
    show NewsAPIClient;

final dotEnv = DotEnv(includePlatformEnvironment: true)..load();

final locatorConfig = GetIt.instance; // GetIt.I is also valid
Future<void> initLocatorConfig() async {
  //for API version 1
  final url = dotEnv["BASE_URL"] ?? "";
  final apiKey = dotEnv["API_KEY"] ?? "";
  final dio = buildDioClient(url, apiKey);
  // register the main Dio instance so other code (e.g. TokenInterceptor._retry)
  // can retrieve it from the service locator without throwing "Did you
  // forget to register it?" when calling `serviceLocator.get<Dio>()`.
  locatorConfig.registerLazySingleton<Dio>(() => dio);
  locatorConfig.registerLazySingleton<NewsAPIClient>(() => NewsAPIClient(dio));
}
