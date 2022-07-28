import '../../../../../shared/domain/entities/day_model.dart';
import '../../../../../shared/domain/entities/user_model.dart';
import '../helpers/date_utils.dart';

class GenerateScale {
  
  List<DayModel> call(List<UserModel> usersSelected) {
    final fridays = DateUtils.getAllfridayDayFromYear();

    List<DayModel> daysModel = [];

    int index = 0;

    for(DateTime day in fridays) {
      daysModel.add(DayModel(day: day, userResponsible: usersSelected[index]));
      index = (index >= usersSelected.length - 1) ? 0 : index + 1;
    } 

    return daysModel;
  }
}

