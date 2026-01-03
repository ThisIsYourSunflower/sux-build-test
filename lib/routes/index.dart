import 'package:app/Page/CreatePage/CreatePage.dart';
import 'package:app/Page/Main/MainPage.dart';
import 'package:flutter/material.dart';

Widget getRootWidget(){
  return MaterialApp(
    initialRoute: "/",
    theme: ThemeData.light(),
    // darkTheme: ThemeData.dark(),
    // themeMode: ThemeMode.system, // ← 跟随系统设置
    routes: getRootRoutes(),
  );
}
Map<String, Widget Function(BuildContext)> getRootRoutes(){
  return {
    "/" : (context) => MainPage(),
    "/create" : (context) => CreatePage()
  };
}

