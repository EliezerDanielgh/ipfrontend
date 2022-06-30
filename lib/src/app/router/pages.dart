import 'package:get/get.dart';
import 'package:ipfrontend/src/app/middlewares/auth_guard.dart';
import 'package:ipfrontend/src/app/ui/pages/home_page.dart';
import 'package:ipfrontend/src/app/ui/pages/login_page.dart';
import 'package:ipfrontend/src/app/ui/pages/splash_page.dart';
import 'package:ipfrontend/src/app/ui/pages/ventas_page.dart';
import 'package:ipfrontend/src/app/ui/pages/orders/module_view.dart';
part './routes.dart';

abstract class AppPages {
  static final pages = [
    GetPage(
      name: Routes.initial,
      middlewares: [
        AuthGuard(),
      ],
      page: () => const SplashPage(),
      children: [
        GetPage(
          name: Routes.home,
          page: () {
            return const MyHomePage(title: "Home");
          },
          transition: Transition.zoom,
        ),
        GetPage(
          name: Routes.accountsReceivable,
          page: () => const moduleOrders(),
          transition: Transition.zoom,
        ),
        GetPage(
          name: Routes.sales,
          page: () => const VentasPage(),
          transition: Transition.zoom,
        ),
        GetPage(
          name: Routes.statistics,
          page: () => const MyHomePage(title: "Estadisticas"),
          transition: Transition.zoom,
        ),
      ],
    ),
    GetPage(
      name: Routes.login,
      page: () => const LoginPage(),
      transition: Transition.zoom,
    ),
  ];
}
