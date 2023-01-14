import 'dart:ui';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:save_the_bilby_fund/common_widgets/category_card.dart';
import 'package:save_the_bilby_fund/constants/image_strings.dart';
import 'package:save_the_bilby_fund/features/authentications/screens/custom_appbar.dart';
import 'package:save_the_bilby_fund/constants/colors.dart';
import 'package:save_the_bilby_fund/features/authentications/screens/Category/cards_grid_widget.dart';
import 'package:save_the_bilby_fund/features/admin/screens/uploadScreen/upload_screen_backend.dart';
import 'package:firebase_database/firebase_database.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  var filename = UploadProgressController.fileName;
  Future<List> get_urls() async {
     DatabaseReference ref = FirebaseDatabase.instance().getReference().child("images");
    ref.addListenerForSingleValueEvent(
            new ValueEventListener() {
                @Override
                public void onDataChange(DataSnapshot dataSnapshot) {
                    //Get map of users in datasnapshot
                    collectPhoneNumbers((Map<String,Object>) dataSnapshot.getValue());
                }

                @Override
                public void onCancelled(DatabaseError databaseError) {
                    //handle databaseError
                }
            });
    // final DatabaseReference main_image_reference =
    //     FirebaseDatabase.instance.ref('images');
        
    // DatabaseEvent event = await main_image_reference.once();
    // List<String> images_names = event.snapshot as List<String>;
    // debugPrint(images_names.toString());
    // return event.snapshot as List<String>;
  }

  final storageref = FirebaseStorage.instance.ref('images/');
  var url;
  Future<String> get_image() async {
    url = await storageref.child("1002513214710105619").getDownloadURL();
    debugPrint(url);
    return url.toString();
    debugPrint(url.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Wrap(
            runSpacing: 10,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "Skip",
                    style: TextStyle(
                        fontSize: 20,
                        color: tPrimaryColor,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              ElevatedButton(onPressed: () {
                get_urls();
              }, child: Text("GET IMAGES LIST")),
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
