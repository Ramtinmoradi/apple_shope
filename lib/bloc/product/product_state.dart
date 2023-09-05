import 'package:apple_shop/data/model/category.dart';
import 'package:apple_shop/data/model/product_image.dart';
import 'package:apple_shop/data/model/product_peroperty.dart';
import 'package:apple_shop/data/model/product_variant.dart';
import 'package:dartz/dartz.dart';

abstract class ProductState {}

class ProductDetailInitState extends ProductState {}

class ProductDetailLoadingState extends ProductState {}

class ProductDetailResponseState extends ProductState {
  Either<String, List<ProductImage>> productImage;
  Either<String, List<ProductVariants>> productVariant;
  Either<String, Category> productCategory;
  Either<String, List<Peroperty>> productPeroperties;

  ProductDetailResponseState(
    this.productImage,
    this.productVariant,
    this.productCategory,
    this.productPeroperties,
  );
}
