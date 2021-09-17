import 'package:clean_architecture/core/error/failures.dart';
import 'package:dartz/dartz.dart';


class InputConverter {
  Either<Failures, int> stringToUnsignedInteger(String str) {
    try {
      final integer = int.parse(str);
      if (integer < 0) throw FormatException();
      return Right(integer);
    } on FormatException {
      return Left(InvalidInputFailure());
    }
  }
}

class InvalidInputFailure extends Failures {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}