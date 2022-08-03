class DateUtils {

  static List<DateTime> getAllfridayDayFromYear() {
    final dateCurrent = DateTime.now();
    List<DateTime> dates = [];

    for(int month = dateCurrent.month; month <= 12; month ++) {
      final daysFromMonth = getDaysInMonth(dateCurrent.year, month);
        
      for(int i = 1; i <= daysFromMonth; i ++) {
        final date = DateTime(dateCurrent.year, month, i);
        if(date.weekday == DateTime.friday && date.isAfter(dateCurrent)) {
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

  static String? getMonth(DateTime date) {
    switch(date.month) {
      case 1:  return 'JANEIRO';
      case 2:  return 'FEVEREIRO';
      case 3:  return "MARÇO";
      case 4:  return "ABRIL";
      case 5:  return "MAIO";
      case 6:  return "JUNHO";
      case 7:  return "JULHO";
      case 8:  return "AGOSTO";
      case 9:  return "SETEMBRO";
      case 10: return "OUTUBRO";
      case 11: return "NOVEMBRO";
      case 12: return "DEZEMBRO";
    }

    return null;
  }
}