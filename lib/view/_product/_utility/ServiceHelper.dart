import 'package:flutter/material.dart';
import '../../../core/extension/context_extension.dart';
import '../../../core/constants/app/app_constants.dart';
import '../../../core/init/network/interface/IErrorModel.dart';

abstract class ServiceHelper {
  void showMessage(GlobalKey<ScaffoldMessengerState>? scaffoldKey, IErrorModel? errorModel) {
    if (scaffoldKey == null || errorModel == null) return;

    scaffoldKey.currentState?.showSnackBar(SnackBar(
      content: Text(
        errorModel.description ?? errorModel.statusCode.toString(),
        style: scaffoldKey.currentState!.context.textTheme.subtitle2!
            .copyWith(color: Colors.white),
      ),
      duration: Duration(seconds: ApplicationConstants.SNACKBAR_DURATION),
      backgroundColor: Colors.black,
    ));
  }
}
