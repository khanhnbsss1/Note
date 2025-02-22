import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:note/config/app_color.dart';
import 'package:note/pages/expense/view/expense.dart';
import 'package:note/pages/history_transaction/view/history_transaction_page.dart';
import 'package:note/pages/list_notes/view/list_note_page.dart';
import 'package:note/pages/profile/controller/profile_controller.dart';
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
    tabController = TabController(length: 5, vsync: this);
    super.initState();
  }

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: IndexedStack(
          index: tabController.index,
          // controller: tabController,
          // physics: NeverScrollableScrollPhysics(),
          children: [
            ListNotePage(),
            CalendarPage(),
            ExpensePage(),
            HistoryTransactionPage(),
            ProfilePage(),
          ],
        ),
        bottomNavigationBar: Theme(
          data: ThemeData(splashColor: Colors.transparent,),
          child: BottomNavigationBar(
            backgroundColor: Theme.of(context).bottomAppBarTheme.color,
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
                icon: Icon(Icons.money),
                label: 'Profile',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.monetization_on_outlined),
                label: 'Profile',
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
