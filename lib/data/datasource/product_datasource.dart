import 'package:apple_shop/data/model/product.dart';
import 'package:apple_shop/di.dart';
import 'package:apple_shop/util/api_exception.dart';
import 'package:dio/dio.dart';

abstract class IProductDatasource {
  Future<List<Product>> getProducts();
  Future<List<Product>> getHottestProducts();
  Future<List<Product>> getBestSellerProducts();
}

class ProductRemoteDatasource extends IProductDatasource {
  final Dio _dio = locator.get();

  @override
  Future<List<Product>> getProducts() async {
    try {
      var respones = await _dio.get('collections/products/records');
      return respones.data['items']
          .map<Product>((jsonObject) => Product.fromJson(jsonObject))
          .toList();
    } on DioError catch (ex) {
      throw ApiException(ex.response?.statusCode, ex.response?.data['message']);
    } catch (ex) {
      throw ApiException(0, 'unknown erorr');
    }
  }

  @override
  Future<List<Product>> getHottestProducts() async {
    try {
      Map<String, String> queryParams = {
        'filter': 'popularity="Hotest"',
      };
      var respones = await _dio.get(
        'collections/products/records',
        queryParameters: queryParams,
      );
      return respones.data['items']
          .map<Product>((jsonObject) => Product.fromJson(jsonObject))
          .toList();
    } on DioError catch (ex) {
      throw ApiException(ex.response?.statusCode, ex.response?.data['message']);
    } catch (ex) {
      throw ApiException(0, 'unknown erorr');
    }
  }

  @override
  Future<List<Product>> getBestSellerProducts() async {
    try {
      Map<String, String> queryParams = {
        'filter': 'popularity="Best Seller"',
      };
      var respones = await _dio.get(
        'collections/products/records',
        queryParameters: queryParams,
      );
      return respones.data['items']
          .map<Product>((jsonObject) => Product.fromJson(jsonObject))
          .toList();
    } on DioError catch (ex) {
      throw ApiException(ex.response?.statusCode, ex.response?.data['message']);
    } catch (ex) {
      throw ApiException(0, 'unknown erorr');
    }
  }
}
