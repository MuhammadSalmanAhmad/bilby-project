import 'package:flutter/material.dart';
import 'package:save_the_bilby_fund/common_widgets/category_card.dart';
import 'package:save_the_bilby_fund/constants/image_strings.dart';

class CategoryList extends StatelessWidget {
  const CategoryList({super.key});

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
          CategoryCard(category_name: 'No Animal', image_url:other),
          CategoryCard(category_name: 'Cat', image_url:cat ),
          CategoryCard(category_name: 'Dog', image_url:dog ),
          CategoryCard(category_name: 'Fox', image_url:fox ),
          CategoryCard(category_name: 'Bilby', image_url: bilby),
          CategoryCard(category_name: 'Pig', image_url: pig),
          CategoryCard(category_name: 'Cattle', image_url:cattle ),
          CategoryCard(category_name: 'others', image_url: NoAnimal),
         
        ],
      ),
    );
  }
}
