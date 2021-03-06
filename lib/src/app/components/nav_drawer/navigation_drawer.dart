import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ipfrontend/src/app/controllers/auth_controller.dart';
import 'package:ipfrontend/src/app/controllers/covex_controller.dart';
import 'package:ipfrontend/src/app/controllers/nav_drawer_controller.dart';
import 'package:ipfrontend/src/app/models/user_model.dart';
import 'package:ipfrontend/src/app/router/pages.dart';
import 'package:ipfrontend/src/app/components/nav_drawer/drawer_module.dart';
import 'package:ipfrontend/src/app/components/nav_drawer/drawer_item.dart';

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    NavDrawerController navDrawerController = Get.find<NavDrawerController>();
    ConvexController convexController = Get.find<ConvexController>();
    return GetBuilder<AuthController>(builder: (controller) {
      return Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            GetX<AuthController>(
                builder: (controller) =>
                    _getDrawerHeader(user: controller.user.value)),
            NavBarItem(
              title: 'Home',
              navigationPath: Routes.home,
              icon: Icons.home,
              onPressed: () {
                navDrawerController.scaffoldKey.currentState?.openEndDrawer();
                Get.toNamed(Routes.home);
                convexController.index = 0;
              },
            ),
            const SizedBox(height: 15),
            DrawerItem(
              title: 'Administración de Ventas',
              icon: Icons.system_update_outlined,
              navigationPath: Routes.sales,
              children: [
                NavBarItem(
                  isActive: Get.currentRoute == Routes.sales,
                  title: "Ventas",
                  navigationPath: Routes.sales,
                  icon: Icons.sell_outlined,
                  onPressed: () {
                    navDrawerController.scaffoldKey.currentState
                        ?.openEndDrawer();
                    convexController.index = 1;
                    Get.toNamed(Routes.sales);
                  },
                ),
              ],
            ),
            const SizedBox(height: 15),
            ListTile(
              title: const Text('Cerrar Sesión'),
              leading: const Icon(Icons.logout),
              onTap: () async {
                controller.logout();
                // navigateTo(context, loginRoute);
              },
            ),
          ],
        ),
      );
    });
  }

  _getDrawerHeader({User? user}) {
    return UserAccountsDrawerHeader(
      accountName: Text(user!.name ?? ''),
      accountEmail: Text(user.email ?? ''),
      currentAccountPicture: Image.asset('assets/images/rc871.jpg'),
      otherAccountsPictures: [
        ClipOval(
          child: user.photo != null
              ? Image.network(user.photo!)
              : Image.asset('assets/images/img_avatar.png'),
        ),
      ],
      onDetailsPressed: () {},
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.green, Colors.yellow],
        ),
      ),
    );
  }
}
