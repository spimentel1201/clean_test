import 'package:clean_architecture/core/error/failures.dart';
import 'package:clean_architecture/core/usecases/usecase.dart';
import 'package:clean_architecture/features/clean/domain/entities/character.dart';
import 'package:clean_architecture/features/clean/domain/repositories/character_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

/*class GetCharacter {
  final CharacterRepository repository;
  GetCharacter(this.repository);
}*/
class GetCharacter implements UseCase<Character, Params> {
  final CharacterRepository repository;

  GetCharacter(this.repository);

  @override
  Future<Either<Failures, Character>> call(Params params) async {
    return await repository.getCharacter(params.number);
  }
}

class Params extends Equatable {
  final int number;

  Params({@required this.number});

  @override
  List<Object> get props => [number];
}
