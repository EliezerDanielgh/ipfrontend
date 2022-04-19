import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:ipfrontend/src/app/ui/shared/widgets/botton_usuario.dart';
import 'package:provider/provider.dart';
import 'package:ipfrontend/src/app/components/nav_drawer/navigation_drawer.dart';
import 'package:ipfrontend/src/app/providers/nav_drawer_provider.dart';

class DashBoardLayout extends StatefulWidget {
  const DashBoardLayout({Key? key, required this.child, this.convexAppBar})
      : super(key: key);
  final Widget child;
  final ConvexAppBar? convexAppBar;
  @override
  State<DashBoardLayout> createState() => _DashBoardLayoutState();
}

class _DashBoardLayoutState extends State<DashBoardLayout> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => NavDrawerProvider(),
      child: Overlay(
        initialEntries: [
          OverlayEntry(
            builder: (context) {
              return Scaffold(
                key: NavDrawerProvider.scaffoldKey,
                drawer: const NavigationDrawer(),
                appBar: AppBar(
                  // automaticallyImplyLeading: false,
                  elevation: 0,
                  backgroundColor: Theme.of(context).primaryColorDark,
                  title: Row(
                    children: [
                      const BottonUsuario(),
                      Expanded(child: Container()),
                      IconButton(
                        splashRadius: 20,
                        icon: const Icon(Icons.ac_unit_outlined),
                        onPressed: () {},
                      )
                    ],
                  ),
                ),
                backgroundColor: Colors.white,
                body: widget.child,
                bottomNavigationBar: widget.convexAppBar,
              );
            },
          ),
        ],
      ),
    );
  }
}
