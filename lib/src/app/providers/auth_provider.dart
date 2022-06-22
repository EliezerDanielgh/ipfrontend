import 'package:get/get.dart';
import 'package:ipfrontend/src/app/models/user_model.dart';
import 'package:ipfrontend/src/app/utils/api.dart';

class AuthProvider extends API {
  Future login(Map<String, String> data) async {
    Response resp = await post('/token/', data);
    if (resp.isOk) {
      return resp.body;
    } else {
      errorHandler(resp);
    }
  }

  Future<User?> currentUser() async {
    Response resp = await get('/security/user/current/');
    if (resp.isOk) {
      return User.fromMap(resp.body);
    } else {
      errorHandler(resp);
    }
    return null;
  }

  Future<User?> refreshToken() async {
    Response resp = await get('/token/refresh/');
    if (resp.isOk) {
      return User.fromJson(resp.body);
    } else {
      errorHandler(resp);
    }
    return null;
  }
}
