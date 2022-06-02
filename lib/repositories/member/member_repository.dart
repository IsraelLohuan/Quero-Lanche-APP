import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gestao_escala/modules/models/user_model.dart';
import 'package:gestao_escala/repositories/member/i_member_repository.dart';

class MemberRepository implements IMemberRepository {

  @override
  Future<List<UserModel>> fetchAllMembers() async {
    final CollectionReference accountRef = FirebaseFirestore.instance.collection('/user');

    QuerySnapshot<Object?> snapshot = await accountRef.get(); 

    if(snapshot.docs.isNotEmpty) {
      List<UserModel> data = snapshot.docs.map<UserModel>((json) => UserModel.fromJson(json.data() as Map<String, dynamic>)).toList();

      return data;
    }

    return [];
  }
}