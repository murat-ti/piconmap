import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'core/constants/app/app_constants.dart';
import 'core/init/firebase/analytics_manager.dart';
import 'core/init/navigation/navigation_route.dart';
import 'core/init/navigation/navigation_service.dart';
import 'view/splash/view/splash_view.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: ApplicationConstants.APP_NAME,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: ApplicationConstants.FONT_FAMILY,
        primarySwatch: Colors.indigo,
      ),
      home: SplashView(),
      onGenerateRoute: NavigationRoute.instance.generateRoute,
      navigatorKey: NavigationService.instance.navigatorKey,
      navigatorObservers: [AnalyticsManager.instance.observer],
    );
  }
}