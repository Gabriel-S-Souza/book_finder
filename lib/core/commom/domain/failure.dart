class Failure implements Exception {
  final String message;

  Failure(this.message);

  @override
  String toString() => 'Failure: $message';
}

class ServerFailure extends Failure {
  ServerFailure([String message = 'Erro na comunicação com o servidor']) : super(message);
}

class OfflineFailure extends Failure {
  OfflineFailure([String message = 'Verifique sua conexão com a internet']) : super(message);
}

class NotFoundFailure extends Failure {
  NotFoundFailure([String message = 'Ops, algo deu errado']) : super(message);
}
