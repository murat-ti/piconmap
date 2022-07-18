import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../../../view/home/view/home_view.dart';
import '../../constants/navigation/navigation_constants.dart';
import '../../components/card/not_found_navigation_widget.dart';

class NavigationRoute {
  static final NavigationRoute _instance = NavigationRoute._init();

  static NavigationRoute get instance => _instance;

  NavigationRoute._init();

  Route<dynamic> generateRoute(RouteSettings args) {
    switch (args.name) {
      case NavigationConstants.HOME_VIEW:
        return normalNavigate(HomeView(), RouteSettings(name: NavigationConstants.HOME_VIEW));
      default:
        return normalNavigate(NotFoundNavigationWidget(), RouteSettings(name: 'Not found'));
    }
  }

  MaterialPageRoute normalNavigate(Widget widget, RouteSettings settings) {
    return MaterialPageRoute(builder: (context) => widget, settings: settings);
  }
}
