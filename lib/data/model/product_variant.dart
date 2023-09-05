import 'package:apple_shop/data/model/variant.dart';
import 'package:apple_shop/data/model/variant_type.dart';

class ProductVariants {
  VariantType variantType;
  List<Variant> variantList;

  ProductVariants(this.variantType, this.variantList);
}
