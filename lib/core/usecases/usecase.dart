import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../error/failures.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>?> call(Params params);
}


class Params extends Equatable {
  final dynamic data;

  const Params({required this.data});

  @override
  List<Object?> get props => [data];
}

class NoParams extends Equatable {
  @override
  List<Object?> get props => [];
}