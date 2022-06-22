import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ipfrontend/src/app/router/pages.dart';
import 'package:ipfrontend/src/app/utils/preferences.dart';

class AuthGuard extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    var token = Preferences.getToken();
    if (token == null) {
      return const RouteSettings(name: Routes.login);
    }
    if (route == Routes.login) {
      return const RouteSettings(name: Routes.home);
    }
    return null;
  }
}
