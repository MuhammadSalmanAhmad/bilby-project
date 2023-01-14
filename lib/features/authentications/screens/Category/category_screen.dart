import 'dart:convert';
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
  int count = 0;

  // final storageref = FirebaseStorage.instance.ref('images/');
  // var url;
  // Future<String> download() async {
  //   url = await storageref.child("1002513214710105619").getDownloadURL();
  //   debugPrint(url);
  //   return url.toString();
  //   debugPrint(url.toString());
  // }

  List<String> imagekeys = [];
  Future<String> get_urls() async {
    final Mainimageref = FirebaseDatabase.instance.ref("images");
    DatabaseEvent event = await Mainimageref.once();
    Map<String, dynamic> imagesSnapshot =
        Map<String, dynamic>.from(event.snapshot.value as Map);
    //debugPrint(json.encode(imagesSnapshot));
    // debugPrint("imagesSnapshot.values.toString()\n${imagesSnapshot.keys.toString()}");
    // debugPrint(json.encode(imagesSnapshot));

    imagekeys.add(imagesSnapshot.keys.toString());
    debugPrint(imagekeys.toString());
    return imagekeys.toString();
  }

  Future<String> get_image() async {
    String image_key = await get_urls();
    debugPrint(image_key);
    DatabaseReference imageurlref =
        FirebaseDatabase.instance.ref('images/${image_key}');
    DatabaseEvent event = await imageurlref.child("imageURL").once();
    var data = event.snapshot.value;
    //debugPrint(data.toString());
    return data.toString();
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
              // Container(
              //     height: 250,
              //     child: FutureBuilder(
              //         future: get_urls(),
              //         builder: (context, snapshot) {
              //           if (snapshot.connectionState ==
              //               ConnectionState.waiting) {
              //             return Text('waiting');
              //           } else if (snapshot.hasData) {
              //             return Image.network(snapshot.data!['imageURL']);
              //           } else {
              //             return Text('error');
              //           }
              //         })),
              ElevatedButton(
                  onPressed: () {
                    //get_urls();
                    get_image();
                  },
                  child: Text("get keys")),
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
