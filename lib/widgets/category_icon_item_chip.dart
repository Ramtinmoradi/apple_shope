import 'package:apple_shop/bloc/categoryProduct/category_product_bloc.dart';
import 'package:apple_shop/data/model/category.dart';
import 'package:apple_shop/screens/product_list_screen.dart';
import 'package:apple_shop/widgets/cached_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryIconItemChip extends StatelessWidget {
  final Category category;

  CategoryIconItemChip({required this.category, super.key});

  @override
  Widget build(BuildContext context) {
    String categoryColor = 'ff${category.color}';
    int hexColor = int.parse(categoryColor, radix: 16);
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => BlocProvider(
              create: (context) => CategoryProductBloc(),
              child: ProductListScreen(category: category),
            ),
          ),
        );
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Stack(
            alignment: AlignmentDirectional.center,
            children: <Widget>[
              Container(
                width: 56,
                height: 56,
                decoration: ShapeDecoration(
                  color: Color(hexColor),
                  shadows: [
                    BoxShadow(
                      color: Color(hexColor),
                      blurRadius: 25,
                      spreadRadius: -15,
                      offset: const Offset(0.0, 15),
                    ),
                  ],
                  shape: ContinuousRectangleBorder(
                    borderRadius: BorderRadius.circular(40),
                  ),
                ),
              ),
              SizedBox(
                width: 24,
                height: 24,
                child: Center(
                  child: CachedImage(
                    imageUrl: category.icon,
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Text(
              category.title,
              style: const TextStyle(
                fontFamily: 'SB',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
