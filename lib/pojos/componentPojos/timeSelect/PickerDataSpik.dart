class Pickerdataspik {
  DateTime ?now;  // 目前的时间，如果对象不为null，那么自动开启不可选择旧时间模式，只能选择未来时间

  final String yearName; // 年的单位
  int yearMin;  // 从几几年开始？
  final int yearMaxNumber; // 从默认年开始到多少结束，如果写3，默认年为2025，那么最多就是2028

  final String monthName; // 月的单位

  final String dayName; // 日的单位

  final String hourName; // 时的单位

  final String minuteName; // 分的单位

  final int selectYear;
  final int selectMonth;
  final int selectDay;
  final int selectHour;
  final int selectMinute;

  // 是否使用now对象中的初始化值？
  final bool userDateNowDefulat;

  Pickerdataspik({
  this.yearName = '年',
  this.yearMin = 1977,
  this.yearMaxNumber = 10,

  this.monthName = '月',

  this.dayName = '日',

  this.hourName = '时',

  this.minuteName = '分',

  this.selectYear = 1977,
  this.selectMonth = 1,
  this.selectDay = 1,
  this.selectHour = 0,
  this.selectMinute = 0,

  this.now,
  this.userDateNowDefulat = true
  }){
    if(now != null){
      yearMin = now!.year;
    }
  }

}
