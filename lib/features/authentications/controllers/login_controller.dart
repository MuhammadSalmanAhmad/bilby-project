



import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:save_the_bilby_fund/features/authentications/controllers/session_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:save_the_bilby_fund/features/authentications/screens/Category/category_screen.dart';

import '../../../repository/authentication_repository/authentication_repository.dart';
import '../../../utils/Dashboard.dart';
import '../screens/login/login_screen.dart';

class LoginController extends GetxController {
  static LoginController get instance => Get.find();


  /// TextField Controllers to get data from TextFields
  final emailController = TextEditingController();
  final passwordController = TextEditingController();


  /// TextField Validation

  //Call this Function from Design & it will do the rest
  void loginUser(String email, String password) async {

    FirebaseAuth auth = FirebaseAuth.instance;
    final User = auth.currentUser;

    await auth.signInWithEmailAndPassword(email: email, password: password).then((value){
      SessionController().userid = value.user!.uid.toString();});
    // if(await User != null){
      Get.offAll(() => const CategoriesScreen());
    // }

    // try{
    //   await auth.signInWithEmailAndPassword(email: email, password: password).then((value){
    //     SessionController().userid = value.user!.uid.toString();
    //     if(User != null){
    //       Get.offAll(() => const Dash());
    //     }
    //   });
    //
    //   // print("New Login");
    //
    //
    // }catch(error){
    //   if(error != null) {
    //     Get.snackbar("Error", "Details are invalid",
    //         snackPosition: SnackPosition.BOTTOM,
    //         backgroundColor: Colors.redAccent.withOpacity(0.1),
    //         colorText: Colors.red
    //     );
    //   }
    //   else if(error == null) {
    //     Get.snackbar("Logging In", "Welcome to DashBoard",
    //         snackPosition: SnackPosition.BOTTOM,
    //         backgroundColor: Colors.greenAccent.withOpacity(0.1),
    //         colorText: Colors.teal
    //     );
    //   }
    //
    // }


  }
}