import 'package:clean_architecture/features/clean/domain/entities/character.dart';
import 'package:flutter/cupertino.dart';

class CharacterModel extends Character {
  CharacterModel(
      {@required String name,
      @required String species,
      @required String gender})
      : super(
          name: name,
          species: species,
          gender: gender,
        );
  factory CharacterModel.fromJson(Map<String, dynamic> json) {
    return CharacterModel(
      name: json['text'],
      species: json['text'],
      gender: json['text'],
    );
  }
}
