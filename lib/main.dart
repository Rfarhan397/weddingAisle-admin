import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:wedding_admin/providers/action/action_provider.dart';
import 'package:wedding_admin/providers/auth/auth_provider.dart';
import 'package:wedding_admin/providers/cloudinary/cloudinary_provider.dart';
import 'package:wedding_admin/providers/meenuApp/menu_App_controller.dart';
import 'package:wedding_admin/providers/textColor/text_color_provider.dart';
import 'package:wedding_admin/providers/user/user_provider.dart';
import 'package:wedding_admin/providers/vendors/vendors_provider.dart';

import 'firebase_options.dart';
import 'model/res/routes/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  final Locale? initialLocale;
  const MyApp({super.key, this.initialLocale});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ActionProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => MenuAppController()),
        ChangeNotifierProvider(create: (_) => VendorsProvider()),
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => CloudinaryProvider()),
        ChangeNotifierProvider(create: (_) => TextColorProvider()),


      ],
      child: Sizer(builder: (context, orientation, deviceType) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          title: "WeddingAisle",
          routerConfig: Routes.router,
        );
      }),
    );
  }
}
