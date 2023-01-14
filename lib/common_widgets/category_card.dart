import 'package:flutter/material.dart';
import 'package:save_the_bilby_fund/constants/colors.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:intl/intl.dart';
import 'package:firebase_core/firebase_core.dart';

class CategoryCard extends StatelessWidget {
  final String category_name;
  final String image_url;
  final DateTime now = DateTime.now();
  final DateFormat formater = DateFormat('dd-MM-yyyy');
  bool isCritical = false;
  //REFERENCE TO USERS

//REFERENCE TO CATEGORIZED IMAGES TABLE

  final DatabaseReference reference =
      FirebaseDatabase.instance.ref('Categorized_images');
  CategoryCard(
      {super.key, required this.category_name, required this.image_url});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Color(0xff455A64),
      onTap: (()  {
        if (category_name == 'Bilby') {
          isCritical = true;
        }
      
        reference.child(DateTime.now().microsecondsSinceEpoch.toString()).set({
          'Category ID ': DateTime.now().millisecond,
          'Category  : ': category_name,
          'Critical': isCritical,
          'Date Categorized': formater.format(now),
        });
      }),
      child: Ink(
          height: 50,
          width: 50,
          child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            shadowColor: Colors.black,
            elevation: 20.0,
            clipBehavior: Clip.hardEdge,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image(image: AssetImage(image_url)),
                Text(
                  category_name,
                  style: TextStyle(
                      color: tPrimaryColor,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          )),
    );
  }
}
