

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:save_the_bilby_fund/features/authentications/screens/login/login_screen.dart';

import '../../../../constants/colors.dart';
import '../../controllers/session_controller.dart';
import '../SettingsSecreen/User_Profile.dart';
import '../contachForm/contact_form.dart';
import 'category_screen.dart';
import 'logout.dart';



class NavBar extends StatefulWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {

  int currentindex = 0;
  final screens = [
    CategoriesScreen(),
    ProfileScreen(),
    ContactForm(),
    // Logout(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type:BottomNavigationBarType.fixed,
        backgroundColor: tPrimaryColor,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white24,
        currentIndex: currentindex,
        onTap: (index) => setState(() => currentindex = index),
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.app_registration_rounded),
            label: "Survey",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profile",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message),
            label: "Contact Us",
          ),
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.logout),
          //   label: "Logout",
          // ),
        ],
      ),
      body: screens[currentindex],

    );
  }


}
