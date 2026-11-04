import 'package:mobx/mobx.dart';
import 'package:playgroundmobile/models/character.dart';
import 'package:playgroundmobile/repository/repository.dart';

part 'character.g.dart';

class CharacterStore = _CharacterStore with _$CharacterStore;

abstract class _CharacterStore with Store{
  final Repository _repository;
  _CharacterStore(this._repository);

  @observable
  bool isLoading = false;

  @observable
  String? errorMessage;

  @observable
  ObservableList<Character> characters = ObservableList<Character>();

  @action
  Future loadCharacters() async{
    try {
      isLoading = true;
      final response = await _repository.getCharacters();
      characters.clear();
      characters.addAll(response);
    } catch (_){
      errorMessage = 'Falha ao buscar';
    } finally{
      isLoading = false;
    }
  }
}