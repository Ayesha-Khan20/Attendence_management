



import 'package:attendance_system/models/userModel.dart';
import 'package:attendance_system/screens/studentPanel/studentpanelProfileScreen.dart';
import 'package:attendance_system/screens/userPanel/userPanel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';


class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  final PersistentTabController _controller =
      PersistentTabController(initialIndex: 0);

  List<Widget> _buildScreens() {
    return [const Profile(),const UserPanel()];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.home),
        title: ("Home"),
        activeColorPrimary: const Color.fromARGB(255, 43, 193, 178),
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.man),
        title: ("StudentPanel"),
        activeColorPrimary:  const Color.fromARGB(255, 43, 193, 178),
        inactiveColorPrimary: Colors.grey,
      ),
     
    ];
  }

  void getcredentials() async {
    DocumentSnapshot doc = await FirebaseFirestore.instance
        .collection('Users')
        .doc('${userInfo.email}')
        .get();
    setState(() {
      userInfo.name = doc['name'];
      userInfo.rollnumber = doc['rollno'];
      
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    getcredentials();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      confineInSafeArea: true,
      backgroundColor: Colors.white,
      handleAndroidBackButtonPress: true,
      resizeToAvoidBottomInset: true,
      stateManagement: true, // Default is true.
      hideNavigationBarWhenKeyboardShows: true,
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(10.0),
        colorBehindNavBar: Colors.white,
      ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: const ItemAnimationProperties(
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: const ScreenTransitionAnimation(
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle: NavBarStyle.style1,
    );
  }
}