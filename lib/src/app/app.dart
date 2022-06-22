import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ipfrontend/src/app/controllers/auth_controller.dart';
import 'package:ipfrontend/src/app/controllers/order_controller.dart';
import 'package:ipfrontend/src/app/router/pages.dart';
import 'package:ipfrontend/src/app/ui/layout/auth_layout.dart';
import 'package:ipfrontend/src/app/ui/layout/dashboard_layout.dart';
import 'package:ipfrontend/src/app/utils/preferences.dart';
import 'package:ipfrontend/src/app/utils/theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(AuthController());
    Get.put(OrderController());
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pedidos',
      theme: appThemeData,
      initialRoute: Routes.initial,
      getPages: AppPages.pages,
      builder: (context, child) {
        return GetBuilder<AuthController>(builder: (controller) {
          return (Preferences.getToken() == null ||
                  Get.currentRoute == Routes.login)
              ? AuthLayout(child: child!)
              : Overlay(
                  initialEntries: [
                    OverlayEntry(
                      builder: (context) => DashBoardLayout(child: child!),
                    )
                  ],
                );
        });
      },
    );
  }
}
