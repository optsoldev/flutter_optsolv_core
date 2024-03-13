import 'client-settings.dart';

enum BuildEnviroment { Dev, Hom, Prod }

class Environment {
  late String _apiUrl;
  late String _apiNotificacaoUrl;
  late String _authorizeUrl;
  late String _tokenUrl;
  late String _discoveryUrl;
  late List<String> _scope;
  late List<String> _scopeSso;
  late String _clientId;
  late String _scheme;
  late String _redirectUrl;
  late String _packageName;
  late String _dynamicLinkPrefix;
  late String _tenantId;
  late ClientSettings _clientSettings;

  String get authorizeUrl => _authorizeUrl;
  String get tokenUrl => _tokenUrl;
  String get discoveryUrl => _discoveryUrl;
  List<String> get scope => _scope;
  List<String> get scopeSso => _scopeSso;
  String get clientId => _clientId;
  String get apiUrl => _apiUrl;
  String get apiNotificacaoUrl => _apiNotificacaoUrl;
  String get scheme => _scheme;
  String get redirectUrl => _redirectUrl;
  String get packageName => _packageName;
  String get dynamicLinkPrefix => _dynamicLinkPrefix;
  String get tenantId => _tenantId;
  ClientSettings get clientSettings => _clientSettings;

  void setTenantId(String id) => _tenantId = id;

  static Environment get instance => _singleton;
  static final Environment _singleton = Environment._internal();

  factory Environment() => _singleton;

  Environment._internal() {
    _clientSettings = ClientSettings();

    init();
  }

  void init() {
    loadEnvironment();

    clientSettings.loadEnvironment();
  }

  void loadEnvironment() async {
    /*PackageInfo packageInfo = await PackageInfo.fromPlatform();

    _packageName = packageInfo.packageName;

    String env = _packageName;

    env = env.substring(env.lastIndexOf('.') + 1);*/

    _apiUrl = const String.fromEnvironment('API_URL');
    _apiNotificacaoUrl = const String.fromEnvironment('API_NOTIFICACAO_URL');
    _authorizeUrl = const String.fromEnvironment('AUTHORIZE_URL');
    _tokenUrl = const String.fromEnvironment('TOKEN_URL');
    _discoveryUrl = const String.fromEnvironment('DISCOVERY_URL');
    _scope = const String.fromEnvironment('SCOPE').split(',');
    _scopeSso = const String.fromEnvironment('SCOPE_SSO').split(',');
    _clientId = const String.fromEnvironment('CLIENT_ID');
    _dynamicLinkPrefix = const String.fromEnvironment('DYNAMIC_LINK_PREFIX');

    _tenantId = '';

    _scheme = 'msauth.br.com.novaformapvc.vendamais';
    _redirectUrl = 'msauth.br.com.novaformapvc.vendamais://auth/';
  }
}
