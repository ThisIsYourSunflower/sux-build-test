import 'package:app/Component/other/Time/MineTimeSelect.dart';
import 'package:app/pojos/componentPojos/timeSelect/PickerDataSpik.dart';
import 'package:flutter/material.dart';

class CreateTaskAddTimeRangeComponent extends StatefulWidget {
  Pickerdataspik startPickerdataspik;
  Pickerdataspik endPickerdataspik;
  
  ValueChanged<List<int>>? onGetData;
  
  CreateTaskAddTimeRangeComponent({super.key,required this.startPickerdataspik,required this.endPickerdataspik,this.onGetData});

  @override
  State<CreateTaskAddTimeRangeComponent> createState() => _CreateTaskAddTimeRangeComponentState();
}

class _CreateTaskAddTimeRangeComponentState extends State<CreateTaskAddTimeRangeComponent> {
  String startTip = "";
  String endTip = "";
  @override
  void initState() {
    super.initState();
    DateTime ?now = widget.startPickerdataspik.now;
    if(now != null){
      widget.endPickerdataspik.now = now.add(Duration(minutes: 5));
    }
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
            Text("指定范围 *",style: TextStyle(
                color: Colors.blue
              )
            ),
            SizedBox(height: 10),
            Container(
              padding: EdgeInsets.all(2),
              width: double.infinity,
              color:Color.fromARGB(255, 237, 232, 240),
              child: Text("1.开始范围",style: TextStyle(
                  color: Colors.black
                )
              ),
            ),
            

            SizedBox(height: 5),
            MineTimeSelect(pickerdataspik: widget.startPickerdataspik,onGetData: (o){
              startTip = "${o.year}年${o.month}月${o.day}日${o.hour}时${o.minute}分";
              widget.endPickerdataspik.now = DateTime(o.year,o.month,o.day,o.hour,o.minute + 5);
              setState(() {
              });
            }),
            SizedBox(height: 10),
            Container(
              padding: EdgeInsets.all(2),
              width: double.infinity,
              color:Color.fromARGB(255, 237, 232, 240),
              child: Text("2.结束范围",style: TextStyle(
                  color: Colors.black
                )
              ),
            ),
            SizedBox(height: 5),
            MineTimeSelect(pickerdataspik: widget.endPickerdataspik,onGetData: (o){
              endTip = "${o.year}年${o.month}月${o.day}日${o.hour}时${o.minute}分";
              setState(() {
              });
            }),
            SizedBox(height: 5),
            RichText(
              text: TextSpan(
                style: TextStyle(
                  fontSize: 15,
                  color: const Color.fromARGB(255, 88, 88, 88),
                ),
                children: [
                  TextSpan(
                    text: startTip,
                    style: TextStyle(
                      color: Colors.blue,
                    ),
                  ),
                  TextSpan(
                    text: " 至 "
                  ),
                  TextSpan(
                    text: endTip,
                    style: TextStyle(
                      color: Colors.blue,
                    ),
                  ),
                  TextSpan(
                    text: " 之间提醒",
                  ),
                ],
              ),
            ),
            
            SizedBox(height: 20),
          ],
        )
      )
    );
  }
}