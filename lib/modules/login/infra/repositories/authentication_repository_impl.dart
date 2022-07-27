import 'package:dartz/dartz.dart';
import 'package:gestao_escala/modules/login/domain/errors/errors.dart';
import 'package:gestao_escala/modules/login/domain/repositories/i_authentication_repository.dart';
import 'package:gestao_escala/modules/login/infra/datasources/i_authentication_datasource.dart';
import 'package:gestao_escala/modules/shared/domain/entities/user_model.dart';

class AuthenticationRepositoryImpl extends IAuthenticationRepository {
  final IAuthenticationDataSource dataSource;

  AuthenticationRepositoryImpl(this.dataSource);

  @override
  Future<Either<FailureRequest, UserModel>> login(String email, String password) async {
    try {
      final result = await dataSource.login(email, password);
      return Right(result);
    } on FailureEmailNotFound {
      return Left(FailureEmailNotFound());
    } on FailureInvalidCredentials {
      return Left(FailureInvalidCredentials());
    } catch(_) {
      return Left(FailureUnexpected());
    }
  }
}