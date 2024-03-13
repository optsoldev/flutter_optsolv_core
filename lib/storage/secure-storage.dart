import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract class ISecureStorage {
  Future<void> save(String key, String value);
  Future<String?> read(String key);
  Future<void> delete(String key);
  Future<void> clear();
}

class SecureStorage implements ISecureStorage {
  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();

  @override
  Future<void> save(String key, String value) async {
    await secureStorage.write(key: key, value: value);
  }

  @override
  Future<String?> read(String key) async {
    return await secureStorage.read(key: key);
  }

  @override
  Future<void> delete(String key) async {
    await secureStorage.delete(key: key);
  }

  @override
  Future<void> clear() async {
    await secureStorage.deleteAll();
  }
}
