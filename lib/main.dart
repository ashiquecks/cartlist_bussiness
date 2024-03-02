import 'package:cartlistmurchant/PROVIDER/confirmOrderProvider.dart';
import 'package:cartlistmurchant/PROVIDER/deliverOrderProvider.dart';
import 'package:cartlistmurchant/PROVIDER/orderProductProvider.dart';
import 'package:cartlistmurchant/PROVIDER/orderProvider.dart';
import 'package:cartlistmurchant/SCREEN/AUTHENTICATION/selectCategory.dart';
import 'package:cartlistmurchant/SCREEN/SPLASH/splashScreen.dart';
import 'package:cartlistmurchant/SCREEN/SPLASH/updateAppScree.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'PROVIDER/categoryProvider.dart';
import 'PROVIDER/registrationProvider.dart';
import 'SCREEN/AUTHENTICATION/loginStore.dart';
import 'SCREEN/AUTHENTICATION/registerStore.dart';
import 'SCREEN/AUTHENTICATION/userRegistration.dart';
import 'SCREEN/AUTHENTICATION/workingStatus.dart';
import 'SCREEN/HOME/homeNavigation.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CategoryProvider()),
        ChangeNotifierProvider(create: (context) => RegistrationProvider()),
        ChangeNotifierProvider(create: (context) => OrderProvider()),
        ChangeNotifierProvider(create: (context) => OrderProductProvider()),
        ChangeNotifierProvider(create: (context) => ConfirmOrderProvider()),
        ChangeNotifierProvider(create: (context) => DeliverOrderProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),
        initialRoute: '/splashScreen',
        routes: {
          '/splashScreen': (context) => const SplashScreen(),
          '/homeNavigation': (context) => const HomeNavigaton(),
          '/storeRegistration': (context) => const RegisterStore(),
          '/selectCategory': (context) => const selectcategory(),
          '/workingStatus': (context) => const WorkingStatus(),
          '/userRegistration': (context) => const UserRegistration(),
          '/storeLogin': (context) => const LoginStore(),
          '/updateApp': (context) => const UpdateApp(),
        },
      ),
    );
  }
}
