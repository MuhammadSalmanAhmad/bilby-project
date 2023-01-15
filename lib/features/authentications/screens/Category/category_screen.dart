import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:save_the_bilby_fund/common_widgets/category_card.dart';
import 'package:save_the_bilby_fund/constants/image_strings.dart';
import 'package:save_the_bilby_fund/features/authentications/screens/SettingsSecreen/User_Profile.dart';
import 'package:save_the_bilby_fund/features/authentications/screens/contachForm/contact_form.dart';
import 'package:save_the_bilby_fund/features/authentications/screens/custom_appbar.dart';
import 'package:save_the_bilby_fund/constants/colors.dart';
import 'package:save_the_bilby_fund/features/authentications/screens/Category/cards_grid_widget.dart';
import 'package:save_the_bilby_fund/features/admin/screens/uploadScreen/upload_screen_backend.dart';
import 'package:firebase_database/firebase_database.dart';

import '../../controllers/session_controller.dart';
import '../login/login_screen.dart';
import 'data.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  final DatabaseReference imageref =
      FirebaseDatabase.instance.ref().child('images');
  final storageref = FirebaseStorage.instance.ref('images/');

  var imageurl = UploadProgressController.fileName;

  int count = 0;

  List<Data> datalist = [];

  void Remove() async {
    List<String> imagekeys = [];
    final Mainimageref = FirebaseDatabase.instance.ref("images");
    DatabaseEvent event = await Mainimageref.once();
    Map<String, dynamic> children =
    Map<String, dynamic>.from(event.snapshot.value as Map);

    children.entries.forEach((e) => imagekeys.add(e.key.toString()));
    debugPrint(imagekeys.toString());

    final DatabaseReference ref =
    FirebaseDatabase.instance.ref().child('images/${imagekeys[0]}');
    ref.remove();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        color: Color(0xff004D4D),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
          child: GNav(
            gap: 9,
            backgroundColor: Color(0xff004D4D),
            tabBackgroundColor: Colors.white24,
            color: Colors.white,
            activeColor: Colors.white,
            padding: EdgeInsets.all(10),

            onTabChange: (index){
              print(index);
              if(index == 0){
                Get.to(() => const CategoriesScreen());
              }
              else if(index == 1){
                Get.to(() => const ContactForm());

              }
              else if(index == 2){
                Get.to(() => const ProfileScreen());

              }
              else if(index == 3){
                FirebaseAuth auth = FirebaseAuth.instance;

                auth.signOut().then((value){
                  SessionController().userid = '';
                  Get.offAll(() => const LoginScreen());
                });
              }

            },

            tabs: [
              GButton(
                icon: Icons.app_registration_rounded,
                text: "Survey",
              ),
              GButton(
                icon: Icons.message,
                text: "Contact Us",
              ),
              GButton(
                icon: Icons.person,
                text: "Profile",

              ),
              GButton(
                icon: Icons.logout,
                text: "Logout",
              )
            ],



          ),
        ),
      ),
      appBar: customAppBar("Bilby", Icons.arrow_back),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Wrap(
            runSpacing: 10,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                      onPressed: () {
                        setState(() {
                          count++;
                        });
                      },
                      child: Text('skip',
                          style: TextStyle(
                              fontSize: 20,
                              color: tPrimaryColor,
                              fontWeight: FontWeight.bold)))
                ],
              ),
              Container(
                height: 250,
                child: StreamBuilder(
                  // stream: imageref.child("1762050672970235696").onValue,
                  stream: imageref.onValue,
                  builder: (context, AsyncSnapshot snapshot) {
                    if (!snapshot.hasData) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasData) {
                      datalist.clear();
                      var keys = snapshot.data.snapshot.value.keys;
                      var values = snapshot.data.snapshot.value;
                      for (var key in keys) {
                        Data data = new Data(values[key]["imageURL"]);
                        datalist.add(data);
                      }
                      // Map<dynamic, dynamic> map = snapshot.data.snapshot.value;
                      return Container(
                         
                        child: Image.network(datalist[count].imgurl,fit: BoxFit.cover,),
                      );
                    }
                    // else{
                    //   return Image.asset('assets/images/bilby.jpg');
                    //
                    //
                    // }
                    return Center(child: CircularProgressIndicator());
                  },
                ),
              ),
              Text(
                "Category",
                style: TextStyle(
                    color: tPrimaryColor,
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                "Please select a category for the image shown above to the best of your knowledge",
                style: TextStyle(
                  color: tPrimaryColor,
                  fontSize: 20,
                ),
              ),
              CategoryList(),
            ],
          ),
        ),
      ),
    );
  }
}
