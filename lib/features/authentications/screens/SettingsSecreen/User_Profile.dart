


import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:save_the_bilby_fund/features/authentications/screens/SettingsSecreen/profile_form_widget.dart';
import '../../../../constants/colors.dart';
import '../../controllers/session_controller.dart';
import '../custom_appbar.dart';
import '../login/login_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);





  @override
  Widget build(BuildContext context){

    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: false,
        appBar: AppBar(
        backgroundColor: tPrimaryColor,
        centerTitle: true,
        automaticallyImplyLeading: false,

        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(40),
          ),
        ),

        bottom: PreferredSize(
            preferredSize: const Size.fromHeight(140.0),
            child: Container(
              padding: const EdgeInsets.only(bottom: 15),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [


                      Image(image: AssetImage("assets/images/whitebilby.png"), height: 120),
                      SizedBox(width: 50,),

                      Center(
                        child: SizedBox.fromSize(
                          size: Size(56, 56),
                          child: ClipOval(
                            child: Material(
                              color: tPrimaryColor,
                              child: InkWell(
                                splashColor: Colors.white,
                                onTap: () {
                                  FirebaseAuth auth = FirebaseAuth.instance;

                                  auth.signOut().then((value){
                                    SessionController().userid = '';
                                    Get.offAll(() => const LoginScreen());
                                  });
                                },
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Icon(Icons.logout, color: Colors.white, size: 30,),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 15,),


                    ],
                  ),

                  Container(
                    margin: const EdgeInsets.only(top: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:  [
                        Text(
                          "Profile",
                          style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.w700,
                              color: Colors.white),
                        ),

                      ],
                    ),
                  )
                ],
              ),
            )),
      ),

      body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(30),
            child: Column(
              children:  [
                ProfileFormWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}




