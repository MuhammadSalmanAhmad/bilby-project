



import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:save_the_bilby_fund/features/authentications/controllers/session_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../features/authentications/screens/SettingsSecreen/User_Profile.dart';
import '../features/authentications/screens/login/login_screen.dart';
import '../repository/authentication_repository/authentication_repository.dart';

class Dash extends StatelessWidget {
  const Dash({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          body: Center(child: Column(children: <Widget>[
            Container(
              margin: EdgeInsets.all(25),
              child: Text(SessionController().userid.toString()),

            ),
            Container(
              margin: EdgeInsets.all(25),
              child: ElevatedButton(
                child: Text('Logout', style: TextStyle(fontSize: 20.0),),

                onPressed: () async {
                  FirebaseAuth auth = FirebaseAuth.instance;

                  auth.signOut().then((value){
                    SessionController().userid = '';
                    Get.offAll(() => const LoginScreen());
                  });
                },
              ),
            ),

            Container(
              margin: EdgeInsets.all(25),
              child: ElevatedButton(
                child: Text('Profile', style: TextStyle(fontSize: 20.0),),

                onPressed: () async {
                  Get.to(() => const ProfileScreen());

                },
              ),
            ),
          ]
          )),
    );
  }
}
