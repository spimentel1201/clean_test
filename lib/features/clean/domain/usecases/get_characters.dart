import 'package:clean_architecture/core/error/failures.dart';
import 'package:clean_architecture/core/usecases/usecase.dart';
import 'package:clean_architecture/features/clean/domain/entities/character.dart';
import 'package:clean_architecture/features/clean/domain/repositories/character_repository.dart';
import 'package:dartz/dartz.dart';

/*class GetCharacters {
  final CharacterRepository repository;
  GetCharacters(this.repository);
}*/

class GetCharacters implements UseCase<Character, NoParams> {
  final CharacterRepository repository;

  GetCharacters(this.repository);

  @override
  Future<Either<Failures, Character>> call(NoParams params) async {
    return await repository.getCharacters();
  }
}
