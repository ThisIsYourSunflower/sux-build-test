import 'package:flutter/material.dart';

// 定义事件数据模型
class TaskItem {
  final String id;
  final String label;
  final String timeRange;
  final bool isEnabled;

  TaskItem({
    required this.id,
    required this.label,
    required this.timeRange,
    this.isEnabled = true,
  });
}

class TaskPage extends StatefulWidget {
  TaskPage({Key? key}) : super(key: key);

  @override
  _TaskPageState createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  // 模拟事件数据
  List<TaskItem> _tasks = [
    TaskItem(
      id: '1',
      label: '会议记录',
      timeRange: '09:00 - 10:00',
      isEnabled: false,
    ),
    TaskItem(
      id: '2',
      label: '项目进度跟踪',
      timeRange: '14:00 - 15:30',
      isEnabled: true,
    ),
    TaskItem(
      id: '3',
      label: '团队讨论',
      timeRange: '16:00 - 17:00',
      isEnabled: false,
    )
  ];

  // 切换事件启用状态
  void _toggleTaskEnabled(String id) {
    setState(() {
      _tasks = _tasks.map((task) {
        if (task.id == id) {
          return TaskItem(
            id: task.id,
            label: task.label,
            timeRange: task.timeRange,
            isEnabled: !task.isEnabled,
          );
        }
        return task;
      }).toList();
    });
  }

  // 添加新事件
  void _addNewTask() {
    Navigator.pushNamed(context,"/create");
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.grey[100],
      child: Stack(
        children: [
          // 任务列表
          ListView.builder(
            padding: EdgeInsets.all(16.0),
            itemCount: _tasks.length,
            itemBuilder: (context, index) {
              final task = _tasks[index];
              return Card(
                elevation: 2.0,
                margin: EdgeInsets.only(bottom: 12.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                  leading: Icon(
                    Icons.access_time,
                    color: task.isEnabled ? Colors.blue : Colors.grey,
                    size: 28.0,
                  ),
                  title: Text(
                    task.label,
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w500,
                      // color: Colors.white,
                    ),
                  ),
                  subtitle: Padding(
                    padding: EdgeInsets.only(top: 4.0),
                    child: Text(
                      task.timeRange,
                      style: TextStyle(
                        fontSize: 14.0,
                        // color: Colors.white,
                      ),
                    ),
                  ),
                  trailing: Switch(
                    value: task.isEnabled,
                    onChanged: (value) => _toggleTaskEnabled(task.id),
                    activeColor: Colors.blue,
                  ),
                  onTap: () {
                    // 点击事件的逻辑
                    print('点击事件: ${task.label}');
                  },
                ),
              );
            },
          ),
          // 底部漂浮按钮
          Positioned(
            left: 0,
            right: 0,
            bottom: 16.0,
            child: Center(
              child: FloatingActionButton(
                onPressed: _addNewTask,
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                tooltip: '添加事件',
                child: Icon(Icons.add),
              ),
            ),
          ),
        ],
      ),
    );
  }
}