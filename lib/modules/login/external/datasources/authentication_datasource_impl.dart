import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gestao_escala/modules/login/infra/datasources/i_authentication_datasource.dart';
import 'package:gestao_escala/modules/shared/domain/entities/user_model.dart';
import '../../domain/errors/errors.dart';

class AuthenticationDataSourceImpl implements IAuthenticationDataSource {
  @override
  Future<UserModel> login(String email, String password) async {
    final UserModel? userModel = await _findAccountByEmail(email);

    if(userModel == null) {
      throw FailureEmailNotFound();
    } 

    if(userModel.password == password) {
      return userModel;
    }

    throw FailureInvalidCredentials(); 
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