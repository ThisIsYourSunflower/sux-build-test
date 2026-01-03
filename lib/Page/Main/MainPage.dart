import 'package:app/Component/Main/AppSetting/AppSetting.dart';
import 'package:app/Component/Main/TaskPage/TaskPage.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  int _pageIndex = 0;

  final List<Map<String,String>> _bottomTabList = [
    {
      "text":"计划列表",
      "defulat_ioc":"lib/assets/d-function.png",
      "active_ioc":"lib/assets/a-function.png"
    },
    {
      "text":"设置",
      "defulat_ioc":"lib/assets/d-driver.png",
      "active_ioc":"lib/assets/a-driver.png"
    },
  ];

  List<Widget> _getMainPageComChildrean(){
    return [TaskPage(),AppSetting()];
  }

  List<BottomNavigationBarItem> _getBottomNavList(){
    return List.generate(_bottomTabList.length, (int index){
      return BottomNavigationBarItem(
        icon: Image.asset(_bottomTabList[index]["defulat_ioc"]!,width: 30,height: 30,),
        activeIcon: Image.asset(_bottomTabList[index]["active_ioc"]!,width: 30,height: 30,),
        label: _bottomTabList[index]["text"]
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_bottomTabList[_pageIndex]["text"]!,style: TextStyle(color: Colors.white)),
        backgroundColor: Theme.of(context).brightness == Brightness.light 
      ? Colors.blue  // 暗色主题时用蓝色
        : null,   
      ),
      body: IndexedStack(
        index: _pageIndex,
        children: _getMainPageComChildrean(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        // backgroundColor: Colors.white,
        items: _getBottomNavList(),
        currentIndex: _pageIndex,
        // selectedItemColor: Colors.black,
        // unselectedItemColor: Colors.black,
        onTap: (value) {
          setState(() {
            _pageIndex = value;
          });
        },
      ),
    );
  }
}