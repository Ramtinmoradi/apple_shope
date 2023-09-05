import 'package:apple_shop/data/model/banner.dart';
import 'package:apple_shop/di.dart';
import 'package:apple_shop/util/api_exception.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

abstract class IBannerDatasource {
  Future<List<BannerCampain>> getBanners();
}

class BannerRemoteDatasource extends IBannerDatasource {
  final Dio _dio = locator.get();
  @override
  Future<List<BannerCampain>> getBanners() async {
    try {
      var respones = await _dio.get('collections/banner/records');
      return respones.data['items']
          .map<BannerCampain>(
              (jsonObject) => BannerCampain.fromJson(jsonObject))
          .toList();
    } on DioError catch (ex) {
      throw ApiException(ex.response?.statusCode, ex.response?.data['message']);
    } catch (ex) {
      throw ApiException(0, 'unknown erorr');
    }
  }
}
