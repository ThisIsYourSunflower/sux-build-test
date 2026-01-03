import 'package:flutter/material.dart';

class CreateTaskAddTitleComponent extends StatefulWidget {
  CreateTaskAddTitleComponent({Key? key}) : super(key: key);

  @override
  _CreateTaskAddTitleComponentState createState() => _CreateTaskAddTitleComponentState();
}

class _CreateTaskAddTitleComponentState extends State<CreateTaskAddTitleComponent> {
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
            Text("提醒标题 *",style: TextStyle(
                color: Colors.blue
              )
            ),
            SizedBox(height: 5),
            TextField(
              decoration: InputDecoration(
                // border: OutlineInputBorder(),
                hintText: '请输入提醒标题',
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