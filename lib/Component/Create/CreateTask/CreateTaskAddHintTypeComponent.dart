import 'package:app/pojos/componentPojos/HintTypeMenuItemPojo.dart';
import 'package:flutter/material.dart';

class CreateTaskAddHintTypeComponent extends StatefulWidget {

  String hintSelectValue;

  final ValueChanged<String>? onGetData;

  CreateTaskAddHintTypeComponent({super.key,this.onGetData, required this.hintSelectValue});

  @override
  State<CreateTaskAddHintTypeComponent> createState() => _CreateTaskAddHintTypeComponentState();
}

class _CreateTaskAddHintTypeComponentState extends State<CreateTaskAddHintTypeComponent> {
  final String nHintString = "提醒期间按下复位按键后强制退出提醒，如果没有按下复位按键则会以3秒间隔进行一次提醒，直到第三次提醒周期完毕后提示结束";
  
  Map<String, HintTypeMenuItemPojo> get hintTypeMenuItemPojoMap => {
    'at':HintTypeMenuItemPojo(
      'at',
      '感应提醒',
      "需选择提醒日期范围，$nHintString"
    ),
    'bt':HintTypeMenuItemPojo(
      'bt',
      '强制提醒',
      "需指定提醒日期，无需感应条件，时间到达后会直接提醒，并且必须按下复位按键才会停止提醒（除供电不足情况以外）"
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
            Text("触发类型 *",style: TextStyle(
                color: Colors.blue,
                
              )
            ),
            SizedBox(height: 5),
            DropdownButton<String>(
              underline: Container(
                height: 1,
                color: const Color.fromARGB(255, 121, 116, 126), // 下划线颜色
              ),
              value: widget.hintSelectValue,
              
              isExpanded: true,
              items: hintTypeMenuItemPojoMap.values
              .map((pojo) => DropdownMenuItem(
                    value: pojo.id,
                    child: Text(pojo.text),
                  ))
              .toList(),

              onChanged: (value){
                widget.onGetData?.call(value!);
              }
            ),
            SizedBox(height: 5),
            Text(hintTypeMenuItemPojoMap[widget.hintSelectValue]!.hint,
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