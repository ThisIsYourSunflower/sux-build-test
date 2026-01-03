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
  final int _monthMinValue = 1;
  final int _dayMinValue = 1;
  final int _hourMinValue = 0;
  final int _minuteMinValue = 0;

  // 滚动是否被束缚，如果为true,那么就不能翻动DateNow之前的日期
  bool _yearAction = false;
  bool _monthAction = false;
  bool _dayAction = false;
  bool _hourAction = false;


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
    _selectDefault();
  }

  void _actionBuilder(int flag,int index){
    DateTime ?nowTime = widget.pickerdataspik.now;
    if(nowTime != null){
      // 如果是年
      if(flag == 0){
        mineTimeSelectPojo.year = index + widget.pickerdataspik.yearMin;
        if(mineTimeSelectPojo.year == nowTime.year){
          _yearAction = true;
          // 判断月、日、时
          if((_pickerMonthController!.selectedItem + _monthMinValue) <= nowTime.month){
            _monthAction = true;
            Future.delayed(Duration.zero, () {
              _pickerMonthController?.jumpToItem(nowTime.month - 1);
            });
            // 判断日
            if((_pickerDayController!.selectedItem + _dayMinValue) <= nowTime.day){
              _dayAction = true;
              Future.delayed(Duration.zero, () {
                _pickerDayController?.jumpToItem(nowTime.day - 1);
              });
              // 判断时
              if((_pickerHourController!.selectedItem + _hourMinValue) <= nowTime.hour){
                _hourAction = true;
                Future.delayed(Duration.zero, () {
                  _pickerHourController?.jumpToItem(nowTime.hour);
                });
                // 判断分
                if((_pickerMinuteController!.selectedItem + _minuteMinValue) <= nowTime.minute){
                  Future.delayed(Duration.zero, () {
                    _pickerMinuteController?.jumpToItem(nowTime.minute);
                  });
                }
              }
            }
          }
        }else{
          _yearAction = false;
          _monthAction = false;
          _dayAction = false;
          _hourAction = false;
        }
      }else if(flag == 1){  // 如果是月
        // 判断月、日、时
        if(_yearAction && (_pickerMonthController!.selectedItem + _monthMinValue) <= nowTime.month){
          _monthAction = true;
          Future.delayed(Duration.zero, () {
            _pickerMonthController?.jumpToItem(nowTime.month - 1);
          });
          // 判断日
          if((_pickerDayController!.selectedItem + _dayMinValue) <= nowTime.day){
            _dayAction = true;
            Future.delayed(Duration.zero, () {
              _pickerDayController?.jumpToItem(nowTime.day - 1);
            });
            // 判断时
            if((_pickerHourController!.selectedItem + _hourMinValue) <= nowTime.hour){
              _hourAction = true;
              Future.delayed(Duration.zero, () {
                _pickerHourController?.jumpToItem(nowTime.hour);
              });
              // 判断分
              if((_pickerMinuteController!.selectedItem + _minuteMinValue) <= nowTime.minute){
                Future.delayed(Duration.zero, () {
                  _pickerMinuteController?.jumpToItem(nowTime.minute);
                });
              }
            }
          }
        }else{
          _monthAction = false;
          _dayAction = false;
          _hourAction = false;
        }
      }else if(flag == 2){  // 如果是日
        // 判断日
        if(_monthAction && ((_pickerDayController!.selectedItem + _dayMinValue) <= nowTime.day)){
          _dayAction = true;
          Future.delayed(Duration.zero, () {
            _pickerDayController?.jumpToItem(nowTime.day - 1);
          });
          // 判断时
          if((_pickerHourController!.selectedItem + _hourMinValue) <= nowTime.hour){
            _hourAction = true;
            Future.delayed(Duration.zero, () {
              _pickerHourController?.jumpToItem(nowTime.hour);
            });
            // 判断分
            if((_pickerMinuteController!.selectedItem + _minuteMinValue) <= nowTime.minute){
              Future.delayed(Duration.zero, () {
                _pickerMinuteController?.jumpToItem(nowTime.minute);
              });
            }
          }
        }else{
          _dayAction = false;
          _hourAction = false;
        }
      }else if(flag == 3){  // 如果是时
        // 判断时
        if(_dayAction && ((_pickerHourController!.selectedItem + _hourMinValue) <= nowTime.hour)){
          _hourAction = true;
          Future.delayed(Duration.zero, () {
            _pickerHourController?.jumpToItem(nowTime.hour);
          });
          // 判断分
          if((_pickerMinuteController!.selectedItem + _minuteMinValue) <= nowTime.minute){
            Future.delayed(Duration.zero, () {
              _pickerMinuteController?.jumpToItem(nowTime.minute);
            });
          }
        }else{
          _hourAction = false;
        }
      }else if(flag == 4){  // 如果是分
        // 判断分
        if(_hourAction && ((_pickerMinuteController!.selectedItem + _minuteMinValue) <= nowTime.minute)){
          Future.delayed(Duration.zero, () {
            _pickerMinuteController?.jumpToItem(nowTime.minute);
          });
        }
      }
    }
    
    // 更新视图数据，年、月、日、时、分
    mineTimeSelectPojo.year = _pickerYearController!.selectedItem + widget.pickerdataspik.yearMin;
    mineTimeSelectPojo.month = _pickerMonthController!.selectedItem + 1;
    mineTimeSelectPojo.day = _pickerDayController!.selectedItem + 1;
    mineTimeSelectPojo.hour = _pickerHourController!.selectedItem;
    mineTimeSelectPojo.minute = _pickerMinuteController!.selectedItem;
  }

  void _selectDefault(){
    int indexYare = 0;
    int indexMonth = 0;
    int indexDay = 0;
    int indexHour = 0;
    int indexMinute = 0;
    if(widget.pickerdataspik.now != null && widget.pickerdataspik.userDateNowDefulat){
      DateTime now =  widget.pickerdataspik.now!;
      mineTimeSelectPojo.year = now.year;
      mineTimeSelectPojo.month = now.month;
      mineTimeSelectPojo.day = now.day;
      mineTimeSelectPojo.hour = now.hour;
      mineTimeSelectPojo.minute = now.minute;

      indexYare = now.year - widget.pickerdataspik.yearMin;
      indexMonth = now.month - 1;
      indexDay = now.day - 1;
      indexHour = now.hour;
      indexMinute = now.minute;
    }else{
      indexYare = widget.pickerdataspik.selectYear;
      indexMonth = widget.pickerdataspik.selectMonth;
      indexDay = widget.pickerdataspik.selectDay;
      indexHour = widget.pickerdataspik.selectHour;
      indexMinute = widget.pickerdataspik.selectMinute;
    }

    Future.delayed(Duration.zero, () {
      _pickerYearController?.jumpToItem(indexYare);
      _pickerMonthController?.jumpToItem(indexMonth);
      _pickerDayController?.jumpToItem(indexDay);
      _pickerHourController?.jumpToItem(indexHour);
      _pickerMinuteController?.jumpToItem(indexMinute);
    });
  }

  @override
  Widget build(BuildContext context) {
    
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
                  _actionBuilder(0,index);
                  
                  widget.onGetData?.call(mineTimeSelectPojo);
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
                  _actionBuilder(1,index);
                  widget.onGetData?.call(mineTimeSelectPojo);
                },
                children: List<Widget>.generate(12, (index) {
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
                  _actionBuilder(2,index);
                  widget.onGetData?.call(mineTimeSelectPojo);
                },
                children: List<Widget>.generate(31, (index) {
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
                  _actionBuilder(3,index);
                  widget.onGetData?.call(mineTimeSelectPojo);
                },
                children: List<Widget>.generate(24, (index) {
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
                  _actionBuilder(4,index);
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