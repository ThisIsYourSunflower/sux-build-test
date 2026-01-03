/**
 * 功能：时间选择器模块
 * 维护人：孙金洋
 * BUG：在选择上级日期时，与系统日期相同时切换日期会导致hour和minute结果有问题（好像是有差值）
 */


import 'package:app/pojos/componentPojos/timeSelect/MineTimeSelectPojo.dart';
import 'package:app/pojos/componentPojos/timeSelect/PickerDataSpik.dart';
import 'package:flutter/cupertino.dart';

class MineTimeSelect extends StatefulWidget {
  Pickerdataspik pickerdataspik;
  final ValueChanged<MineTimeSelectPojo>? onGetData;
  
  MineTimeSelect({super.key,required this.pickerdataspik,this.onGetData});

  @override
  State<MineTimeSelect> createState() => _MineTimeSelectState();
}

class _MineTimeSelectState extends State<MineTimeSelect> {

  final double _itemExtentValue = 50;
  MineTimeSelectPojo mineTimeSelectPojo = MineTimeSelectPojo();

  // 创建滚动控制器，设置初始位置为第10个选项（索引9）
  FixedExtentScrollController ?_pickerYearController;
  FixedExtentScrollController ?_pickerMonthController;
  FixedExtentScrollController ?_pickerDayController;
  FixedExtentScrollController ?_pickerHourController;
  FixedExtentScrollController ?_pickerMinuteController;
  @override
  void dispose() {
    super.dispose();
    // 释放控制器资源
    _pickerYearController?.dispose();
    _pickerMonthController?.dispose();
    _pickerDayController?.dispose();
    _pickerHourController?.dispose();
    _pickerMinuteController?.dispose();
    // super.dispose();
  }

  // int _yearMinValue = 0;
  int _monthMinValue = 1;
  int _dayMinValue = 1;
  int _hourMinValue = 0;
  int _minuteMinValue = 0;

  int nowSelectYear = 0;
  int nowSelectMonth = 1;
  int nowSelectDay = 1;
  int nowSelectHour = 0;
  int nowSelectMinute = 0;

  bool yearAlter = true;
  bool monthAlter = true;
  bool dayAlter = true;
  bool hourAlter = true;

  @override
  void initState() {
    super.initState();
    // super.initState();
    _pickerYearController = FixedExtentScrollController(initialItem: widget.pickerdataspik.selectYear);
    _pickerMonthController = FixedExtentScrollController(initialItem: widget.pickerdataspik.selectMonth);
    _pickerDayController = FixedExtentScrollController(initialItem: widget.pickerdataspik.selectDay);
    _pickerHourController = FixedExtentScrollController(initialItem: widget.pickerdataspik.selectHour);
    _pickerMinuteController = FixedExtentScrollController(initialItem: widget.pickerdataspik.selectMinute);
    // _yearMinValue = widget.pickerdataspik.yearMin;

    updateData();
  }

  void updateData(){
    nowSelectYear = (_pickerYearController!.hasClients ? _pickerYearController!.selectedItem + widget.pickerdataspik.yearMin : widget.pickerdataspik.yearMin);

    // 如果有当前时间，那么就限制，只能访问未来时间
    if(widget.pickerdataspik.now != null){
      // 如果当前选择的年和当前时间的年一样，那么月无法访问过去
      if(nowSelectYear == widget.pickerdataspik.now!.year){
        
        if(!yearAlter){
          int nowDiffer = nowSelectMonth - widget.pickerdataspik.now!.month;
          _pickerMonthController!.jumpToItem(nowDiffer >= 0 ? nowDiffer : 0);
        }

        yearAlter = true;
        _monthMinValue = widget.pickerdataspik.now!.month;
        nowSelectMonth = (_pickerMonthController!.hasClients ? (_pickerMonthController!.selectedItem + _monthMinValue) : _monthMinValue);
      
      }else if(yearAlter){
        yearAlter = false;
        _monthMinValue = 1;
        _dayMinValue = 1;
        _hourMinValue = 0;
        _minuteMinValue = 0;
        _pickerMonthController!.jumpToItem(nowSelectMonth - 1);
      }else{
        nowSelectMonth = (_pickerMonthController!.hasClients ? (_pickerMonthController!.selectedItem + _monthMinValue) : _monthMinValue);
      
      }
      
      // 判断月是否跳级
      if(yearAlter && nowSelectMonth == widget.pickerdataspik.now!.month){
        
        if(!monthAlter) {
          int nowDiffer = nowSelectDay - widget.pickerdataspik.now!.day;
          _pickerDayController!.jumpToItem(nowDiffer >= 0 ? nowDiffer : 0);
        }

        monthAlter = true;
        _dayMinValue = widget.pickerdataspik.now!.day;
        nowSelectDay = (_pickerDayController!.hasClients ? (_pickerDayController!.selectedItem + _dayMinValue) : _dayMinValue);
      }else if(monthAlter){
        monthAlter = false;
        _dayMinValue = 1;
        _hourMinValue = 0;
        _minuteMinValue = 0;
        _pickerDayController!.jumpToItem(nowSelectDay - 1);
      }else{
        nowSelectDay = (_pickerDayController!.hasClients ? (_pickerDayController!.selectedItem + _dayMinValue) : _dayMinValue);
      }
      
      

      // 判断日是否跳级
      if(monthAlter && nowSelectDay == widget.pickerdataspik.now!.day){
        
        if(!dayAlter){
          int nowDiffer = nowSelectHour - widget.pickerdataspik.now!.hour;
          _pickerHourController!.jumpToItem(nowDiffer >= 0 ? nowDiffer : 0);
        }

        dayAlter = true;
        _hourMinValue = widget.pickerdataspik.now!.hour;
        nowSelectHour = (_pickerHourController!.hasClients ? (_pickerHourController!.selectedItem + _hourMinValue) : _hourMinValue);
      }else if(dayAlter){
        dayAlter = false;
        _hourMinValue = 0;
        _minuteMinValue = 0;
        _pickerHourController!.jumpToItem(nowSelectHour);
      }else{
        nowSelectHour = (_pickerHourController!.hasClients ? (_pickerHourController!.selectedItem + _hourMinValue) : _hourMinValue);
      }

      

      // 判断时是否跳级
      if(dayAlter && nowSelectHour == widget.pickerdataspik.now!.hour){
        
        if(!hourAlter) {
          int nowDiffer = nowSelectMinute - widget.pickerdataspik.now!.minute;
          _pickerMinuteController!.jumpToItem(nowDiffer >= 0 ? nowDiffer : 0);
        }

        hourAlter = true;
        _minuteMinValue = widget.pickerdataspik.now!.minute;
        nowSelectMinute = (_pickerMinuteController!.hasClients ? (_pickerMinuteController!.selectedItem + _minuteMinValue) : _minuteMinValue);
      }else if(hourAlter){
        hourAlter = false;
        _minuteMinValue = 0;
        _pickerMinuteController!.jumpToItem(nowSelectMinute);
      }else{
        nowSelectMinute = (_pickerMinuteController!.hasClients ? (_pickerMinuteController!.selectedItem + _minuteMinValue) : _minuteMinValue);
      }
      
      

    }else{
      nowSelectMonth = (_pickerMonthController!.hasClients ? _pickerMonthController!.selectedItem + _monthMinValue : _monthMinValue);
    
      nowSelectDay = (_pickerDayController!.hasClients ? _pickerDayController!.selectedItem + _dayMinValue : _dayMinValue);
      
      nowSelectHour = (_pickerHourController!.hasClients ? _pickerHourController!.selectedItem + _hourMinValue : _hourMinValue);
      
      nowSelectMinute = (_pickerMinuteController!.hasClients ? _pickerMinuteController!.selectedItem + _minuteMinValue : _minuteMinValue);
      
    }

    mineTimeSelectPojo.year = nowSelectYear;
    mineTimeSelectPojo.month = nowSelectMonth;
    mineTimeSelectPojo.day = nowSelectDay;
    mineTimeSelectPojo.hour = nowSelectHour;
    mineTimeSelectPojo.minute = nowSelectMinute;
  }

  @override
  Widget build(BuildContext context) {
    updateData();
    widget.onGetData?.call(mineTimeSelectPojo);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded( // 年
              child: CupertinoPicker(
                itemExtent: _itemExtentValue,
                scrollController: _pickerYearController, // 使用控制器设置初始位置
                onSelectedItemChanged: (index) {
                  // updateData();
                  setState(() {
                    
                  });
                },
                children: List<Widget>.generate(widget.pickerdataspik.yearMaxNumber, (index) {
                  return Center(
                    child: Text(
                      '${index + widget.pickerdataspik.yearMin}${widget.pickerdataspik.yearName}',
                      style: TextStyle(fontSize: 16.0),
                    ),
                  );
                }),
              )
            ),
            Expanded( // 月
              child: CupertinoPicker(
                itemExtent: _itemExtentValue,
                scrollController: _pickerMonthController, // 使用控制器设置初始位置
                onSelectedItemChanged: (index) {
                  // updateData();
                  widget.onGetData?.call(mineTimeSelectPojo);
                },
                children: List<Widget>.generate(12 - (_monthMinValue - 1), (index) {
                  return Center(
                    child: Text(
                      '${index + _monthMinValue}${widget.pickerdataspik.monthName}',
                      style: TextStyle(fontSize: 16.0),
                    ),
                  );
                }),
              )
            ),
            Expanded( // 日
              child: CupertinoPicker(
                itemExtent: _itemExtentValue,
                scrollController: _pickerDayController, // 使用控制器设置初始位置
                onSelectedItemChanged: (index) {
                  // updateData();
                  widget.onGetData?.call(mineTimeSelectPojo);
                },
                children: List<Widget>.generate(31 - (_dayMinValue - 1), (index) {
                  return Center(
                    child: Text(
                      '${index + _dayMinValue}${widget.pickerdataspik.dayName}',
                      style: TextStyle(fontSize: 16.0),
                    ),
                  );
                }),
              )
            )
          ],
        ),
        SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: CupertinoPicker(
                itemExtent: _itemExtentValue,
                scrollController: _pickerHourController, // 使用控制器设置初始位置
                onSelectedItemChanged: (index) {
                  // updateData();
                  widget.onGetData?.call(mineTimeSelectPojo);
                },
                children: List<Widget>.generate(24 - (_hourMinValue - 1), (index) {
                  return Center(
                    child: Text(
                      '${index + _hourMinValue}${widget.pickerdataspik.hourName}',
                      style: TextStyle(fontSize: 16.0),
                    ),
                  );
                }),
              )
            ),
            Expanded(
              child: CupertinoPicker(
                itemExtent: _itemExtentValue,
                scrollController: _pickerMinuteController, // 使用控制器设置初始位置
                onSelectedItemChanged: (index) {
                  // updateData();
                  widget.onGetData?.call(mineTimeSelectPojo);
                },
                children: List<Widget>.generate(60 - (_minuteMinValue - 1), (index) {
                  return Center(
                    child: Text(
                      '${index + _minuteMinValue}${widget.pickerdataspik.minuteName}',
                      style: TextStyle(fontSize: 16.0),
                    ),
                  );
                }),
              )
            )
          ],
        )
      ],
    );
  }
}