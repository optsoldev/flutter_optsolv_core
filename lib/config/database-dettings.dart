class DatabaseSettings {
  late String _appId;
  late String _appUrl;
  late Uri _baseUrl;
  late Uri _clientApiBaseUrl;
  late Uri _dataApiBaseUrl;
  late String _dataSourceName;

  String get appId => _appId;
  String get appUrl => _appUrl;
  Uri get baseUrl => _baseUrl;
  Uri get clientApiBaseUrl => _clientApiBaseUrl;
  Uri get dataApiBaseUrl => _dataApiBaseUrl;
  String get dataSourceName => _dataSourceName;

  void loadEnvironment() {
    _appId = const String.fromEnvironment('ATLAS_APPID');
    _appUrl = const String.fromEnvironment('ATLAS_APPURL');
    _baseUrl = Uri.parse(const String.fromEnvironment('ATLAS_BASEURL'));
    _clientApiBaseUrl = Uri.parse(const String.fromEnvironment('ATLAS_CLIENTAPIBASEURL'));
    _dataApiBaseUrl = Uri.parse(const String.fromEnvironment('ATLAS_DATAAPIBASEURL'));
    _dataSourceName = const String.fromEnvironment('ATLAS_DATASOURCENAME');
  }
}
