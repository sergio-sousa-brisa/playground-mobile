import 'package:mobx/mobx.dart';
import 'package:playgroundmobile/models/film.dart';
import 'package:playgroundmobile/repository/repository.dart';

part 'film.g.dart';

class FilmStore = _FilmStore with _$FilmStore;

abstract class _FilmStore with Store{
  final Repository _repository;

  _FilmStore(this._repository);

  @observable
  bool isLoading = false;

  @observable
  ObservableList<Film> films = ObservableList<Film>();

  @observable
  String? errorMessage;

  @action
  Future loadFilms() async {
    isLoading = true;
    errorMessage = null;

    try {
      final result = await _repository.getFilms();
      films.clear();
      films.addAll(result);
    } catch (_) {
      errorMessage = 'Falha ao buscar';
    } finally {
      isLoading = false;
    }
  }
}