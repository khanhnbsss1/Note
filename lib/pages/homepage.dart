import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:note/pages/list_notes/view/list_note_page.dart';
import 'package:note/pages/profile/view/profile_page.dart';

import 'calendar/view/calendar.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> with TickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: TabBarView(
          controller: tabController,
          physics: NeverScrollableScrollPhysics(),
          children: [
            ListNotePage(),
            CalendarPage(),
            ProfilePage(),
          ],
        ),
        bottomNavigationBar: Theme(
          data: ThemeData(splashColor: Colors.transparent),
          child: BottomNavigationBar(
            useLegacyColorScheme: false,
            enableFeedback: false,
            fixedColor: Colors.red,
            type: BottomNavigationBarType.fixed,
            currentIndex: _currentIndex,
            onTap: (index) {
              setState(() {
                _currentIndex = index;
                tabController.animateTo(index);
              });
            },
            items: [
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                ),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.calendar_month),
                label: 'Calender',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Profile',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
