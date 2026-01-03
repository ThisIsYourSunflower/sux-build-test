import 'package:flutter/material.dart';

class AppSetting extends StatefulWidget {
  AppSetting({Key? key}) : super(key: key);

  @override
  _AppSettingState createState() => _AppSettingState();
}

class _AppSettingState extends State<AppSetting> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Text("设置"),
    );
  }
}