enum DioTryAgainMessage {
  none("none"),
  connectionTimeout("try_again_connect_timeout_message"),
  noInternet("try_again_no_internet_message"),
  generalError("try_again_something_went_wrong_message");

  final String value;
  const DioTryAgainMessage(this.value);
}

enum NetworkStatus { online, offline, poor }

enum AppScreens {
  main('/main'),
  articleDetails('/article_details'),
  trending('/trending');

  final String route;
  const AppScreens(this.route);
}
