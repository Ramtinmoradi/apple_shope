import 'package:apple_shop/data/model/product.dart';
import 'package:apple_shop/di.dart';
import 'package:apple_shop/util/api_exception.dart';
import 'package:dio/dio.dart';

abstract class ICategoryProductDatasource {
  Future<List<Product>> getProductByCategoryId(String categoryId);
}

class CategoryProductRemoteDatasource extends ICategoryProductDatasource {
  final Dio _dio = locator.get();

  @override
  Future<List<Product>> getProductByCategoryId(String categoryId) async {
    try {
      Map<String, String> queryParams = {'filter': 'category="$categoryId"'};

      Response<dynamic> response;

      if (categoryId == '78q8w901e6iipuk') {
        response = await _dio.get('collections/products/records');
      } else {
        response = await _dio.get(
          'collections/products/records',
          queryParameters: queryParams,
        );
      }

      return response.data['items']
          .map<Product>((jsonObject) => Product.fromJson(jsonObject))
          .toList();
    } on DioError catch (ex) {
      throw ApiException(ex.response?.statusCode, ex.response?.data['message']);
    } catch (ex) {
      throw ApiException(0, 'unknown erorr');
    }
  }
}
