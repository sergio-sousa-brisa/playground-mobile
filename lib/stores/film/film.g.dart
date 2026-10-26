// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'film.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$FilmStore on _FilmStore, Store {
  late final _$isLoadingAtom = Atom(
    name: '_FilmStore.isLoading',
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

  late final _$filmsAtom = Atom(name: '_FilmStore.films', context: context);

  @override
  ObservableList<Film> get films {
    _$filmsAtom.reportRead();
    return super.films;
  }

  @override
  set films(ObservableList<Film> value) {
    _$filmsAtom.reportWrite(value, super.films, () {
      super.films = value;
    });
  }

  late final _$errorMessageAtom = Atom(
    name: '_FilmStore.errorMessage',
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

  late final _$loadFilmsAsyncAction = AsyncAction(
    '_FilmStore.loadFilms',
    context: context,
  );

  @override
  Future<dynamic> loadFilms() {
    return _$loadFilmsAsyncAction.run(() => super.loadFilms());
  }

  @override
  String toString() {
    return '''
isLoading: ${isLoading},
films: ${films},
errorMessage: ${errorMessage}
    ''';
  }
}
