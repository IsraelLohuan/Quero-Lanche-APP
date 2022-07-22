import 'package:gestao_escala/models/day_model.dart';

abstract class IScaleRepository {
  Future<List<DayModel>> fetchAllDays();
  Future<bool> createScale(List<DayModel> days);
  Future<void> deleteScale();
  Future<void> updateScale({
    required String id, 
    required Map<String, Object> data
  });
}