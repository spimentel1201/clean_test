import 'package:dartz/dartz.dart';
import 'package:clean_architecture/core/error/failures.dart';
import 'package:clean_architecture/features/clean/domain/entities/character.dart';

abstract class CharacterRepository {
  Future<Either<Failures, Character>> getCharacter(int id);
  Future<Either<Failures, Character>> getCharacters();
}
