abstract class Failure implements Exception {
  String get messageError;
}

class FailureRequest implements Failure {
  @override
  String get messageError => 'Algo inesperado ocorreu ao realizar requisição :|';
}

class FailureUnexpected implements FailureRequest {
  @override
  String get messageError => 'Algo de inesperado ocorreu ao realizar requisição :|';
}

class FailureEmailNotFound implements FailureRequest {
  @override
  String get messageError => 'Ops! Email não encontrado';
}

class FailureInvalidCredentials implements FailureRequest {
  @override
  String get messageError => 'Usuário ou senha inválidos!';
}
