import 'dart:convert';

import 'package:playgroundmobile/models/user.dart';
import 'package:playgroundmobile/services/secure_store_service.dart';

class AuthRepository {
  final SecureStoreService _storage;

  static const _sessionKey = 'active_user';

  const AuthRepository(this._storage);

  String _getUserKey(String user) => 'user_${user.trim().toLowerCase()}';

  Future<bool> registerUser(User user) async{
    final key = _getUserKey(user.name);

    final existingUser = await  _storage.read(key);
    if (existingUser!=null) return false;

    await _storage.write(key, jsonEncode(user.toMap()));
    return true;
}

  Future<bool> login(String name, String password) async{
    final key = _getUserKey(name);
    final rawData = await _storage.read(key);

    if (rawData == null) return false;

    final user =  User.fromMap(jsonDecode(rawData));

    if (user.password == password){
      await _storage.write(_sessionKey, user.name);
      return true;
    }
    return false;
  }


  Future<String?> getActiveUser() async {
    return await _storage.read(_sessionKey);
  }

  Future<bool> isSessionActive() async {
    final activeUser = await getActiveUser();
    return activeUser != null && activeUser.isNotEmpty;
  }

  Future<void> logout() async {
    await _storage.delete(_sessionKey);
  }
}