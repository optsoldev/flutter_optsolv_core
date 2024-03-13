import 'dart:convert';

import '../storage/secure-storage.dart';

class TokenManager {
  final SecureStorage _storage = SecureStorage();

  final RefreshToken = 'RefreshToken';
  final AccessToken = 'AccessToken';
  final IdToken = 'IdToken';
  final TokenExpiration = 'TokenExpiration';
  final UserInfoToken = 'UserInfoToken';
  final MongoUserId = 'MongoUserId';

  Map<String, dynamic> parseJwt(String token) {
    String normalizedSource = base64Url.normalize(token.split('.')[1]);

    final payloadMap = json.decode(utf8.decode(base64Url.decode(normalizedSource)));
    if (payloadMap is! Map<String, dynamic>) {
      throw Exception('invalid payload');
    }

    return payloadMap;
  }

  Future<void> clear() async {
    await _storage.clear();
  }

  Future<void> storeToken(String? accessToken, String? refreshToken, String? idToken, DateTime? tokenExpiration, String? userInfoToken, String? mongoUserId) async {
    if (accessToken != null) {
      await _storage.save(AccessToken, accessToken);
    }

    if (refreshToken != null) {
      await _storage.save(RefreshToken, refreshToken);
    }

    if (idToken != null) {
      await _storage.save(IdToken, idToken);
    }

    if (tokenExpiration != null) {
      await _storage.save(TokenExpiration, tokenExpiration.toIso8601String());
    }

    if (userInfoToken != null) {
      await _storage.save(UserInfoToken, userInfoToken);
    }

    if (mongoUserId != null) {
      await _storage.save(MongoUserId, mongoUserId);
    }
  }

  Future<String?> getKey(String key) async {
    var response = await _storage.read(key);

    return response;
  }

  Future<void> saveKey(String key, String value) async {
    await _storage.save(key, value);
  }

  Future<bool> isTokenExpired() async {
    bool retorno = true;

    String? tempTokenExpiration = await _storage.read(TokenExpiration);

    if (tempTokenExpiration != null) {
      final actualDate = DateTime.now();
      final tokenDate = DateTime.parse(tempTokenExpiration);

      retorno = actualDate.isAfter(tokenDate);
    }

    return retorno;
  }

  /*Future<String?> refresh() async {
    var refreshToken = await _storage.read('refresh_token');

    var responseBody = {
      "refresh_token": refreshToken,
      "grant_type": 'refresh_token',
      "client_id": 'AppConfig.instance.ClientId',
      "client_secret": 'AppConfig.instance.ClientSecret',
      "scope": 'api1 offline_access'
    };

    Environment env = GetIt.instance<Environment>();

    var response = await http.post(Uri.parse(env.clientSettings.authority + '/connect/token'),
        headers: {HttpHeaders.contentTypeHeader: 'application/x-www-form-urlencoded'}, body: responseBody);

    var jsonToken = json.decode(response.body);

    if (response.statusCode == 200) {
      var token = _parseJwt(jsonToken['access_token']);

      await _storage.save('access_token', jsonToken['access_token']);
      await _storage.save('refresh_token', jsonToken['refresh_token']);
      await _storage.save('exp', token["exp"]);
    } else {
      throw (jsonToken["error_description"]);
    }

    return jsonToken['refresh_token'];
  }*/
}
