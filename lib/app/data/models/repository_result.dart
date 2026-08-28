class RepositoryResult {
  final bool isError;
  final String message;
  final int totalResults;
  final dynamic data;

  RepositoryResult({
    required this.isError,
    this.totalResults = 0,
    required this.message,
    this.data,
  });
}
