import 'package:flutter/material.dart';

class CreateTaskAddTimeRangeComponent extends StatefulWidget {
  const CreateTaskAddTimeRangeComponent({super.key});

  @override
  State<CreateTaskAddTimeRangeComponent> createState() => _CreateTaskAddTimeRangeComponentState();
}

class _CreateTaskAddTimeRangeComponentState extends State<CreateTaskAddTimeRangeComponent> {
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
            SizedBox(height: 5),
            TextField(
              decoration: InputDecoration(
                // border: OutlineInputBorder(),
                hintText: '指定范围测试',
                hintStyle:TextStyle(
                  color:Color.fromARGB(255, 174, 174, 174)
                ) 
              ),
            )
          ],
        )
      )
    );
  }
}