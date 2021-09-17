import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:clean_architecture/core/error/failures.dart';
import 'package:clean_architecture/core/usecases/usecase.dart';
import 'package:clean_architecture/core/util/input_converter.dart';
import 'package:clean_architecture/features/clean/domain/entities/character.dart';
import 'package:clean_architecture/features/clean/domain/usecases/get_character.dart';
import 'package:clean_architecture/features/clean/domain/usecases/get_characters.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'clean_event.dart';
part 'clean_state.dart';

const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String INVALID_INPUT_FAILURE_MESSAGE =
    'Invalid Input - The number must be a positive integer or zero.';

class CleanBloc extends Bloc<CleanEvent, CleanState> {
  final GetCharacter getCharacter;
  final GetCharacters getCharacters;
  final InputConverter inputConverter;

  CleanBloc({
    //this.getCharacter,
    //this.getCharacters,
    @required GetCharacter character,
    @required GetCharacters characters,
    @required this.inputConverter,
  })  : assert(character != null),
        assert(characters != null),
        assert(inputConverter != null),
        getCharacter = character,
        getCharacters = characters;

  @override
  CleanState get initialState => Empty();

  @override
  Stream<CleanState> mapEventToState(
    CleanEvent event,
  ) async* {
    if (event is GetCharacterForId) {
      final inputEither =
          inputConverter.stringToUnsignedInteger(event.characterId);

      yield* inputEither.fold(
        (failure) async* {
          yield Error(message: INVALID_INPUT_FAILURE_MESSAGE);
        },
        (integer) async* {
          yield Loading();
          final failureOrCharacter =
              await getCharacter(Params(number: integer));
          yield* _eitherLoadedOrErrorState(failureOrCharacter);
        },
      );
    } else if (event is GetCharacterForId) {
      yield Loading();
      final failureOrCharacter = await getCharacters(NoParams());
      yield* _eitherLoadedOrErrorState(failureOrCharacter);
    }
  }

  Stream<CleanState> _eitherLoadedOrErrorState(
    Either<Failures, Character> failureOrCharacter,
  ) async* {
    yield failureOrCharacter.fold(
      (failure) => Error(message: _mapFailureToMessage(failure)),
      (character) => Loaded(character: character),
    );
  }

  String _mapFailureToMessage(Failures failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      default:
        return 'Unexpected error';
    }
  }
}
