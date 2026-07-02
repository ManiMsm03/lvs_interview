import 'package:flutter/material.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:lvsinterview/AppHelper/text_helper.dart';
import 'package:lvsinterview/Screen/other_screens.dart';

import '../AppHelper/color_helper.dart';
import 'home_screen.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {

  int currentIndex = 0;

  final List<IconData> outlineIcons = [
    Icons.home_outlined,
    Icons.celebration_outlined,
    Icons.send_outlined,
    Icons.person_outline,
  ];

  final List<IconData> filledIcons = [
    Icons.home,
    Icons.celebration,
    Icons.send,
    Icons.person,
  ];
  final List<Widget> pages = [
    HomeScreen(),
    OtherScreens(screenName: TextHelper.party),

    OtherScreens(screenName: TextHelper.chats),
    OtherScreens(screenName: TextHelper.profile),
  ];

  @override
  Widget build(BuildContext context) {
   return Scaffold(
     extendBody: true,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: pages[currentIndex],
      ),

      floatingActionButton: SizedBox(
        height: 50,
        child: FloatingActionButton(
          backgroundColor: ColorHelper.white,
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => OtherScreens(screenName: TextHelper.goLive),));
          },
          shape: const CircleBorder(),
          child:  Icon(Icons.sensors,color: ColorHelper.forgotPassword,),

        ),
      ),

      floatingActionButtonLocation:
      FloatingActionButtonLocation.centerDocked,

      bottomNavigationBar:  AnimatedBottomNavigationBar(
        icons: List.generate(
          outlineIcons.length,
              (index) => currentIndex == index
              ? filledIcons[index]
              : outlineIcons[index],
        ),
        activeColor: ColorHelper.white,
        inactiveColor: ColorHelper.white.withOpacity(.8),
        backgroundGradient: LinearGradient(

          colors:[ColorHelper.loginBtn1,ColorHelper.loginBtn2,],),
        activeIndex: currentIndex,
        notchMargin: 3,
        gapLocation: GapLocation.center,

        notchSmoothness: NotchSmoothness.softEdge,


        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
      ),
    );
  }
}
