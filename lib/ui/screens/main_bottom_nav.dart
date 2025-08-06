import 'package:flutter/material.dart';
import 'package:new_task/ui/screens/cancel_task_screen.dart';
import 'package:new_task/ui/screens/complete_task_screen.dart';
import 'package:new_task/ui/screens/new_task_screen.dart';
import 'package:new_task/ui/screens/progress_task_screen.dart';

import '../widgets/tm_appbar.dart';

class MainBottomNavScreen extends StatefulWidget {
  const MainBottomNavScreen({super.key});

  @override
  State<MainBottomNavScreen> createState() => _MainBottomNavScreenState();
}

class _MainBottomNavScreenState extends State<MainBottomNavScreen> {
  int _selectedIndex = 0;

  List<Widget> _screens = [
    NewTaskScreen(),
    CompleteTaskScreen(),
    CancelTaskScreen(),
    ProgressTaskScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: TMAppbar(),
        body: _screens[_selectedIndex],
        bottomNavigationBar: NavigationBar(
          selectedIndex: _selectedIndex,
            onDestinationSelected: (index){
            setState(() {
              _selectedIndex = index;
            });
            },
            destinations: [
              NavigationDestination(icon: Icon(Icons.newspaper), label: "New"),
              NavigationDestination(icon: Icon(Icons.cloud_done_outlined), label: "Completed"),
              NavigationDestination(icon: Icon(Icons.cancel_presentation), label: "Cancel"),
              NavigationDestination(icon: Icon(Icons.policy_outlined), label: "Progress"),
            ]
        )
    );
  }
}


