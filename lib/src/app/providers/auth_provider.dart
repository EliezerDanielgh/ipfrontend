import 'package:dio/dio.dart';
import 'package:ipfrontend/src/app/models/user_model.dart';
import 'package:ipfrontend/src/app/utils/apidio.dart';
import 'package:ipfrontend/src/app/utils/snackbar.dart';

class AuthProvider extends APIDio {
  Future login(Map<String, String> data) async {
    try {
      Response resp = await post('/token/', data);
      if (resp.statusCode == 200) {
        return resp.data;
      } else {
        errorHandler(resp);
      }
    } on DioError catch (e) {
      CustomSnackBar.error(
        message: e.response?.data["detail"],
      );
    }
  }

  Future<User?> currentUser() async {
    Response resp = await get('/security/user/current/');
    if (resp.statusCode == 200) {
      return User.fromMap(resp.data);
    } else {
      errorHandler(resp);
    }
    return null;
  }

  Future<User?> refreshToken() async {
    Response resp = await get('/token/refresh/');
    if (resp.statusCode == 200) {
      return User.fromJson(resp.data);
    } else {
      errorHandler(resp);
    }
    return null;
  }
}
