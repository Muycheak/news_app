import 'package:dio/dio.dart';
import 'package:dotenv/dotenv.dart';
import 'package:retrofit/retrofit.dart';
import 'package:news_app/app/data/models/article.dart';
import 'package:news_app/app/data/models/api_list_response.dart';

part 'news_api_client.g.dart';

final dotEnv = DotEnv(includePlatformEnvironment: true)..load();
String apiKey = dotEnv["API_KEY"] ?? "";

@RestApi()
abstract class NewsAPIClient {
  factory NewsAPIClient(Dio dio, {String baseUrl}) = _NewsAPIClient;

  @GET("/everything")
  Future<ApiListResponse<Article>> getEverythingAPI(
    @Query("q") String q,
    @Query("from") String from,
    @Query("sources") String sources,
    @Query("country") String country,
    @Query("sortBy") String sortBy,
    @Query("language") String language,
  );

  @GET("/top-headlines")
  Future<ApiListResponse<Article>> getTopHeadlinesAPI(
    @Query("q") String q,
    @Query("from") String from,
    @Query("sources") String sources,
    @Query("country") String country,
    @Query("sortBy") String sortBy,
    @Query("language") String language,
  );
}
