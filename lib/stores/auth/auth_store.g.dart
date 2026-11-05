// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AuthStore on _AuthStoreBase, Store {
  Computed<bool>? _$isAuthenticatedComputed;

  @override
  bool get isAuthenticated => (_$isAuthenticatedComputed ??= Computed<bool>(
    () => super.isAuthenticated,
    name: '_AuthStoreBase.isAuthenticated',
  )).value;

  late final _$currentUserAtom = Atom(
    name: '_AuthStoreBase.currentUser',
    context: context,
  );

  @override
  String? get currentUser {
    _$currentUserAtom.reportRead();
    return super.currentUser;
  }

  @override
  set currentUser(String? value) {
    _$currentUserAtom.reportWrite(value, super.currentUser, () {
      super.currentUser = value;
    });
  }

  late final _$isLoadingAtom = Atom(
    name: '_AuthStoreBase.isLoading',
    context: context,
  );

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  late final _$errorMessageAtom = Atom(
    name: '_AuthStoreBase.errorMessage',
    context: context,
  );

  @override
  String? get errorMessage {
    _$errorMessageAtom.reportRead();
    return super.errorMessage;
  }

  @override
  set errorMessage(String? value) {
    _$errorMessageAtom.reportWrite(value, super.errorMessage, () {
      super.errorMessage = value;
    });
  }

  late final _$checkSessionAsyncAction = AsyncAction(
    '_AuthStoreBase.checkSession',
    context: context,
  );

  @override
  Future<void> checkSession() {
    return _$checkSessionAsyncAction.run(() => super.checkSession());
  }

  late final _$loginAsyncAction = AsyncAction(
    '_AuthStoreBase.login',
    context: context,
  );

  @override
  Future<bool> login(String name, String password) {
    return _$loginAsyncAction.run(() => super.login(name, password));
  }

  late final _$registerAsyncAction = AsyncAction(
    '_AuthStoreBase.register',
    context: context,
  );

  @override
  Future<bool> register(String name, String password) {
    return _$registerAsyncAction.run(() => super.register(name, password));
  }

  late final _$logoutAsyncAction = AsyncAction(
    '_AuthStoreBase.logout',
    context: context,
  );

  @override
  Future<void> logout() {
    return _$logoutAsyncAction.run(() => super.logout());
  }

  @override
  String toString() {
    return '''
currentUser: ${currentUser},
isLoading: ${isLoading},
errorMessage: ${errorMessage},
isAuthenticated: ${isAuthenticated}
    ''';
  }
}
