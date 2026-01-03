
import 'package:app/Component/other/Time/MineTimeSelect.dart';
import 'package:app/pojos/componentPojos/timeSelect/PickerDataSpik.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CreateTaskAddTimeAssignComponent extends StatefulWidget {
  Pickerdataspik pickerdataspik;
  final ValueChanged<List<int>>? onGetData;
  
  CreateTaskAddTimeAssignComponent({super.key,required this.pickerdataspik,this.onGetData});

  @override
  State<CreateTaskAddTimeAssignComponent> createState() => _CreateTaskAddTimeAssignComponentState();
}

class _CreateTaskAddTimeAssignComponentState extends State<CreateTaskAddTimeAssignComponent> {
  String assignTip1 = '';  
  String assignTip2 = '';  
  @override
  void initState() {
    super.initState();
  }

  
  
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
            Text("强制触发时间 *",style: TextStyle(
                color: Colors.blue
              )
            ),
            SizedBox(height: 5),
            MineTimeSelect(pickerdataspik: widget.pickerdataspik,onGetData: (o){
              assignTip1 = "${o.year}年${o.month}月${o.day}日 ${o.hour}时${o.minute}分强制触发";
              setState(() {
              });
            }),
            SizedBox(height: 5),
            Container(
              alignment: Alignment.center,
              child: Text(
                assignTip1,
                style: TextStyle(
                  fontSize: 15,
                  color: const Color.fromARGB(255, 88, 88, 88)

                )
              ),
            )
          ],
        )
      )
    );
  }
}