import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gestao_escala/modules/login/domain/errors/errors.dart';
import 'package:gestao_escala/modules/login/infra/datasources/i_authentication_datasource.dart';
import 'package:gestao_escala/modules/shared/domain/entities/user_model.dart';

class AuthenticationDataSourceImpl implements IAuthenticationDataSource {

  @override
  Future<UserModel> login(String email, String password) async {
    final user = await _findAccountByEmail(email);

    if(user == null) {
      throw FailureEmailNotFound();
    } 

    if(user.password == password) {
      return user;
    }

    throw FailureInvalidCredentials(); 
  }

  @override
  Future<UserModel> register(UserModel userModel) async {
    if(await _findAccountByEmail(userModel.email) != null) {
      throw FailureUsedEmail();
    }

    final CollectionReference accountRef = FirebaseFirestore.instance.collection('/user');

    accountRef.doc().set(userModel.toJson());

    return userModel;
  }

  Future<UserModel?> _findAccountByEmail(String email) async {
    final CollectionReference accountRef = FirebaseFirestore.instance.collection('/user');
    QuerySnapshot<Object?> snapshot = await accountRef.where('email', isEqualTo: email).get(); 

    if(snapshot.docs.isNotEmpty) {
      final json = snapshot.docs.first.data() as Map<String, dynamic>;
      return UserModel.fromJson(json);
    }

    return null;
  }
}