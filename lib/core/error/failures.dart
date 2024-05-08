import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  @override
  List<Object?> get props => [];

  const Failure([List properties = const <dynamic>[]]);
}

class ServerFailure extends Failure {

  const ServerFailure();
}

class NotFoundFailure extends Failure {

  const NotFoundFailure();
}

class DuplicateEntryFailure extends Failure {

  const DuplicateEntryFailure();
}

class ValidationFailure extends Failure {
  final String message;

  const ValidationFailure(this.message);
}