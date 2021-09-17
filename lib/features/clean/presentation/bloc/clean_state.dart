part of 'clean_bloc.dart';

@immutable
abstract class CleanState extends Equatable {
  //CleanState([List props = const <dynamic>[]]) : super();
  List<Object> get props => [];
}

class Empty extends CleanState {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class Loading extends CleanState {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class Loaded extends CleanState {
  final Character character;
  Loaded({@required this.character});

  @override
  // TODO: implement props
  List<Object> get props => [character];
}

class Error extends CleanState {
  final String message;
  Error({@required this.message});

  @override
  // TODO: implement props
  List<Object> get props => [message];
}
//class CleanInitial extends CleanState {}
