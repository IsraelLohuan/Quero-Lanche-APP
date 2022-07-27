
import 'package:gestao_escala/modules/login/domain/repositories/i_authentication_repository.dart';
import 'package:gestao_escala/modules/login/infra/datasources/i_authentication_datasource.dart';
import 'package:gestao_escala/modules/shared/domain/entities/user_model.dart';

class AuthenticationRepositoryImpl extends IAuthenticationRepository {
  final IAuthenticationDataSource dataSource;

  AuthenticationRepositoryImpl(this.dataSource);

  @override
  Future<UserModel> login(String email, String password) async {
    return await dataSource.login(email, password);
  }
}