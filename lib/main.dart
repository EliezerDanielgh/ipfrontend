import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ipfrontend/src/app/controllers/auth_controller.dart';
import 'package:ipfrontend/src/app/controllers/covex_controller.dart';
import 'package:ipfrontend/src/app/controllers/nav_drawer_controller.dart';
import 'package:ipfrontend/src/app/utils/apidio.dart';
import 'package:ipfrontend/src/app/utils/preferences.dart';

import 'package:ipfrontend/src/app/app.dart';

Future<void> main() async {
  await Preferences.configurePrefs();
  APIDio.configureDio();
  Get.put(AuthController());
  Get.put(ConvexController());
  Get.put(NavDrawerController());
  runApp(const AppState());
}

class AppState extends StatefulWidget {
  const AppState({Key? key}) : super(key: key);

  @override
  _AppStateState createState() => _AppStateState();
}

class _AppStateState extends State<AppState> {
  @override
  Widget build(BuildContext context) {
    return const MyApp();
  }
}
