import 'package:flutter/material.dart';
import 'package:ipfrontend/src/app/utils/apidio.dart';
import 'package:ipfrontend/src/app/utils/preferences.dart';

import 'package:ipfrontend/src/app/app.dart';

Future<void> main() async {
  await Preferences.configurePrefs();
  APIDio.configureDio();
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
