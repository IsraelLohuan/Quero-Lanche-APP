import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gestao_escala/models/day_model.dart';
import 'package:gestao_escala/repositories/scale/i_scale_repository.dart';

class ScaleRepository implements IScaleRepository {

  String get collection => 'scale-${DateTime.now().year}';

  @override
  Future<bool> createScale(List<DayModel> days) async {
    final CollectionReference accountRef = FirebaseFirestore.instance.collection(collection);

    days.forEach((element) => accountRef.doc().set(element.toJson()));
    
    return true;
  }

  @override
  Future<void> deleteScale() async {
    
  }

  @override
  Future<List<DayModel>> fetchAllDays() async {
    final CollectionReference accountRef = FirebaseFirestore.instance.collection(collection);

    QuerySnapshot<Object?> snapshot = await accountRef.orderBy('day').get(); 

    if(snapshot.docs.isNotEmpty) {
      List<DayModel> data = snapshot.docs.map<DayModel>((json) => DayModel.fromJson(json.data() as Map<String, dynamic>)).toList();

      return data;
    } 

    throw Exception('Não há Escala Criada para este Ano!');
  }
}