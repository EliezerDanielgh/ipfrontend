import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NavDrawerController extends GetxController {
  static GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  String _routeCurrent = '/';

  static bool _activeBackButton = true;

  String get routeCurrent => _routeCurrent;

  static bool get activeBackButton => _activeBackButton;

  setRouteCurrent(routeName) async {
    _routeCurrent = routeName;
    await Future.delayed(const Duration(milliseconds: 200));
    update();
  }

  setActiveBackButton(bool value) async {
    _activeBackButton = value;
    await Future.delayed(const Duration(milliseconds: 200));
    update();
  }
}
