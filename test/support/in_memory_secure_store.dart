import 'package:playgroundmobile/services/secure_store_service.dart';

class InMemorySecureStore extends SecureStoreService {
  final Map<String, String> _values = {};

  @override
  Future<void> write(String key, String value) async {
    _values[key] = value;
  }

  @override
  Future<String?> read(String key) async => _values[key];

  @override
  Future<void> delete(String key) async {
    _values.remove(key);
  }

  @override
  Future<void> clearAll() async {
    _values.clear();
  }
}
