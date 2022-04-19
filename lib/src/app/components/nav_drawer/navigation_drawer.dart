import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:ipfrontend/src/app/components/nav_drawer/drawer_module.dart';
import 'package:ipfrontend/src/app/components/nav_drawer/drawer_item.dart';
import 'package:ipfrontend/src/app/models/user_model.dart';
import 'package:ipfrontend/src/app/providers/auth_provider.dart';
import 'package:ipfrontend/src/app/providers/nav_drawer_provider.dart';
import 'package:ipfrontend/src/app/router/route_names.dart';
import 'package:ipfrontend/src/app/services/navigation_service.dart';

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final navDrawerProvider = Provider.of<NavDrawerProvider>(context);

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          _getDrawerHeader(user: authProvider.user),
          ListTile(
            title: const Text('Home'),
            leading: const Icon(Icons.home),
            onTap: () {
              navDrawerProvider.setActiveBackButton(false);
              navigateTo(context, dashBoardRoute);
            },
          ),
          const SizedBox(height: 15),
          DrawerItem(
            title: 'Administración de Ventas',
            icon: Icons.system_update_outlined,
            navigationPath: dashBoardRoute,
            children: [
              NavBarItem(
                isActive: navDrawerProvider.routeCurrent == ventasRoute,
                title: "Ventas",
                navigationPath: ventasRoute,
                icon: Icons.sell_outlined,
                onPressed: () {
                  navDrawerProvider.setRouteCurrent(ventasRoute);
                  navigateTo(context, ventasRoute);
                },
              ),
            ],
          ),
          const SizedBox(height: 15),
          ListTile(
            title: const Text('Cerrar Sesión'),
            leading: const Icon(Icons.logout),
            onTap: () async {
              await Provider.of<AuthProvider>(context, listen: false).logout();
              NavDrawerProvider.scaffoldKey.currentState?.openEndDrawer();
              // navigateTo(context, loginRoute);
            },
          ),
        ],
      ),
    );
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

  navigateTo(BuildContext context, String nameRoute) {
    NavigationService.navigateTo(context, nameRoute, null);
    NavDrawerProvider.scaffoldKey.currentState?.openEndDrawer();
  }
}
