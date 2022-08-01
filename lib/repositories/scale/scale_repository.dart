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

    final CollectionReference accountRef = FirebaseFirestore.instance.collection(collection);
    final snapshots = await accountRef.get();

    for (var doc in snapshots.docs) {
      await doc.reference.delete();
    }
  }

  @override
  Future<List<DayModel>> fetchAllDays() async {
    final CollectionReference accountRef = FirebaseFirestore.instance.collection(collection);

    QuerySnapshot<Object?> snapshot = await accountRef.orderBy('day').get(); 

    if(snapshot.docs.isNotEmpty) {
      return snapshot.docs.map<DayModel>((json) {
        final jsonMap = json.data() as Map<String, dynamic>..putIfAbsent('id', () => json.id);
        return DayModel.fromJson(jsonMap);
      }).toList();
    } 

    return [];
  }
  
  @override
  Future<void> updateScale({required String id, required Map<String, Object> data}) async {
    final CollectionReference accountRef = FirebaseFirestore.instance.collection(collection);
    await accountRef.doc(id).update(data);
  }
}