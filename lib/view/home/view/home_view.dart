import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:piconmap/view/_product/enum/lottie_path_enum.dart';
import '../../../core/constants/image/image_constants.dart';
import '../../_product/_widgets/ads/baner_view.dart';
import '../../../core/constants/image/image_path_svg.dart';
import '../../_product/_widgets/loading/page_loading.dart';
import '../viewmodel/home_view_model.dart';
import '../../../core/init/network/dio_manager.dart';
import '../../../core/base/view/base_widget.dart';
import '../../../core/extension/context_extension.dart';
import '../service/home_service.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeView extends StatelessWidget {
  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

  HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<HomeViewModel>(
      viewModel: HomeViewModel(HomeService(DioManager.instance.networkManager, scaffoldMessengerKey)),
      onModelReady: (model) {
        model.setContext(context);
        model.init();
      },
      onPageBuilder: (BuildContext context, HomeViewModel viewModel) => ScaffoldMessenger(
        key: scaffoldMessengerKey,
        child: Scaffold(
          //appBar: BackAppBar(title: LocaleKeys.order_table_title),
          body: Column(
            children: [
              buildImagePicker(viewModel, context),
              buildInfo(context, viewModel),
              BannerView(anchoredBanner: viewModel.anchoredBanner),
            ],
          ),
        ),
      ),
    );
  }

  GestureDetector buildImagePicker(HomeViewModel viewModel, BuildContext context) {
    return GestureDetector(
      onTap: () async {
        viewModel.loadImage();
      },
      child: Container(
        width: context.width,
        height: 200,
        child: Card(
          color: Colors.white,
          elevation: 5,
          child: Observer(
            builder: (_) {
              return viewModel.image != null
                  ? Stack(
                    alignment: Alignment.topRight,
                    children: [
                      Center(
                        child: Image.file(
                            viewModel.image,
                            //width: 200.0,
                            height: context.height * 0.3,
                            fit: BoxFit.fitHeight,
                          ),
                      ),
                      IconButton(onPressed: (){ viewModel.closeImage(); }, icon: Icon(Icons.close))
                    ],
                  )
                  : Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        IconButton(
                            icon: LottiePathEnum.IMAGE_PICKER.toWidget,
                            iconSize: context.width * 0.5,
                            onPressed: null),
                        Padding(
                          padding: context.verticalPaddingNormal,
                          child: Text('Tap and Pick Image from Gallery',
                              style: context.textTheme.subtitle2?.copyWith(color: Colors.black54)),
                        ),
                      ],
                    );
            },
          ),
        ),
      ),
    );
  }

  Widget buildInfo(BuildContext context, HomeViewModel viewModel) {
    return Expanded(
      child: Container(
        color: Colors.transparent,
        width: context.width,
        //height: ((context.height * 0.7)-260),
        child: Observer(
          builder: (_) {
            return viewModel.isPageLoading
                ? PageLoading()
                : viewModel.info.isEmpty
                    ? buildWelcome(context)
                    : buildInfoListView(context, viewModel);
          },
        ),
      ),
    );
  }

  Widget buildWelcome(BuildContext context) => ListView(
        padding: EdgeInsets.zero,
        children: [
          buildHeaderText(context, 'PickOnMap Picture Location Viewer'),
          buildInfoText(
              context,
              'Can\'t remember the location where you took a picture with your camera or smartphone? '
              'Upload your photos and find out where they were taken. PicOnMap analyzes EXIF data embedded in the image to find'
              ' the GPS coordinates and location. The result would be a map view of your photo with detailed address '
              'and additional EXIF information if available.'),
        ],
      );

  Padding buildInfoText(BuildContext context, String text) {
    return Padding(
        padding: context.horizontalPaddingNormal,
        child: Text(
          text,
          style: context.textTheme.bodyText2?.copyWith(color: Colors.black),
          textAlign: TextAlign.justify,
        ));
  }

  ListView buildInfoListView(BuildContext context, HomeViewModel viewModel) {
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        buildHeaderText(context, 'Information'),
        buildLogical(context, viewModel),
        buildRow(context, SVGImagePaths.instance.cameraSVG, 'Camera', viewModel.info['camera']),
        buildRow(context, SVGImagePaths.instance.dateSVG, 'Date', viewModel.info['date']),
        buildRow(context, SVGImagePaths.instance.addressSVG, 'Address', viewModel.info['address']),
        buildRow(context, SVGImagePaths.instance.citySVG, 'City', viewModel.info['city_state']),
        buildRow(context, SVGImagePaths.instance.countrySVG, 'Country', viewModel.info['country']),
        buildRow(context, SVGImagePaths.instance.postcodeSVG, 'Post code', viewModel.info['postcode']),
        buildRow(context, SVGImagePaths.instance.coordinatesSVG, 'Coordinates', viewModel.info['coordinates']),
        buildRow(context, SVGImagePaths.instance.locationSVG, 'Location', viewModel.info['location']),
        buildRow(context, SVGImagePaths.instance.satelliteSVG, 'Lat Ref', viewModel.info['latref']),
        buildRow(context, SVGImagePaths.instance.satelliteSVG, 'Long Ref', viewModel.info['longref']),
        buildRow(context, SVGImagePaths.instance.locationSVG, 'Altitude', viewModel.info['altitude']),
        buildRow(context, SVGImagePaths.instance.fnumberSVG, 'F Number', viewModel.info['fnumber']),
        buildRow(context, SVGImagePaths.instance.isoSVG, 'ISO Speed', viewModel.info['isospeed']),
        buildRow(context, SVGImagePaths.instance.flashSVG, 'Flash', viewModel.info['flash']),
        buildRow(context, SVGImagePaths.instance.locationSVG, 'Focal Length', viewModel.info['focalLength']),
        //buildRow(context, SVGImagePaths.instance.locationSVG, 'Filename', viewModel.info['filename']),
        buildRow(context, SVGImagePaths.instance.resolutionSVG, 'Resolution', viewModel.info['resolution']),
        buildRow(context, SVGImagePaths.instance.sizeSVG, 'Size', viewModel.info['size']),
        buildRow(context, SVGImagePaths.instance.typeSVG, 'Type', viewModel.info['type']),
        //SizedBox(height: 60)
      ],
    );
  }

  Widget buildLogical(BuildContext context, HomeViewModel viewModel) {
    if (viewModel.isInternetAvailable) {
      if (viewModel.info['location'] != null && viewModel.info['location'].isNotEmpty) {
        return buildMap(context, viewModel, viewModel.info['location']);
      } else {
        return buildInfoText(
            context,
            'No GPS data was found in the image. PicOnMap requires unaltered photo files in order to process '
            'the data. Social networking sites like Facebook and Twitter strip out EXIF data with GPS information '
            'from uploaded photos.\n\n'
            'A camera with a built-in GPS or external GPS unit is required to automatically geotag '
            'your photos while you are shooting. If you are using a smartphone (Android, iPhone, etc.) to take '
            'your photos, location and geotagging services should be enabled.\n');
      }
    } else {
      return Container(
        padding: context.paddingLow,
        color: Colors.red,
        width: context.width,
        child: Center(
          child: Text(
            'The internet connection is not available for showing location information. '
            'Please connect to the internet and pick the image again.',
            style: context.textTheme.bodyText2?.copyWith(color: Colors.white),
            textAlign: TextAlign.start,
          ),
        ),
      );
    }
  }

  Widget buildMap(BuildContext context, HomeViewModel viewModel, String coordinates) => InkWell(
        onTap: () {
          viewModel.openMap(coordinates);
        },
        child: Container(
          color: Colors.black12,
          width: context.width,
          height: context.height * 0.1,
          child: Image(image: AssetImage(ImageConstants.instance.map), fit: BoxFit.cover),
        ),
      );

  Container buildHeaderText(BuildContext context, String title) {
    return Container(
      padding: context.verticalPaddingNormal,
      child: Text(title,
          style: context.appTheme.textTheme.headline6
              ?.copyWith(fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center),
    );
  }

  Widget buildRow(BuildContext context, String? imagePath, String title, String? info) {
    return (info != null && info.isNotEmpty)
        ? Card(
            child: Container(
              padding: context.paddingLow,
              //color: Colors.yellow,
              width: context.width,
              child: Row(
                children: [
                  (imagePath != null)
                      ? Container(
                          width: 32,
                          child: SvgPicture.asset(imagePath, width: 24, height: 24, alignment: Alignment.centerLeft),
                        )
                      : SizedBox(),
                  Expanded(
                    flex: 2,
                    child: Text(
                      title,
                      style: context.appTheme.textTheme.headline6?.copyWith(fontSize: 15),
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: Text(
                      info,
                      style: context.appTheme.textTheme.subtitle1?.copyWith(fontSize: 15),
                      maxLines: 3,
                    ),
                  ),
                ],
              ),
            ),
          )
        : SizedBox();
  }
}
