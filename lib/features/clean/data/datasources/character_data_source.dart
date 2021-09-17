import 'dart:convert';

// ignore: unused_import
import 'package:clean_architecture/core/error/exception.dart';
import 'package:clean_architecture/features/clean/data/models/character_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

abstract class CharacterDataSource {
  Future<CharacterModel> getCharacter(int id);
  Future<CharacterModel> getCharacters();
}

class CharacterDataSourceImpl implements CharacterDataSource {
  final http.Client client;
  CharacterDataSourceImpl({@required this.client});

  @override
  // ignore: missing_return
  Future<CharacterModel> getCharacter(int id) {
    _getCharacterFromUrl('https://rickandmortyapi.com/api/character/$id');
  }

  @override
  // ignore: missing_return
  Future<CharacterModel> getCharacters() {
    _getCharacterFromUrl('https://rickandmortyapi.com/api/character/');
  }

  Future<CharacterModel> _getCharacterFromUrl(String url) async {
    final response =
        await client.get(url, headers: {'content-type': 'application/json'});
    print(response);

    if (response.statusCode == 200) {
      return CharacterModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }
}
