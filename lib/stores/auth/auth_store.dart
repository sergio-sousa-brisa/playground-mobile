import 'package:mobx/mobx.dart';
import 'package:playgroundmobile/models/user.dart';
import 'package:playgroundmobile/repository/auth_repository.dart';

part 'auth_store.g.dart';

class AuthStore = _AuthStoreBase with _$AuthStore;

abstract class _AuthStoreBase with Store {
  final AuthRepository _repository;

  _AuthStoreBase(this._repository);

  @observable
  String? currentUser;

  @observable
  bool isLoading = false;

  @observable
  String? errorMessage;

  @computed
  bool get isAuthenticated => currentUser != null && currentUser!.isNotEmpty;

  @action
  Future<void> checkSession() async {
    isLoading = true;
    errorMessage = null;
    try {
      final active = await _repository.getActiveUser();
      currentUser = active;
    } catch (e) {
      errorMessage = 'Falha ao verificar sessão existente.';
    } finally {
      isLoading = false;
    }
  }

  @action
  Future<bool> login(String name, String password) async {
    isLoading = true;
    errorMessage = null;
    try {
      final success = await _repository.login(name, password);
      if (success) {
        currentUser = name;
        return true;
      } else {
        errorMessage = 'Utilizador não encontrado ou palavra-passe incorreta.';
        return false;
      }
    } catch (e) {
      errorMessage = 'Erro ao tentar autenticar.';
      return false;
    } finally {
      isLoading = false;
    }
  }

  @action
  Future<bool> register(String name, String password) async {
    isLoading = true;
    errorMessage = null;
    try {
      final created = await _repository.registerUser(
        User(name: name, password: password),
      );

      if (created) {
        await _repository.login(name, password);
        currentUser = name;
        return true;
      } else {
        errorMessage = 'Já existe um utilizador com esse nome.';
        return false;
      }
    } catch (e) {
      errorMessage = 'Erro ao registar novo utilizador.';
      return false;
    } finally {
      isLoading = false;
    }
  }

  @action
  Future<void> logout() async {
    isLoading = true;
    try {
      await _repository.logout();
      currentUser = null;
    } finally {
      isLoading = false;
    }
  }
}