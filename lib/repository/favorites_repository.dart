import 'package:playgroundmobile/models/favorites.dart';
import 'package:playgroundmobile/services/secure_store_service.dart';

class FavoritesRepository {
  final SecureStoreService _storage;

  FavoritesRepository(this._storage);

  String _getKey(String username) => 'favorites_${username.trim().toLowerCase()}';

  Future<FavoritesModel> loadFavorites(String username) async {
    final rawData = await _storage.read(_getKey(username));
    if (rawData == null || rawData.isEmpty) {
      return const FavoritesModel();
    }
    return FavoritesModel.fromJson(rawData);
  }

  Future<void> saveFavorites(String username, FavoritesModel favorites) async {
    await _storage.write(_getKey(username), favorites.toJson());
  }
}