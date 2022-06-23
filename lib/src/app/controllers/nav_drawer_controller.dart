import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NavDrawerController extends GetxController {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  String _routeCurrent = '/';

  bool _activeBackButton = true;

  String get routeCurrent => _routeCurrent;

  bool get activeBackButton => _activeBackButton;

  setRouteCurrent(routeName) async {
    _routeCurrent = routeName;
    update();
  }

  setActiveBackButton(bool value) async {
    _activeBackButton = value;
    update();
  }
}
