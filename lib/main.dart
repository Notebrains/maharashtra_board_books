import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:maharashtra_board_books/presentation/journeys/home_screen/home.dart';
import 'presentation/root_app.dart';

import 'common/constants/route_constants.dart';
import 'common/screenutil/screenutil.dart';
import 'presentation/fade_page_route_builder.dart';
import 'presentation/journeys/splash_screen/splash_screen.dart';
import 'presentation/routes.dart';
import 'presentation/themes/theme_color.dart';

/*
//This function will call if app run on background
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  //print("Handling a background message-messageId: ${message.messageId}");
  //print("Handling a background message-title: ${message.notification.title}");
}*/

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  MobileAds.instance.initialize();

  unawaited(SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]));


  //Change the color off app status bar
  //SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(statusBarColor: AppColor.notificationBar));

  //firebase init for notification

  //await Firebase.initializeApp();
  //FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  runApp(const RootApp());
}


class RootApp extends StatelessWidget {
  const RootApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Init.instance.initialize(),
      builder: (context, AsyncSnapshot snapshot) {
        // Show splash screen while waiting for app resources to load
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Splash(),
          );
        } else {
          ScreenUtil.init();
          // Loading is done, return the app:
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            initialRoute: RouteList.initial,
            onGenerateRoute: (RouteSettings settings) {
              final routes = Routes.getRoutes(settings);
              final WidgetBuilder? builder = routes[settings.name];
              return FadePageRouteBuilder(builder: builder!, settings: settings,);
            },

            theme: ThemeData(
              unselectedWidgetColor: AppColor.primaryColor,
              primaryColor: Colors.white,
              scaffoldBackgroundColor: Colors.white,
              brightness: Brightness.dark,
              cardTheme: const CardTheme(color: Colors.white,),
              visualDensity: VisualDensity.adaptivePlatformDensity,
              appBarTheme: const AppBarTheme(elevation: 0),
              colorScheme: ColorScheme.fromSwatch(brightness: Brightness.dark,).copyWith(secondary: AppColor.primaryColor),
              inputDecorationTheme: InputDecorationTheme(
                hintStyle: Theme.of(context).textTheme.bodyText1,
                focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.white,
                  ),
                ),
                enabledBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                ),
              ),
            ),
            home: const Home(),
          );
        }
      },
    );
  }
}

