import 'package:clean_architecture/core/error/exception.dart';
import 'package:clean_architecture/core/platform/network.dart';
import 'package:clean_architecture/features/clean/data/datasources/character_data_source.dart';
import 'package:clean_architecture/features/clean/domain/entities/character.dart';
import 'package:clean_architecture/core/error/failures.dart';
import 'package:clean_architecture/features/clean/domain/repositories/character_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';

class CharacterRepositoryImpl implements CharacterRepository {
  final CharacterDataSource characterDataSource;
  final Network networkInfo;

  CharacterRepositoryImpl({
    @required this.characterDataSource,
    @required this.networkInfo,
  });
  @override
  Future<Either<Failures, Character>> getCharacter(int id) async {
    networkInfo.isConnected;
    try {
      final response = await characterDataSource.getCharacter(id);
      return Right(response);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failures, Character>> getCharacters() async {
    networkInfo.isConnected;
    try {
      final responses = await characterDataSource.getCharacters();
      return Right(responses);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
