import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gestao_escala/modules/models/user_model.dart';
import 'package:gestao_escala/repositories/login/i_login_repository.dart';

class LoginRepository implements ILoginRepository {
  
  @override
  Future<UserModel?> findAccountByEmail(String email) async {
    final CollectionReference accountRef = FirebaseFirestore.instance.collection('/user');

    QuerySnapshot<Object?> snapshot = await accountRef.where('email', isEqualTo: email).get(); 

    if(snapshot.docs.isNotEmpty) {
      final json = snapshot.docs.first.data() as Map<String, dynamic>;
      return UserModel.fromJson(json);
    }

    return null;
  }

  @override
  Future<UserModel> login(String email, String password) async {
    final UserModel? userModel = await findAccountByEmail(email);

    if(userModel == null) {
      throw Exception('E-mail informado não encontrado :(');
    } 

    if(userModel.password == password) {
      return userModel;
    }

    throw Exception('Credenciais inválidas :(');
  }

  @override
  Future<UserModel> register(UserModel userModel) async {
    if(await findAccountByEmail(userModel.email) != null) {
      throw Exception('O E-mail informado já está registrado!');
    }

    final CollectionReference accountRef = FirebaseFirestore.instance.collection('/user');

    accountRef.doc().set(userModel.toJson());

    return userModel;
  }
}