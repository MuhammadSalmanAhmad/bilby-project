import 'package:flutter/material.dart';
import 'package:save_the_bilby_fund/constants/colors.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:intl/intl.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:save_the_bilby_fund/features/authentications/screens/Category/category_screen.dart';

import '../features/authentications/controllers/session_controller.dart';

class CategoryCard extends StatefulWidget {
  late final String category_name;
  late final String image_url;
  int count = 1;

  CategoryCard(
      {super.key, required this.category_name, required this.image_url});

  @override
  State<CategoryCard> createState() => _CategoryCardState();
}

class _CategoryCardState extends State<CategoryCard> {

  final DatabaseReference ref = FirebaseDatabase.instance.ref('Users');
  //
  // int ImageCategorized = 1;
  // int rewardpoints = 1;


  bool isCritical = false;

  final DateTime now = DateTime.now();
  final DateFormat formater = DateFormat('dd-MM-yyyy');

  //REFERENCE TO USERS
  final DatabaseReference reference =
      FirebaseDatabase.instance.ref('Categorized_images');



  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: ref.child(SessionController().userid.toString()).onValue,
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            Map<dynamic, dynamic> map = snapshot.data.snapshot.value;

            int rewardP = map['RewardPoints'];
            int Cateimg = map['ImageCategorized'];

            return InkWell(
              onTapDown: ((details) {
                setState(() {

                  // this.widget.rewardpoints = this.widget.rewardpoints++;
                  // this.widget.ImageCategorized++;
                });
              }),
              splashColor: Color(0xff455A64),
              onTap: (() {

                if (this.widget.category_name == 'Bilby') {
                  isCritical = true;
                }


                ref.child(SessionController().userid.toString()).update({
                  'RewardPoints': rewardP+1,
                  'ImageCategorized': Cateimg+1,
                });
                // debugPrint(SessionController().userid.toString());




                reference.child(DateTime.now().microsecondsSinceEpoch.toString()).set({
                  'Category  : ': this.widget.category_name,
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
          else if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));}

          return Center(child: CircularProgressIndicator());
        }


    );
  }

}


