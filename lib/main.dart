import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:save_the_bilby_fund/repository/authentication_repository/authentication_repository.dart';
// import 'features/authentications/screens/SplashScreen/splash_screen.dart';
import 'features/authentications/screens/SplashScreen/splash_screen.dart';
import 'features/authentications/screens/login/login_screen.dart';

import 'firebase_options.dart';
import 'package:get/get.dart';


//Function to initialize Firebase
Future<void> initializeDefault() async {
  //to Check Platform
  if (Platform.isAndroid) {
// Android-specific code
    debugPrint("Running on Android");
  } else if (Platform.isIOS) {
// iOS-specific code
    debugPrint("Running on iOS");
  }
}
main() async {
  print("main started");

  WidgetsFlutterBinding.ensureInitialized();
  // initializeDefault();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
      // .then((value) => Get.put(AuthenticationRepository()));

  print('Initialized default app');
  //to Check Platform
  if (Platform.isAndroid) {
// Android-specific code
    print("Running on Android");
  } else if (Platform.isIOS) {
// iOS-specific code
    print("Running on iOS");
  }  print("Firebase Initialized");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      // theme: TAppTheme.lightTheme,
      // darkTheme: TAppTheme.darkTheme,
      themeMode: ThemeMode.system,
      theme: ThemeData(
        textTheme: GoogleFonts.amaranthTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      home: Splash(),
    );
  }
}




