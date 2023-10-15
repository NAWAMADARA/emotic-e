
import 'package:emotic_e/view/teacher/assignment_page.dart';
import 'package:emotic_e/view/teacher/class_screen.dart';
import 'package:emotic_e/view/teacher/quiz_screen.dart';
import 'package:flutter/material.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {

  int _selectedTab = 0;

  final List _pages = [
    const  ClassScreen(),
    const AssignmentScreen(),
    const QuizApp()
  ];

  _changeTab(int index) {
    setState(() {
      _selectedTab = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [],
        backgroundColor: Colors.black,
        title: const Center(
            child: Text(
              'EMOTIC-E',
              style: TextStyle(color: Colors.red),
            )),
      ),
      body: _pages[_selectedTab],
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedTab,
          onTap: (index) => _changeTab(index),
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.grey,
          type: BottomNavigationBarType.fixed,
          showUnselectedLabels: true,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.group),
                label: 'Classes',
                backgroundColor: Colors.red),
            BottomNavigationBarItem(
                icon: Icon(Icons.assignment),
                label: 'Assignments',
                backgroundColor: Colors.red),
            BottomNavigationBarItem(
                icon: Icon(Icons.quiz),
                label: 'Quiz',
                backgroundColor: Colors.red),
            BottomNavigationBarItem(
                icon: Icon(Icons.more_horiz),
                label: 'More',
                backgroundColor: Colors.red),
          ]),
    );
  }
}
