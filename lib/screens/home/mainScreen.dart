import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wedding_admin/providers/action/action_provider.dart';
import 'package:wedding_admin/providers/meenuApp/menu_App_controller.dart';
import 'package:wedding_admin/screens/users/users_screen.dart';
import 'package:wedding_admin/screens/vendors/vendors_screen.dart';
import '../../model/res/widgets/navigationBar.dart';
import '../../vendorsRequest/vendors_request_screen.dart';
import '../banner/banner_screen.dart';
import '../place/placeScreen.dart';
import 'homeScreen.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final menuAppController = Provider.of<MenuAppController>(context);
    Widget screen;
    switch (menuAppController.selectedIndex) {
        case 0:
          screen = UserScreen();
          break;
        case 1:
          screen = VendorsScreen();
          break;
          case 2:
          screen = VendorsListingRequestScreen();
          break;
          case 3:
          screen = BannerScreen();
          break; case 4:
          screen = AddPlacesScreen();
          break;
      default:
          screen = HomeScreen();
          break;
    }
    return Scaffold(
      extendBody: true,
      drawer: CustomNavigationBar(),
      body: Stack(
        children: [
          Row(
            children: [
                const Expanded(
                  flex: 2,
                  child: CustomNavigationBar(),
                ),
              Expanded(
                flex: 10,
                child: screen,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
