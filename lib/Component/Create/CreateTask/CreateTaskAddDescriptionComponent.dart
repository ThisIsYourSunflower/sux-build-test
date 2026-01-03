import 'package:flutter/material.dart';

class CreateTaskAddDescriptionComponent extends StatefulWidget {
  final ValueChanged<String>? onGetData;
  const CreateTaskAddDescriptionComponent({super.key,this.onGetData});

  @override
  State<CreateTaskAddDescriptionComponent> createState() => _CreateTaskAddDescriptionComponentState();
}

class _CreateTaskAddDescriptionComponentState extends State<CreateTaskAddDescriptionComponent>
    with SingleTickerProviderStateMixin {

  // TextEditingController _descriptionController = TextEditingController();
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
            Text("提醒描述",style: TextStyle(
                color: Colors.blue
              )
            ),
            SizedBox(height: 5),
            TextFormField(
              maxLines: 5,
              maxLength: 200,
              decoration: InputDecoration(
                hintText: '详细描述提醒信息...',
                hintStyle:TextStyle(
                  color:Color.fromARGB(255, 174, 174, 174)
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                contentPadding: EdgeInsets.all(16),
              ),
              // controller: _descriptionController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return '描述不能为空';
                }
                if (value.length < 10) {
                  return '描述至少10个字';
                }
                return null;
              },
              onChanged: (value) {
               widget.onGetData?.call(value);
              },
            )
          ],
        )
      )
    );
  }
}