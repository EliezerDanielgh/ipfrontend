import 'package:flutter/material.dart';
import 'package:ipfrontend/src/app/providers/order_provider.dart';
import 'package:provider/provider.dart';

import 'package:ipfrontend/src/app/providers/auth_provider.dart';
// import 'package:ipfrontend/src/app/providers/banner_provider.dart';
// import 'package:ipfrontend/src/app/providers/branch_office_provider.dart';
// import 'package:ipfrontend/src/app/providers/client_provider.dart';
// import 'package:ipfrontend/src/app/providers/coverage_provider.dart';
// import 'package:ipfrontend/src/app/providers/mark_provider.dart';
// import 'package:ipfrontend/src/app/providers/model_provider.dart';
// import 'package:ipfrontend/src/app/providers/plan_provider.dart';
// import 'package:ipfrontend/src/app/providers/premium_provider.dart';
// import 'package:ipfrontend/src/app/providers/role_provider.dart';
// import 'package:ipfrontend/src/app/providers/total_coverage_provider.dart';
// import 'package:ipfrontend/src/app/providers/use_provider.dart';
// import 'package:ipfrontend/src/app/providers/user_provider.dart';
// import 'package:ipfrontend/src/app/providers/vehicle_provider.dart';

import 'package:ipfrontend/src/app/utils/api.dart';
import 'package:ipfrontend/src/app/utils/preferences.dart';

import 'package:ipfrontend/src/app/app.dart';

Future<void> main() async {
  final prefs = await Preferences.configurePrefs();
  API.configureDio();
  // Flurorouter.configureRoute();
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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(lazy: false, create: (_) => AuthProvider()),
        ChangeNotifierProvider(lazy: false, create: (_) => OrderProvider())
      ],
      child: const MyApp(),
    );
  }
}
