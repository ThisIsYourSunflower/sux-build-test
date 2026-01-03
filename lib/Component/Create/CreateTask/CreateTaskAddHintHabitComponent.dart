import 'package:app/pojos/componentPojos/HintTypeMenuItemPojo.dart';
import 'package:flutter/material.dart';

class CreateTaskAddHintHabitComponent extends StatefulWidget {
  const CreateTaskAddHintHabitComponent({super.key});

  @override
  State<CreateTaskAddHintHabitComponent> createState() => _CreateTaskAddHintHabitComponentState();
}

class _CreateTaskAddHintHabitComponentState extends State<CreateTaskAddHintHabitComponent> {
  String? _hintSelectValue = 'dc';
  Map<String,HintTypeMenuItemPojo> hintTypeMenuItemPojoMap = {
    'dc':HintTypeMenuItemPojo(
      'dc',
      '终端设备提醒+当前移动设备提醒',
      "在提醒范围内并触发提醒条件后，终端设备会发出'滴滴'声进行提醒，当前的移动设备也会随之提醒"
    ),
    'sc':HintTypeMenuItemPojo(
      'sc',
      '终端设备播报+当前移动设备提醒',
      "在提醒范围内并触发提醒条件后，终端设备会根据<事件描述>文本内容进行语音播报，当前的移动设备也会随之提醒"
    ),
    'cc':HintTypeMenuItemPojo(
      'cc',
      '移动设备提醒',
      "在提醒范围内并触发提醒条件后，只有当前的移动设备会提醒，终端设备不参与"
    )
  };
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.zero,
      ),
      // elevation: 5,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16,vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("提醒习惯 *",style: TextStyle(
                color: Colors.blue,
                
              )
            ),
            SizedBox(height: 5),
            DropdownButton<String>(
              underline: Container(
                height: 1,
                color: const Color.fromARGB(255, 121, 116, 126), // 下划线颜色
              ),
              value: _hintSelectValue,
              
              isExpanded: true,
              items: hintTypeMenuItemPojoMap.values
              .map((pojo) => DropdownMenuItem(
                    value: pojo.id,
                    child: Text(pojo.text),
                  ))
              .toList(),

              onChanged: (value){
                setState(() {
                  _hintSelectValue = value;
                });
              }
            ),
            SizedBox(height: 5),
            Text(hintTypeMenuItemPojoMap[_hintSelectValue]!.hint,
              style: TextStyle(
                fontSize: 13,
                color: const Color.fromARGB(255, 88, 88, 88)

              )
            )
          ],
        )
      )
    );
  }
}