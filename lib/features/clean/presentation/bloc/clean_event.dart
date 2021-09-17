part of 'clean_bloc.dart';

@immutable
abstract class CleanEvent extends Equatable {
  CleanEvent([List props = const <dynamic>[]]) : super();
}

class GetCharacterForId extends CleanEvent {
  final String characterId;
  GetCharacterForId(this.characterId) : super([characterId]);

  @override
  // TODO: implement props
  List<Object> get props => [characterId];
}

class GetCharactersNoId extends CleanEvent {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}
