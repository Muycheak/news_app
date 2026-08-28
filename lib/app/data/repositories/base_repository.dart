import 'package:dio/dio.dart';
import 'package:news_app/app/core/constants/app_enum.dart';
import 'package:news_app/app/data/models/repository_result.dart';
import 'package:news_app/app/core/services/network_checking_service.dart';

abstract class BaseRepository {
  Future<RepositoryResult> handleRequest<T>(
    Future<T> Function() request, {
    required RepositoryResult Function(T response) onSuccess,
  }) async {
    try {
      final response = await request();
      return onSuccess(response);
    } on DioException catch (err) {
      return _handleDioException(err);
    } catch (_) {
      return _generalError();
    }
  }

  RepositoryResult _handleDioException(DioException err) {
    final isTimeout =
        err.type == DioExceptionType.connectionTimeout ||
        err.type == DioExceptionType.receiveTimeout ||
        err.type == DioExceptionType.sendTimeout;

    if (isTimeout) {
      return RepositoryResult(
        isError: true,
        message: DioTryAgainMessage.connectionTimeout.value,
      );
    }

    final isOffline =
        NetworkCheckingService.instance.status == NetworkStatus.poor ||
        NetworkCheckingService.instance.status == NetworkStatus.offline;

    if (isOffline) {
      return RepositoryResult(
        isError: true,
        message: DioTryAgainMessage.noInternet.value,
      );
    }

    return _generalError();
  }

  RepositoryResult _generalError() => RepositoryResult(
    isError: true,
    message: DioTryAgainMessage.generalError.value,
  );
}
