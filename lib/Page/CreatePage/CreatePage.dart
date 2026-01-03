import 'package:app/Component/Create/CreateTask/CreateTaskAddDescriptionComponent.dart';
import 'package:app/Component/Create/CreateTask/CreateTaskAddHintHabitComponent.dart';
import 'package:app/Component/Create/CreateTask/CreateTaskAddHintTypeComponent.dart';
import 'package:app/Component/Create/CreateTask/CreateTaskAddTimeAssignComponent.dart';
import 'package:app/Component/Create/CreateTask/CreateTaskAddTimeRangeComponent.dart';
import 'package:app/Component/Create/CreateTask/CreateTaskAddTitleComponent.dart';
import 'package:app/pojos/componentPojos/timeSelect/PickerDataSpik.dart';
import 'package:flutter/material.dart';

class CreatePage extends StatefulWidget {
  
  CreatePage({Key? key}) : super(key: key);
  
  
  @override
  _CreatePageState createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  String _descriptionValue = '';
  String _hintTypeValue = 'at';
  @override
  Widget build(BuildContext context) {
    DateTime timeNow = DateTime.now();
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white), // 设置返回按钮颜色
        title: Text("创建提醒",style: TextStyle(color: Colors.white)),
        backgroundColor: Theme.of(context).brightness == Brightness.light 
      ? Colors.blue  // 暗色主题时用蓝色
        : null,   
      ),
      body: Container(
        constraints: BoxConstraints.expand(),
        child: Stack(
          children: [
            SingleChildScrollView(
              padding: EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CreateTaskAddTitleComponent(),
                  SizedBox(height: 10),
                  CreateTaskAddDescriptionComponent(onGetData: (value)=>{
                    _descriptionValue = value
                  }),
                  SizedBox(height: 10),
                  CreateTaskAddHintHabitComponent(), // 提醒习惯（设备提醒还是终端提醒）
                  SizedBox(height: 10),
                  CreateTaskAddHintTypeComponent(onGetData: (value){
                    setState(() {
                      _hintTypeValue = value;
                    });
                  },hintSelectValue: _hintTypeValue,), // 触发类型（感应触发还是直接触发？）
                  SizedBox(height: 10),
                  _hintTypeValue == 'at' ? CreateTaskAddTimeRangeComponent(
                    startPickerdataspik: Pickerdataspik(
                      yearMaxNumber: 2,
                      now: DateTime.now()
                    ),
                    endPickerdataspik: Pickerdataspik(
                      yearMaxNumber: 2,
                      now: DateTime.now()
                    )
                  ) : SizedBox(),
                  
                  _hintTypeValue == 'bt' ? CreateTaskAddTimeAssignComponent(pickerdataspik: Pickerdataspik(
                   yearMaxNumber: 2,
                  //  now: DateTime(2024, 5, 15, 14, 30, 45) // 测试用
                  now: DateTime.now()
                  ),onGetData: (arr){
                    print("arr: ${arr}");
                  },) : SizedBox(),
                  SizedBox(height: 100),
                ],
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 20.0,
              child: Center(
                child: ElevatedButton(
                  
                  onPressed: (){
                    print("创建事件点击了 value:${_descriptionValue}");
                    setState(() {
                      
                    });
                  }, 
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(210, 50),
                    foregroundColor: Colors.white, backgroundColor: Colors.blue,    // 文字颜色
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text("创建提醒")
                )
              ),
            )

          ],
        ),
      )
    );
  }
}