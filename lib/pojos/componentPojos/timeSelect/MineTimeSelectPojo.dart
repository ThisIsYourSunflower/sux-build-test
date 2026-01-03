class MineTimeSelectPojo {
  int year;

  int month;

  int day;

  int hour;

  int minute;

  MineTimeSelectPojo({this.year = 0,this.month = 0,this.day = 0,this.hour = 0,this.minute = 0});
  
   @override
  String toString() {
    return 'MineTimeSelectPojo{year: $year, month: $month, day: $day, hour: $hour, minute: $minute}';
  }
}
