import 'package:flutter/material.dart';
import '../../init/navigation/navigation_service.dart';

abstract class BaseViewModel {
  BuildContext? context;

  NavigationService navigation = NavigationService.instance;

  void setContext(BuildContext context);
  void init();
}