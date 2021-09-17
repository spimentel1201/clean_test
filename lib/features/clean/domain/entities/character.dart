import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

class Character extends Equatable {
  final String name;
  final String species;
  final String gender;

  Character(
      {@required this.name, @required this.species, @required this.gender});

  @override
  List<Object> get props => [name, species, gender];
}
