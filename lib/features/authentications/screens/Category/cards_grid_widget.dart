import 'package:flutter/material.dart';
import 'package:save_the_bilby_fund/common_widgets/category_card.dart';
import 'package:save_the_bilby_fund/constants/image_strings.dart';

class CategoryList extends StatelessWidget {
  String image_url_;
   CategoryList({super.key, required this.image_url_});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 500,
      child: GridView.count(
        crossAxisCount: 2,
        primary: false,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        children: [
          CategoryCard(category_name: 'No Animal', image_url: other,URL_Image: image_url_,),
          CategoryCard(category_name: 'Cat', image_url: cat,URL_Image: image_url_,),
          CategoryCard(category_name: 'Dog', image_url: dog,URL_Image: image_url_,),
          CategoryCard(category_name: 'Fox', image_url: fox,URL_Image: image_url_,),
          CategoryCard(category_name: 'Bilby', image_url: bilby,URL_Image: image_url_,),
          CategoryCard(category_name: 'Pig', image_url: pig,URL_Image: image_url_,),
          CategoryCard(category_name: 'Cattle', image_url: cattle,URL_Image: image_url_,),
          CategoryCard(category_name: 'others', image_url: NoAnimal,URL_Image: image_url_,),
        ],
      ),
    );
  }
}
