import 'package:apple_shop/data/datasource/authentication_datasource.dart';
import 'package:apple_shop/data/datasource/banner_datasource.dart';
import 'package:apple_shop/data/datasource/category_datasource.dart';
import 'package:apple_shop/data/datasource/category_product_datasource.dart';
import 'package:apple_shop/data/datasource/product_datasource.dart';
import 'package:apple_shop/data/datasource/product_detail_datasource.dart';
import 'package:apple_shop/data/repository/authentication_repository.dart';
import 'package:apple_shop/data/repository/banner_repository.dart';
import 'package:apple_shop/data/repository/category_product_repository.dart';
import 'package:apple_shop/data/repository/category_repository.dart';
import 'package:apple_shop/data/repository/product_detail_repository.dart';
import 'package:apple_shop/data/repository/product_repository.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

var locator = GetIt.instance;
Future<void> getItInit() async {
  //components
  locator.registerSingleton<Dio>(
    Dio(BaseOptions(baseUrl: 'http://startflutter.ir/api/')),
  );

  locator.registerSingleton<SharedPreferences>(
      await SharedPreferences.getInstance());
  //datasources
  locator
      .registerFactory<IAuthenticationDataSource>(() => AuthenticationRemote());
  locator
      .registerFactory<ICategoryDatasource>(() => CategoryRemoteDatasource());
  locator.registerFactory<IBannerDatasource>(() => BannerRemoteDatasource());
  locator.registerFactory<IProductDatasource>(() => ProductRemoteDatasource());
  locator.registerFactory<IProductDetailDatasource>(
      () => ProductDetailRemoteDatasource());
  locator.registerFactory<ICategoryProductDatasource>(
      () => CategoryProductRemoteDatasource());

  //repository
  locator.registerFactory<IAuthRepository>(() => AuthenticationRepository());
  locator.registerFactory<ICategoryRepository>(() => CategoryRepository());
  locator.registerFactory<IBannerRepository>(() => BannerRepository());
  locator.registerFactory<IProductRepository>(() => ProductRepository());
  locator.registerFactory<IProductDetailRepository>(
      () => ProductDetailRepository());
  locator.registerFactory<ICategoryProductRepository>(
      () => CategoryProductRepository());
}
