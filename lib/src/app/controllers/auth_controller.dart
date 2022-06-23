import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ipfrontend/src/app/models/user_model.dart';
import 'package:ipfrontend/src/app/providers/auth_provider.dart';
import 'package:ipfrontend/src/app/utils/apidio.dart';
import 'package:ipfrontend/src/app/utils/preferences.dart';
import 'package:ipfrontend/src/app/utils/snackbar.dart';

import '../router/pages.dart';

enum Status { notLoggedIn, loggedIn, authenticating, loggedOut }

class AuthController extends GetxController {
  AuthProvider loginProvider = AuthProvider();
  final GlobalKey<FormState> formLoginKey = GlobalKey<FormState>();
  RxString username = "".obs;
  RxString password = "".obs;
  RxBool loading = false.obs;
  bool validateForm() => formLoginKey.currentState!.validate();
  Rx<Status> get loggedInStatus => Status.notLoggedIn.obs;

  Rx<User?> user = User().obs;

  Future<bool> isAuthenticated() async {
    final token = Preferences.getToken();
    if (token == null) {
      return false;
    }
    final resp = await loginProvider.currentUser();
    if (resp != null) {
      user.value = resp;
      return true;
    } else {
      return false;
    }
  }

  AuthController() {
    isAuthenticated();
  }

  doLogin() async {
    {
      if (loading.isFalse) {
        loading.value = true;
      }
      if (validateForm()) {
        var splitUsername = username.split("@");
        if (splitUsername.length > 1) {
          await Preferences.setSchema(splitUsername[1]);
          APIDio.configureDio();
          formLoginKey.currentState!.save();
          final resp = await loginProvider.login(
              {"username": splitUsername[0], "password": password.value});
          if (resp != null) {
            await Preferences.setToken(resp['token'], resp['refresh']);
            APIDio.configureDio();
            user.value = await loginProvider.currentUser();
            update();
            Get.offAllNamed(Routes.home);
          }
        } else {
          CustomSnackBar.error(message: 'Usuario invalido');
        }
        loading.value = false;
      } else {
        loading.value = false;
      }
    }
  }

  logout() {
    Preferences.removetoken();
    user.value = User();
    update();
    Get.offAndToNamed(Routes.login);
  }
}
