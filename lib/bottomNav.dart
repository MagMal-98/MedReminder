import 'package:flutter/material.dart';

import 'package:med_remind/notepad.dart';
import 'package:med_remind/mainScreen.dart';
import 'package:med_remind/pillsList.dart';

class bottomNav extends StatefulWidget {
  @override
  _bottomNavState createState() => _bottomNavState();
}

class _bottomNavState extends State<bottomNav> {
  PageController _pageController = PageController(
    initialPage: 0,
  );
  int _selectedIndex = 0;
  List<Widget> _widgetOptions = <Widget>[
    Text('Home'),
    Text('Notes'),
    //Home(),
    //Notepad(),
  ];

  void _onItemTap(int index) {
    setState(() {
      _selectedIndex = index;
      _pageController.jumpToPage(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Med Reminder'),
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: _onItemTap,
        children: <Widget>[
          pillsList(),
          mainScreen(),
          notepad(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color(0xFF0C9869),
        selectedItemColor: Color(0xFF3C4046),
        unselectedItemColor: Colors.white,
        
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Medicine list',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.alarm),
            label: 'Reminders',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.note),
            label: 'Notepad',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTap,
      ),
    );
  }
}
