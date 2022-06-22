import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ipfrontend/src/app/controllers/auth_controller.dart';
import 'package:ipfrontend/src/app/models/user_model.dart';
import 'package:ipfrontend/src/app/router/pages.dart';
import 'package:ipfrontend/src/app/components/nav_drawer/drawer_module.dart';
import 'package:ipfrontend/src/app/components/nav_drawer/drawer_item.dart';
import 'package:ipfrontend/src/app/controllers/nav_drawer_controller.dart';

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(builder: (controller) {
      return Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            _getDrawerHeader(user: controller.user.value),
            ListTile(
              title: const Text('Home'),
              leading: const Icon(Icons.home),
              onTap: () {
                // navDrawerProvider.setActiveBackButton(false);
                Get.toNamed(Routes.home);
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
                NavDrawerController.scaffoldKey.currentState?.openEndDrawer();
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
