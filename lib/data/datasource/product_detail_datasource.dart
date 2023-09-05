import 'package:apple_shop/data/model/category.dart';
import 'package:apple_shop/data/model/product_image.dart';
import 'package:apple_shop/data/model/product_peroperty.dart';
import 'package:apple_shop/data/model/product_variant.dart';
import 'package:apple_shop/data/model/variant.dart';
import 'package:apple_shop/data/model/variant_type.dart';
import 'package:apple_shop/di.dart';
import 'package:apple_shop/util/api_exception.dart';
import 'package:dio/dio.dart';

abstract class IProductDetailDatasource {
  Future<List<ProductImage>> getGallery(String productId);
  Future<List<VariantType>> getVariantTypes();
  Future<List<Variant>> getVariants(String productId);
  Future<List<ProductVariants>> getProductVariants(String productId);
  Future<Category> getProductCategory(String categoryId);
  Future<List<Peroperty>> getProductPeroperties(String productId);
}

class ProductDetailRemoteDatasource extends IProductDetailDatasource {
  final Dio _dio = locator.get();

  @override
  Future<List<ProductImage>> getGallery(String productId) async {
    try {
      Map<String, String> queryParams = {
        'filter': 'product_id="$productId"',
      };
      var respones = await _dio.get(
        'collections/gallery/records',
        queryParameters: queryParams,
      );
      return respones.data['items']
          .map<ProductImage>((jsonObject) => ProductImage.fromJson(jsonObject))
          .toList();
    } on DioError catch (ex) {
      throw ApiException(ex.response?.statusCode, ex.response?.data['message']);
    } catch (ex) {
      throw ApiException(0, 'unknown erorr');
    }
  }

  @override
  Future<List<VariantType>> getVariantTypes() async {
    try {
      var respones = await _dio.get('collections/variants_type/records');
      return respones.data['items']
          .map<VariantType>((jsonObject) => VariantType.fromJson(jsonObject))
          .toList();
    } on DioError catch (ex) {
      throw ApiException(ex.response?.statusCode, ex.response?.data['message']);
    } catch (ex) {
      throw ApiException(0, 'unknown erorr');
    }
  }

  @override
  Future<List<Variant>> getVariants(String productId) async {
    try {
      Map<String, String> queryParams = {
        'filter': 'product_id="$productId"',
      };

      var respones = await _dio.get(
        'collections/variants/records',
        queryParameters: queryParams,
      );

      return respones.data['items']
          .map<Variant>((jsonObject) => Variant.fromJson(jsonObject))
          .toList();
    } on DioError catch (ex) {
      throw ApiException(ex.response?.statusCode, ex.response?.data['message']);
    } catch (ex) {
      throw ApiException(0, 'unknown erorr');
    }
  }

  @override
  Future<List<ProductVariants>> getProductVariants(String productId) async {
    var variantTypeList = await getVariantTypes();
    var variantList = await getVariants(productId);

    List<ProductVariants> productVariantList = [];

    try {
      for (var variantType in variantTypeList) {
        var productVariantLists = variantList
            .where((element) => element.typeId == variantType.id)
            .toList();

        productVariantList
            .add(ProductVariants(variantType, productVariantLists));
      }

      return productVariantList;
    } on DioError catch (ex) {
      throw ApiException(ex.response?.statusCode, ex.response?.data['message']);
    } catch (ex) {
      throw ApiException(0, 'unknown erorr');
    }
  }

  @override
  Future<Category> getProductCategory(String categoryId) async {
    try {
      Map<String, String> queryParams = {'filter': 'id="$categoryId"'};
      var response = await _dio.get(
        'collections/category/records',
        queryParameters: queryParams,
      );
      return Category.fromMapJson(response.data['items'][0]);
    } on DioError catch (ex) {
      throw ApiException(ex.response?.statusCode, ex.response?.data['message']);
    } catch (ex) {
      throw ApiException(0, 'unknown erorr');
    }
  }

  @override
  Future<List<Peroperty>> getProductPeroperties(String productId) async {
    try {
      Map<String, String> queryParams = {'filter': 'product_id="$productId"'};

      var response = await _dio.get(
        'collections/properties/records',
        queryParameters: queryParams,
      );

      return response.data['items']
          .map<Peroperty>((jsonObject) => Peroperty.fromJson(jsonObject))
          .toList();
    } on DioError catch (ex) {
      throw ApiException(ex.response?.statusCode, ex.response?.data['message']);
    } catch (ex) {
      throw ApiException(0, 'unknown erorr');
    }
  }
}
