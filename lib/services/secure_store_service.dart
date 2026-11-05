import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStoreService {
  final _storage = FlutterSecureStorage(
    aOptions: AndroidOptions(
      resetOnError: true
    )
  );

  Future white(String key, String value) => _storage.write(key: key, value: value);
  Future<String?> read(String key) => _storage.read(key: key);
  Future delete(String key) => _storage.delete(key: key);
  Future clearAll() => _storage.deleteAll();
}

