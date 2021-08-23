import 'package:flutter_secure_storage/flutter_secure_storage.dart';

enum SecureStorageKey {
  email,
  password,
  accessToken,
  refreshToken,
  userName,
  userId,
  isLogged,
}

class SecureStorageService {
  static const FlutterSecureStorage _secureStorage = FlutterSecureStorage();

  static Future<String?> read(SecureStorageKey key) async {
    if (await _secureStorage.containsKey(key: _getEnumValue(key))) {
      return _secureStorage.read(key: _getEnumValue(key));
    } else {
      return null;
    }
  }

  static String _getEnumValue(SecureStorageKey key) {
    return key.toString().split('.').last;
  }

  static Future<Map?> readAll() => _secureStorage.readAll();

  static Future<void> write(SecureStorageKey key, String value) =>
      _secureStorage.write(key: _getEnumValue(key), value: value);

  static Future<void> delete(SecureStorageKey key) =>
      _secureStorage.delete(key: key.toString());

  static Future<void> deleteAll() => _secureStorage.deleteAll();
}
