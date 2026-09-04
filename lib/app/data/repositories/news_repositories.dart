import 'package:news_app/app/data/models/article.dart';
import 'package:news_app/app/core/configs/locator_config.dart';
import 'package:news_app/app/data/models/api_list_response.dart';
import 'package:news_app/app/data/models/repository_result.dart';
import 'package:news_app/app/data/providers/news_api_client.dart';
import 'package:news_app/app/data/repositories/base_repository.dart';

class NewsRepositories extends BaseRepository {
  final NewsAPIClient _newsAPIClient = locatorConfig.get<NewsAPIClient>();

  Future<RepositoryResult> getEverythingRepo({
    required String query,
    required String from,
    required String to,
    String? sources,
    String? country,
    String? sortBy,
    String? language,
  }) async {
    return handleRequest(
      () => _newsAPIClient.getEverythingAPI(
        query,
        from,
        to,
        sources,
        country,
        sortBy,
        language,
      ),
      onSuccess: (ApiListResponse<Article> response) => response.status == "ok"
          ? RepositoryResult(
              isError: false,
              totalResults: response.totalResults,
              data: response.articles ?? [],
              message: 'Success fetch news',
            )
          : RepositoryResult(
              isError: true,
              data: null,
              message: 'Something went wrong',
            ),
    );
  }

  Future<RepositoryResult> getTopHeadlinesRepo({
    String? category,
    required String from,
    required String to,
    String? sources,
    String? country,
    String? sortBy,
    String? language,
  }) async {
    return handleRequest(
      () => _newsAPIClient.getTopHeadlinesAPI(
        category,
        from,
        to,
        sources,
        country,
        sortBy,
        language,
      ),
      onSuccess: (ApiListResponse<Article> response) => response.status == "ok"
          ? RepositoryResult(
              isError: false,
              totalResults: response.totalResults,
              data: response.articles ?? [],
              message: response.message,
            )
          : RepositoryResult(
              isError: true,
              data: [],
              message: response.message,
            ),
    );
  }
}
