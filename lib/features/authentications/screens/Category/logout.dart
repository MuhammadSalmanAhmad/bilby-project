


import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../../controllers/session_controller.dart';
import '../login/login_screen.dart';

 Logout(){
  FirebaseAuth auth = FirebaseAuth.instance;

  auth.signOut().then((value){
    SessionController().userid = '';
    Get.offAll(() => const LoginScreen());
  });
}