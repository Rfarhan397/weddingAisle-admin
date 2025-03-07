
import 'package:go_router/go_router.dart';
import 'package:wedding_admin/model/res/routes/routes_name.dart';
import 'package:wedding_admin/screens/vendors/vendors_screen.dart';

import '../../../screens/auth/login/login_screen.dart';
import '../../../screens/auth/splash/splash_screen.dart';
import '../../../screens/banner/addBannerScreen.dart';
import '../../../screens/banner/bannerDetailsScreen.dart';
import '../../../screens/error/error_screen.dart';
import '../../../screens/home/homeScreen.dart';
import '../../../screens/home/mainScreen.dart';
import '../../../screens/place/placeScreen.dart';
import '../../../screens/vendors/vendor_detail_screen.dart';
import '../../user/user_model.dart';


class Routes {
  static GoRouter router = GoRouter(
    initialLocation: RoutesName.splashScreen,
    routes: [
      GoRoute(
        path: RoutesName.splashScreen,
        builder: (context, state) => SplashScreen(),
      ),
      GoRoute(
        path: RoutesName.loginScreen,
        builder: (context, state) => LoginScreen(),
      ),
      GoRoute(
        path: RoutesName.mainScreen,
        builder: (context, state) => MainScreen(),
      ),
      GoRoute(
        path: RoutesName.homeScreen,
        builder: (context, state) => HomeScreen(),
      ),GoRoute(
        path: RoutesName.addBanner,
        builder: (context, state) => AddBannerScreen(),
      ),GoRoute(
        path: RoutesName.addPlace,
        builder: (context, state) => AddPlacesScreen(),
      ),
      GoRoute(
        path: RoutesName.vendorDetails,
        builder: (context, state) {
          final vendor = state.extra as Vendor;
          return VendorDetailsScreen(vendor: vendor);
        },
      ), GoRoute(
        path: RoutesName.bannerDetails,
        builder: (context, state) {
          final banner = state.extra as BannerModel;
          return BannerDetailsScreen(banner: banner);
        },
      ),

    ],
    errorBuilder: (context, state) =>
        ErrorScreen(error: state.error.toString()),
    debugLogDiagnostics: true,
  );
}
