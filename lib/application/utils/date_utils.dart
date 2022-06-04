class DateUtils {

  static List<DateTime> getAllfridayDayFromYear() {

    final yearCurrent = DateTime.now();
    List<DateTime> dates = [];

    for(int month = 1; month <= 12; month ++) {
      final daysFromMonth = getDaysInMonth(yearCurrent.year, month);
        
      for(int i = 1; i <= daysFromMonth; i ++) {
        final date = DateTime(yearCurrent.year, month, i);
        if(date.weekday == DateTime.friday) {
          dates.add(date);  
        }
      }
    }

    return dates;
  }
  
  static int getDaysInMonth(int year, int monthNum) {
    assert(monthNum > 0);
    assert(monthNum <= 12);
    return DateTime(year, monthNum + 1, 0).day;
  }
}