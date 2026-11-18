import 'package:flutter_test/flutter_test.dart';
import 'package:playgroundmobile/repository/auth_repository.dart';
import 'package:playgroundmobile/stores/auth/auth_store.dart';

import '../../support/in_memory_secure_store.dart';

void main() {
  group('AuthStore', () {
    late InMemorySecureStore storage;
    late AuthStore store;

    setUp(() {
      storage = InMemorySecureStore();
      store = AuthStore(AuthRepository(storage));
    });

    test('Deve registrar e autenticar um novo utilizador', () async {
      // Arrange
      const username = 'ana';
      const password = 'pass123';

      // Act
      final registered = await store.register(username, password);

      // Assert
      expect(registered, isTrue);
      expect(store.currentUser, username);
      expect(store.isAuthenticated, isTrue);
      expect(store.isLoading, isFalse);
      expect(store.errorMessage, isNull);
    });

    test('Deve rejeitar registo duplicado sem autenticar', () async {
      // Arrange
      await store.register('ana', 'pass123');
      await store.logout();

      // Act
      final registered = await store.register('ANA', 'other-password');

      // Assert
      expect(registered, isFalse);
      expect(store.currentUser, isNull);
      expect(store.errorMessage, 'Já existe um utilizador com esse nome.');
      expect(store.isLoading, isFalse);
    });

    test('Deve rejeitar credenciais incorretas', () async {
      // Arrange
      await store.register('ana', 'pass123');
      await store.logout();

      // Act
      final loggedIn = await store.login('ana', 'wrong-password');

      // Assert
      expect(loggedIn, isFalse);
      expect(store.isAuthenticated, isFalse);
      expect(
        store.errorMessage,
        'Utilizador não encontrado ou palavra-passe incorreta.',
      );
      expect(store.isLoading, isFalse);
    });

    test('Deve recuperar e encerrar a sessão', () async {
      // Arrange
      await store.register('ana', 'pass123');
      store = AuthStore(AuthRepository(storage));

      // Act
      await store.checkSession();

      // Assert
      expect(store.currentUser, 'ana');
      expect(store.isAuthenticated, isTrue);

      await store.logout();

      expect(store.currentUser, isNull);
      expect(store.isAuthenticated, isFalse);
      expect(store.isLoading, isFalse);
    });
  });
}
