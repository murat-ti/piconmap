import '../../../core/constants/image/image_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../core/extension/context_extension.dart';
import '../../../core/base/view/base_widget.dart';
import '../viewmodel/splash_viewmodel.dart';

class SplashView extends StatelessWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<SplashViewModel>(
      viewModel: SplashViewModel(),
      onModelReady: (model) {
        model.setContext(context);
        model.init();
      },
      onPageBuilder: (BuildContext context, SplashViewModel viewModel) => Scaffold(
          backgroundColor: Colors.white,
          body: Container(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(75),
                  child: Image.asset(ImageConstants.instance.logo),
                ),
                SizedBox(height: 10),
                Text(
                  'PicOnMap',
                  style: context.appTheme.textTheme.headline6?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: context.appTheme.colorScheme.secondaryVariant,
                  ),
                ),
                Text(
                  'Picture Location Viewer',
                  style: context.appTheme.textTheme.caption?.copyWith(
                    fontWeight: FontWeight.w500,
                    color: context.appTheme.colorScheme.primary.withOpacity(0.5),
                  ),
                )
              ],
            ),
          )),
    );
  }

  Widget buildSvgPicture(BuildContext context, String path) =>
      SvgPicture.asset(path, color: context.appTheme.colorScheme.primaryVariant);
}
