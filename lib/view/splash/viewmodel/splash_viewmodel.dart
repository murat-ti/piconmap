import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import '../../../core/constants/navigation/navigation_constants.dart';
import '../../../core/base/model/base_view_model.dart';
part 'splash_viewmodel.g.dart';

class SplashViewModel = SplashViewModelBase with _$SplashViewModel;

abstract class SplashViewModelBase with Store, BaseViewModel {
  final _splashDelay = 2;

  @override
  void setContext(BuildContext context) => this.context = context;

  @override
  void init() {
    _loadWidget();
  }

  Future<Timer> _loadWidget() async {
    var _duration = Duration(seconds: _splashDelay);
    return Timer(_duration, loadHomeScreen);
  }

  Future<void> loadHomeScreen() async {
      await navigation.navigateToPageClear(path: NavigationConstants.HOME_VIEW);
  }
}