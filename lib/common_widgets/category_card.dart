import 'package:flutter/material.dart';
import 'package:save_the_bilby_fund/constants/colors.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:intl/intl.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:save_the_bilby_fund/features/authentications/screens/Category/category_screen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CategoryCard extends StatefulWidget {
  late final String category_name;
  late final String image_url;

  // this is URL for send email function

  late final String URL_Image;

  int rewardpoints = 0;
  int count = 1;
  int ImageCategorized = 0;
  CategoryCard(
      {super.key,
      required this.category_name,
      required this.image_url,
      required this.URL_Image});

  @override
  State<CategoryCard> createState() => _CategoryCardState();
}

//Email service

class _CategoryCardState extends State<CategoryCard> {
  bool isCritical = false;

  final DateTime now = DateTime.now();
  final DateFormat formater = DateFormat('dd-MM-yyyy');

  //REFERENCE TO USERS
  final DatabaseReference reference =
      FirebaseDatabase.instance.ref('Categorized_images');

  //EMAIL SERVICE FUNCTION

  Future sendCriticalEmail(String ImageURL, String UserEmail) async {
    String message =
        "Image URL= ${ImageURL}\nDate of Categorization= ${formater.format(now)}";
    final url = Uri.parse("https://api.emailjs.com/api/v1.0/email/send");
    const serviceId = "service_zlcbq3h";
    const templateId = "template_ars5g2u";
    const userId = "3OstZ3o-MZkiyPCwd";

    final response = await http.post(url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          "service_id": serviceId,
          "template_id": templateId,
          "user_id": userId,
          "template_params": {
            "name": "${UserEmail}",
            "subject": "Bilby Detected",
            "message":
                "Critical Image URL= ${ImageURL}\nDate of Detection= ${formater.format(now)}",
            "user_email": UserEmail.toString(),
          }
        }));

    if (response.statusCode == 200) {
      SnackBar(
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.only(bottom: 100.0),
        content: Text(
          "Email Sent",
          style: TextStyle(color: Colors.green),
        ),
      );
    } else {
      SnackBar(
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.only(bottom: 100.0),
        content: Text(response.body),
      );
    }

    debugPrint("RESPONSE CODE: ${response.statusCode}");
    debugPrint("RESPONSE TEXT:${response.body}");
    return response.statusCode;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTapDown: ((details) {
        setState(() {
          this.widget.rewardpoints = this.widget.rewardpoints++;
          this.widget.ImageCategorized++;
        });
      }),
      splashColor: Color(0xff455A64),
      onTap: (() {
        if (this.widget.category_name == 'Bilby') {
          isCritical = true;
          sendCriticalEmail(this.widget.URL_Image, 'SaveBilby@gmail.com');
        }

        reference.child(DateTime.now().microsecondsSinceEpoch.toString()).set({
          'Category  : ': this.widget.category_name,
          'Critical': isCritical,
          'Date Categorized': formater.format(now),
          'Image Url':this.widget.URL_Image,
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
                Image(image: AssetImage(this.widget.image_url)),
                Text(
                  this.widget.category_name,
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
