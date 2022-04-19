import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ipfrontend/src/app/ui/views/ventas_view.dart';
import 'package:provider/provider.dart';
// import 'package:ipfrontend/src/app/models/banner_model.dart';
// import 'package:ipfrontend/src/app/models/branch_office_model.dart';
// import 'package:ipfrontend/src/app/models/role_model.dart';
// import 'package:ipfrontend/src/app/models/user_model.dart';

import 'package:ipfrontend/src/app/providers/auth_provider.dart';
// import 'package:ipfrontend/src/app/providers/banner_provider.dart';
// import 'package:ipfrontend/src/app/providers/branch_office_provider.dart';
// import 'package:ipfrontend/src/app/providers/role_provider.dart';
// import 'package:ipfrontend/src/app/providers/user_provider.dart';
import 'package:ipfrontend/src/app/router/route_names.dart';
import 'package:ipfrontend/src/app/ui/layouts/auth/auth_layout.dart';
import 'package:ipfrontend/src/app/ui/layouts/dashboard/dashboard_layout.dart';
import 'package:ipfrontend/src/app/ui/layouts/splash/splash_layout.dart';
// import 'package:ipfrontend/src/app/ui/views/banner_view.dart';
// import 'package:ipfrontend/src/app/ui/views/banners_view.dart';
// import 'package:ipfrontend/src/app/ui/views/branch_office_view.dart';
// import 'package:ipfrontend/src/app/ui/views/branch_offices_view.dart';
// import 'package:ipfrontend/src/app/ui/views/clients_view.dart';
// import 'package:ipfrontend/src/app/ui/views/coverage_view.dart';
// import 'package:ipfrontend/src/app/ui/views/coverages_view.dart';
import 'package:ipfrontend/src/app/ui/views/home_view.dart';
import 'package:ipfrontend/src/app/ui/views/login_view.dart';
// import 'package:ipfrontend/src/app/ui/views/mark_view.dart';
// import 'package:ipfrontend/src/app/ui/views/marks_view.dart';
// import 'package:ipfrontend/src/app/ui/views/model_view.dart';
// import 'package:ipfrontend/src/app/ui/views/models_view.dart';
import 'package:ipfrontend/src/app/ui/views/not_found_view.dart';
// import 'package:ipfrontend/src/app/ui/views/plan_view.dart';
// import 'package:ipfrontend/src/app/ui/views/plans_view.dart';
// import 'package:ipfrontend/src/app/ui/views/premiums_view.dart';
// import 'package:ipfrontend/src/app/ui/views/role_view.dart';
// import 'package:ipfrontend/src/app/ui/views/roles_view.dart';
// import 'package:ipfrontend/src/app/ui/views/use_view.dart';
// import 'package:ipfrontend/src/app/ui/views/user_view.dart';
// import 'package:ipfrontend/src/app/ui/views/users_view.dart';
// import 'package:ipfrontend/src/app/ui/views/uses_view.dart';
// import 'package:ipfrontend/src/app/ui/views/vehicle_view.dart';
// import 'package:ipfrontend/src/app/ui/views/vehicles_view.dart';

// Código Go RouterGoRouter

class RouterGoRouter {
  static GoRouter generateRoute(BuildContext context) {
    AuthProvider auth = Provider.of<AuthProvider>(context, listen: false);
    return GoRouter(
      // debugLogDiagnostics: true,
      // initialLocation: '/banners',
      routes: [
        GoRoute(
          name: ventasRoute,
          path: '/$ventasRoute',
          pageBuilder: (context, state) => MaterialPage(
            key: state.pageKey,
            child: const VentasView(),
          ),
        ),
        GoRoute(
          name: rootRoute,
          path: rootRoute,
          pageBuilder: (context, state) => MaterialPage(
            key: state.pageKey,
            child: const HomeView(),
          ),
        ),
        GoRoute(
          name: loginRoute,
          path: '/$loginRoute',
          pageBuilder: (context, state) => MaterialPage(
            key: state.pageKey,
            child: const LoginView(),
          ),
        ),
        GoRoute(
          name: dashBoardRoute,
          path: '/$dashBoardRoute',
          pageBuilder: (context, state) => MaterialPage(
            key: state.pageKey,
            child: const HomeView(),
          ),
        ),

        // Models
        //   GoRoute(
        //     name: vehiclesRoute,
        //     path: '/$vehiclesRoute',
        //     pageBuilder: (context, state) => MaterialPage(
        //       key: state.pageKey,
        //       child: const VehiclesView(),
        //     ),
        //     routes: [
        //       GoRoute(
        //         name: vehicleRoute,
        //         path: vehicleRoute,
        //         pageBuilder: (context, state) {
        //           return MaterialPage(
        //             key: state.pageKey,
        //             child: VehicleView(),
        //           );
        //         },
        //       ), // new vehicle
        //       GoRoute(
        //         name: vehicleDetailRoute,
        //         path: '$vehiclesRoute/:id',
        //         pageBuilder: (context, state) {
        //           return MaterialPage(
        //             key: state.pageKey,
        //             child: VehicleView(uid: state.params['id'].toString()),
        //           );
        //         },
        //       ),
        //     ],
        //   ),
      ],
      navigatorBuilder: (context, child) {
        if (auth.loggedInStatus == Status.loggedIn) {
          return Builder(builder: (context) {
            return DashBoardLayout(child: child!);
          });
        }

        if (auth.loggedInStatus == Status.authenticating) {
          return const SplashLayout();
        }

        return AuthLayout(child: child!);
      },
      redirect: (state) {
        final loggingIn = state.location == '/$loginRoute';
        final notLogged = auth.loggedInStatus != Status.loggedIn &&
            auth.loggedInStatus != Status.authenticating;

        if (notLogged) {
          return loggingIn ? null : '/$loginRoute';
        }
        // if the user is logged in but still on the login page, send them to
        // the home page
        if (loggingIn) return '/$dashBoardRoute';

        // no need to redirect at all
        return null;
      },
      refreshListenable: auth,
      errorBuilder: (context, state) {
        return Center(
          child: NotFoundView(
            error: state.error.toString(),
          ),
        );
      },
    );
  }
}

// BannerRCV _getBannerRCV(BuildContext context, String uid) {
//   final bannerProvider = Provider.of<BannerRCVProvider>(context, listen: false);
//   final bannerMap = bannerProvider.banners
//       .where(
//         (b) => b['id'] == uid.toString(),
//       )
//       .first;
//   return BannerRCV.fromMap(bannerMap);
// }

// BranchOffice _getBranchOffice(BuildContext context, String uid) {
//   final branchOfficeMap =
//       Provider.of<BranchOfficeProvider>(context, listen: false)
//           .branchOffices
//           .where(
//             (b) => b['id'] == uid.toString(),
//           )
//           .first;
//   return BranchOffice.fromMap(branchOfficeMap);
// }

// Role _getRole(BuildContext context, String uid) {
//   final roleMap = Provider.of<RoleProvider>(context, listen: false)
//       .roles
//       .where(
//         (b) => b['id'].toString() == uid,
//       )
//       .first;
//   return Role.fromMap(roleMap);
// }

// User _getUser(BuildContext context, String uid) {
//   final userMap = Provider.of<UserProvider>(context, listen: false)
//       .users
//       .where(
//         (b) => b['id'] == uid.toString(),
//       )
//       .first;
//   return User.fromMap(userMap);
// }
