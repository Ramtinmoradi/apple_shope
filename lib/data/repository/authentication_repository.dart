import 'package:apple_shop/data/datasource/authentication_datasource.dart';
import 'package:apple_shop/di.dart';
import 'package:apple_shop/util/api_exception.dart';
import 'package:apple_shop/util/auth_manager.dart';
import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class IAuthRepository {
  Future<Either<String, String>> register(
    String username,
    String password,
    String passwordConfirm,
  );

  Future<Either<String, String>> login(String username, String password);
}

class AuthenticationRepository implements IAuthRepository {
  final IAuthenticationDataSource _datasource = locator.get();
  final SharedPreferences _sharedPref = locator.get();

  @override
  Future<Either<String, String>> register(
    String username,
    String password,
    String passwordConfirm,
  ) async {
    try {
      await _datasource.register('ramtinmoradi2', '12345678', '12345678');
      return right('ثبت نام انجام شد');
    } on ApiException catch (ex) {
      return left(ex.message ?? 'خطا محتوای متنی ندارد');
    }
  }

  @override
  Future<Either<String, String>> login(String username, String password) async {
    try {
      String token = await _datasource.login(username, password);
      if (token.isNotEmpty) {
        AuthManager.saveToken(token);
        return right('شما وارد شدید');
      } else {
        return left('خطایی در ورود پیش آمده است');
      }
    } on ApiException catch (ex) {
      return left('${ex.message}');
    }
  }
}
