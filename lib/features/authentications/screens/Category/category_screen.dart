import 'dart:ui';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:save_the_bilby_fund/common_widgets/category_card.dart';
import 'package:save_the_bilby_fund/constants/image_strings.dart';
import 'package:save_the_bilby_fund/features/authentications/screens/custom_appbar.dart';
import 'package:save_the_bilby_fund/constants/colors.dart';
import 'package:save_the_bilby_fund/features/authentications/screens/Category/cards_grid_widget.dart';
import 'package:save_the_bilby_fund/features/admin/screens/uploadScreen/upload_screen_backend.dart';
import 'package:firebase_database/firebase_database.dart';

import 'data.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  final DatabaseReference imageref = FirebaseDatabase.instance.ref().child('images');
  final storageref = FirebaseStorage.instance.ref('images/');

  var imageurl = UploadProgressController.fileName;

  int count = 0;

  List<Data> datalist = [];



  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  Text(
                    "Skip",
                    style: TextStyle(
                        fontSize: 20,
                        color: tPrimaryColor,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),

              Container(
                height: 250,


                child: StreamBuilder(
                  // stream: imageref.child("1762050672970235696").onValue,
                  stream: imageref.onValue,
                  builder: (context, AsyncSnapshot snapshot) {
                    if (!snapshot.hasData) {
                      return Text("No image to show");
                    } else if (snapshot.hasData)
                    {
                      datalist.clear();
                      var keys = snapshot.data.snapshot.value.keys;
                      var values = snapshot.data.snapshot.value;
                      for(var key in keys){
                        Data data = new Data(
                            values [key]["imageURL"]
                        );
                        datalist.add(data);
                      }
                      // Map<dynamic, dynamic> map = snapshot.data.snapshot.value;
                      return Container(
                        child: Image.network(datalist[1].imgurl),
                      );
                    } else
                      return Image.asset('assets/images/bilby.jpg');
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