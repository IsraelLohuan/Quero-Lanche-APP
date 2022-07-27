abstract class Failure implements Exception {}

class FailureCache implements Failure {}

class FailureRequest implements Failure {}

class FailureUnexpected implements FailureRequest {}

class FailureEmailNotFound implements FailureRequest {}

class FailureInvalidCredentials implements FailureRequest {}

extension FailureExtension on Failure {
  String buildMessageError() {
    if(this is FailureRequest) return 'Falha na requisição';
    if(this is FailureUnexpected) return 'Erro inesperado';
    if(this is FailureEmailNotFound) return 'Email não encontrado';
    return 'Credenciais inválidas';
  }
}