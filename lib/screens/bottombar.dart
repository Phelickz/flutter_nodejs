import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_node_js/pageviews/dashboard.dart';
import 'package:flutter_node_js/pageviews/notepage.dart';
import 'package:flutter_node_js/pageviews/profile.dart';
import 'package:flutter_node_js/pageviews/reminders.dart';
import 'package:flutter_node_js/screens/home.dart';
import 'package:flutter_node_js/utils/colors.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  PageController _pageController;
  int _page = 0;

  @override
  void initState() {
    _pageController = PageController();
    super.initState();
  }

  void _onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }

  void _bottomTapped(int page) {
    _pageController.jumpToPage(page);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: GlobalColors.blackColor,
        body: PageView(
          // physics: NeverScrollableScrollPhysics(),
          controller: _pageController,
          onPageChanged: _onPageChanged,
          children: <Widget>[
            Container(child: DashBoard('sss')),
            Container(child: Reminders()),
            Container(child: NotePage()),
            Container(
              child: Profile()
            ),
          ],
        ),
        bottomNavigationBar: Container(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 5),
            child: CupertinoTabBar(
              onTap: _bottomTapped,
              currentIndex: _page,
              backgroundColor: GlobalColors.blackColor,
              items: <BottomNavigationBarItem>[
                _bottomNavigationBarItem(
                    "Home",
                    0,
                    Icon(
                      Icons.dashboard,
                      size: 25,
                      color: _page == 0
                          ? GlobalColors.redColor
                          : GlobalColors.greyColor,
                    )),
                _bottomNavigationBarItem(
                    "Tasks",
                    1,
                    Icon(
                      Icons.track_changes,
                      size: 25,
                      color: _page == 1
                          ? GlobalColors.redColor
                          : GlobalColors.greyColor,
                    )),
                _bottomNavigationBarItem(
                    "Notes",
                    2,
                    Icon(
                      Icons.note,
                      size: 25,
                      color: _page == 2
                          ? GlobalColors.redColor
                          : GlobalColors.greyColor,
                    )),
                _bottomNavigationBarItem(
                    "Profile",
                    3,
                    Icon(
                      Icons.account_circle,
                      size: 25,
                      color: _page == 3
                          ? GlobalColors.redColor
                          : GlobalColors.greyColor,
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }

  BottomNavigationBarItem _bottomNavigationBarItem(
      String label, int number, Widget icon) {
    return BottomNavigationBarItem(
      icon: icon,
      // title: Text(
      //   label,
      //   style: TextStyle(
      //     fontSize: 10,
      //     color:
      //         _page == number ? GlobalColors.redColor : GlobalColors.greyColor,
      //   ),
      // ),
    );
  }
}
