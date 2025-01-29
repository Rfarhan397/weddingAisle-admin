import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../../constant.dart';
import '../constant/app_assets.dart';
import '../constant/app_colors.dart';
import '../constant/app_icons.dart';
import '../widgets/app_text.dart.dart';
import 'drawer_list_tile.dart';

class CustomNavigationBar extends StatelessWidget {
  const CustomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: primaryColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.zero, // Remove top-right corner rounding
          bottomRight: Radius.circular(0), // Ensure bottom-right is also not rounded
        ),
      ),
      child: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(width: 1.w),
                          Image.asset(
                            AppAssets.logoImage,
                            height: 80,
                          ),
                          // Icon(Icons.ac_unit_sharp,size: 60,),
                          SizedBox(width: 0.4.w),
                           const AppTextWidget(
                            text: 'Wedding Aisle',
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 3.h,),
                  ],
                ),
                const DrawerListTile(
                  index: 0,
                  screenIndex: 0,
                  title: "Users",
                  svgSrc: "assets/icons/users.svg",
                ),  const DrawerListTile(
                  index: 1,
                  screenIndex: 1,
                  title: "Vendors",
                  svgSrc: "assets/icons/users.svg",
                ),const DrawerListTile(
                  index: 2,
                  screenIndex: 2,
                  title: "Vendors Request",
                  svgSrc: "assets/icons/users.svg",
                ),
                const SizedBox(
                  height: defaultDrawerHeadHeight,
                ),
              ],
            ),
          ),

        ],
      ),
    );
  }


}
