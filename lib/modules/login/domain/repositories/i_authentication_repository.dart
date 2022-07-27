
import 'package:dartz/dartz.dart';
import 'package:gestao_escala/modules/login/domain/errors/errors.dart';
import 'package:gestao_escala/modules/shared/domain/entities/user_model.dart';

abstract class IAuthenticationRepository {
  Future<Either<FailureRequest, UserModel>> login(String email, String password);
}