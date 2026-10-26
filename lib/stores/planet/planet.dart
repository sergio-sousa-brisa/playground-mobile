import 'package:mobx/mobx.dart';
import 'package:playgroundmobile/models/planet.dart';
import 'package:playgroundmobile/repository/repository.dart';

part 'planet.g.dart';

class PlanetStore = _PlanetStore with _$PlanetStore;

abstract class _PlanetStore  with Store {
    final Repository _repository;
    _PlanetStore(this._repository);


  @observable
  bool isLoading = false;

  @observable
  ObservableList<Planet> planets = ObservableList<Planet>();

  @observable
  String? errorMessage;

  @action
  Future loadPlanets() async {
    isLoading = true;
    errorMessage = null;

    try {
      isLoading = true;
      final result = await _repository.getPlanets();
      planets.clear();
      planets.addAll(result);
    } catch (_) {
      errorMessage = 'Falha ao buscar';
    } finally {
      isLoading = false;
    }
  }

}