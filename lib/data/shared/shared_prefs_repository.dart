import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SharedPrefsRepository {
  // access token key
  final String _tokenKey = 'access-token';
  final FlutterSecureStorage _storage;

  SharedPrefsRepository(FlutterSecureStorage storage) : _storage = storage;

  Future<String?> getAccessToken() async {
    // get the access token from storage
    final token = await _storage.read(key: _tokenKey);
    return token;
  }

  Future<void> saveAccessToken(String token) async {
    await _storage.write(key: _tokenKey, value: token);
  }

  Future<void> deleteAccessToken() async {
    await _storage.delete(key: _tokenKey);
    await _storage.deleteAll();
  }
}
