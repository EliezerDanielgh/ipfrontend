import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ipfrontend/src/app/components/nav_drawer/navigation_drawer.dart';
import 'package:ipfrontend/src/app/controllers/auth_controller.dart';
import 'package:ipfrontend/src/app/controllers/covex_controller.dart';
import 'package:ipfrontend/src/app/controllers/nav_drawer_controller.dart';
import 'package:ipfrontend/src/app/router/pages.dart';
import 'package:ipfrontend/src/app/ui/shared/widgets/botton_usuario.dart';

class DashBoardLayout extends StatefulWidget {
  const DashBoardLayout({Key? key, required this.child}) : super(key: key);
  final Widget child;
  @override
  State<DashBoardLayout> createState() => _DashBoardLayoutState();
}

class _DashBoardLayoutState extends State<DashBoardLayout> {
  @override
  Widget build(BuildContext context) {
    final authController = Get.find<AuthController>();
    NavDrawerController navDrawerController = Get.find<NavDrawerController>();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        key: navDrawerController.scaffoldKey,
        drawer: const NavigationDrawer(),
        appBar: AppBar(
          title: const BottonUsuario(),
          actions: [
            PopupMenuButton<int>(
              itemBuilder: (context) {
                return [
                  // popupmenu item 1
                  PopupMenuItem(
                    value: 1,
                    onTap: () {
                      authController.logout();
                    },
                    // row has two child icon and text.
                    child: Row(
                      children: const [
                        Icon(Icons.logout),
                        SizedBox(
                          // sized box with width 10
                          width: 10,
                        ),
                        Text("Cerrar sesión")
                      ],
                    ),
                  ),
                ];
              },
              offset: const Offset(0, 60),
              color: Colors.grey,
              elevation: 2,
            )
          ],
        ),
        backgroundColor: Colors.white,
        body: widget.child,
        bottomNavigationBar:
            GetBuilder<ConvexController>(builder: (controller) {
          return ConvexAppBar(
            backgroundColor: Theme.of(context).primaryColorDark,
            height: 45,
            elevation: 6,
            items: const [
              TabItem(icon: Icons.home, title: 'Home'),
              TabItem(icon: Icons.book, title: 'Ventas'),
              TabItem(icon: Icons.copy, title: 'Cuentas X Cobrar'),
              TabItem(icon: Icons.paid, title: 'Estadisticas'),
            ],
            initialActiveIndex: controller.index, //optional, default as 0
            onTap: (int i) {
              switch (i) {
                case 0:
                  Get.toNamed(Routes.home);
                  break;
                case 1:
                  Get.toNamed(Routes.sales);
                  break;
                case 2:
                  Get.toNamed(Routes.inventory);
                  break;
                case 3:
                  Get.toNamed(Routes.statistics);
                  break;
                default:
              }
            },
          );
        }),
      ),
    );
  }
}
