import 'dart:io';
import 'dart:math';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:mime/mime.dart';
import 'package:exif/exif.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../../core/constants/app/app_constants.dart';
import '../../_product/_network/_query/map_query.dart';
import '../service/IHomeService.dart';
import '../../../core/base/model/base_view_model.dart';
import 'package:mobx/mobx.dart';
import '../../../../core/constants/enums/date_time_enum.dart';
import '../../../../core/extension/string_extension.dart';

part 'home_view_model.g.dart';

class HomeViewModel = HomeViewModelBase with _$HomeViewModel;

abstract class HomeViewModelBase with Store, BaseViewModel {
  final IHomeService _service;

  @observable
  dynamic image = null;
  @observable
  ImagePicker imagePicker = new ImagePicker();
  @observable
  bool isPageLoading = false;
  @observable
  var info = {};
  @observable
  bool isInternetAvailable = true;
  @observable
  BannerAd? anchoredBanner;
  @observable
  bool loadingAnchoredBanner = false;

  HomeViewModelBase(this._service);

  @override
  void setContext(BuildContext context) => this.context = context;

  @override
  void init() {
    if (!loadingAnchoredBanner) {
      loadingAnchoredBanner = true;
      if(context != null) createAnchoredBanner(context!);
    }
  }

  @action
  Future<void> loadImage() async {
    info = {};
    XFile? galleryImage = await imagePicker.pickImage(source: ImageSource.gallery, imageQuality: 100);
    if (galleryImage != null) {
      image = File(galleryImage.path);
      var data = await readExifFromBytes(image.readAsBytesSync());
      //print(data);
      _changeLoading();

      info = {
        //'filename': (galleryImage.name.isNotEmpty) ? '${galleryImage.name}' : '',
        'resolution': (data.containsKey('Image ImageWidth') && data.containsKey('Image ImageLength')) ? '${data['Image ImageWidth']} x ${data['Image ImageLength']} px' : '',
        'size': (galleryImage.name.isNotEmpty) ? await getFileSize(1) : '',
        'type': (galleryImage.name.isNotEmpty) ? lookupMimeType(galleryImage.path) : '',
      };

      if (data.isEmpty) {
        print("No EXIF information found\n");
      }
      else {

        String camera = '';
        if (data.containsKey('Image Make')) camera += '${data['Image Make']} ';
        if (data.containsKey('Image Model')) camera += '${data['Image Model']}';

        var exifInfoData = {
          'date': data.containsKey('Image DateTime') ? data['Image DateTime'].toString().dtFormat(DateTimeType.NOT_PARSED_DATETIME.format, DateTimeType.HUMAN_DATE.format) : '',
          'camera': camera,
          'fnumber': data.containsKey('EXIF FNumber') ? 'f/${getFormulaResult(data['EXIF FNumber']).toStringAsFixed(1)}' : '',
          'isospeed': data.containsKey('EXIF ISOSpeedRatings') ? 'ISO ${data['EXIF ISOSpeedRatings']}' : '',
          'flash': data.containsKey('EXIF Flash') ? '${data['EXIF Flash']}' : '',
          'focalLength': data.containsKey('EXIF FocalLength') ? '${getFormulaResult(data['EXIF FocalLength']).toStringAsFixed(1)} mm' : '',
        };
        info.addAll(exifInfoData);

        if (data.containsKey('GPS GPSLatitude') && data.containsKey('GPS GPSLongitude')) {

          var latitude = getCoordinatesFromGps(data['GPS GPSLatitude']);
          var longitude = getCoordinatesFromGps(data['GPS GPSLongitude']);

          if(data.containsKey('GPS GPSLatitudeRef') && data['GPS GPSLatitudeRef'].toString().toUpperCase() == 'S') latitude *= -1.0;
          if(data.containsKey('GPS GPSLongitudeRef') && data['GPS GPSLongitudeRef'].toString().toUpperCase() == 'W') longitude *= -1.0;

          //print('Latitude => $latitude & Longitude => $longitude');
          if (latitude != 0 || longitude != 0) {
            //await getHttp(latitude, longitude * -1);

            try {
              //print('Dio geldi');
              //var response = await Dio().get('https://nominatim.openstreetmap.org/reverse?format=json&addressdetails=1&accept-language=en&extratags=0&namedetails=0&lat=$latitude&lon=$longitude');
              //print(response.data);
              MapQuery query = MapQuery(
                  format: 'json',
                  language: 'en',
                  extraTags: 0,
                  nameDetails: 0,
                  latitude: latitude.toString(),
                  longitude: longitude.toString());

              var gpsData = await _service.fetchLocation(query);
              if (gpsData != null && gpsData.address != null) {
                //print(data);
                String address = '';
                isInternetAvailable = true;
                if (gpsData.address!.houseNumber != null) address += '${gpsData.address!.houseNumber!}, ';
                if (gpsData.address!.road != null) address += '${gpsData.address!.road!}, ';
                if (gpsData.address!.neighbourhood != null) address += '${gpsData.address!.neighbourhood!}';

                String city_state = '';
                if (gpsData.address!.city != null) city_state += '${gpsData.address!.city!} / ';
                if (gpsData.address!.state != null) city_state += '${gpsData.address!.state!}';

                String location = '';
                if(latitude != 0.0 && longitude != 0.0) location = '${latitude.toStringAsFixed(6)}, ${longitude.toStringAsFixed(6)}';

                var gpsInfoData = {
                  'address': address,
                  'city_state': city_state,
                  'country': gpsData.address!.country ?? '',
                  'postcode': gpsData.address!.postcode ?? '',
                  'location': location,
                  'latref': data.containsKey('GPS GPSLatitudeRef') ? '${getLocationFullName(data['GPS GPSLatitudeRef'].toString())}' : '',
                  'longref': data.containsKey('GPS GPSLongitudeRef') ? '${getLocationFullName(data['GPS GPSLongitudeRef'].toString())}' : '',
                  'coordinates': (data.containsKey('GPS GPSLatitude') &&
                      data.containsKey('GPS GPSLatitudeRef') &&
                      data.containsKey('GPS GPSLongitude') &&
                      data.containsKey('GPS GPSLongitudeRef'))
                      ? '${getLocationsFromGps(
                      data['GPS GPSLatitude'], data['GPS GPSLatitudeRef'])}, ${getLocationsFromGps(
                      data['GPS GPSLongitude'], data['GPS GPSLongitudeRef'])}'
                      : '',
                  'altitude': data.containsKey('GPS GPSAltitude') ? '${getFormulaResult(data['GPS GPSAltitude']).toStringAsFixed(2)}m. (Above Sea Level)' : '',
                };
                info.addAll(gpsInfoData);
              }
              else
                isInternetAvailable = false;

            } catch (e) {
              print(e);
            }
          }
        }
      }

      info.forEach((k,v) => info[k] = v.toString());
      _changeLoading();
    }
  }

  @action
  Future<void> closeImage() async {
    info = {};
    image = null;
  }

  @action
  Future<void> openMap(String coordinates) async {
    await coordinates.launchGoogleMap;
  }

  Future<void> createAnchoredBanner(BuildContext context) async {
    final size = await AdSize.getAnchoredAdaptiveBannerAdSize(
      Orientation.portrait,
      MediaQuery.of(context).size.width.truncate(),
    );

    if (size == null) {
      print('Unable to get height of anchored banner.');
      return;
    }

    final banner = BannerAd(
      size: size,
      request: AdRequest(),
      adUnitId: Platform.isAndroid
          ? ApplicationConstants.ADMOB_ANDROID
          : ApplicationConstants.ADMOB_IOS,
      listener: BannerAdListener(
        onAdLoaded: (Ad ad) {
          print('$BannerAd loaded.');
          anchoredBanner = ad as BannerAd?;
        },
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          print('$BannerAd failedToLoad: $error');
          ad.dispose();
        },
        onAdOpened: (Ad ad) => print('$BannerAd onAdOpened.'),
        onAdClosed: (Ad ad) => print('$BannerAd onAdClosed.'),
      ),
    );
    return banner.load();
  }

  double getCoordinatesFromGps(var data) {
    var coordinates = 0.0;
    var gpsInfo = data?.values.toList();
    if (gpsInfo != null) {
      try {
        coordinates += double.parse(gpsInfo[0].toString());
        if (double.parse(gpsInfo[1].toString()) > 0) {
          coordinates += (double.parse(gpsInfo[1].toString()) / 60);
        }
        var result = getFormulaResult(gpsInfo[2]);//gpsInfo[2].toString().split('/');
        coordinates += (result / 3600);
      } catch (e) {
        //print('Coordinate parse problem');
        coordinates = 0.0;
      }
      //print('Lat: ${coordinates.toStringAsFixed(6)}');
    }

    return coordinates;
  }

  double getFormulaResult(var data) {
    var parts = data.toString().split('/');
    if(parts.length == 2 && double.parse(parts[1]) != 0.0) return double.parse(parts[0]) / double.parse(parts[1]);
    else return 0.0;
  }

  String getLocationsFromGps(var data, var direction) {
    var coordinates = '';
    var gpsInfo = data?.values.toList();
    if (gpsInfo != null) {
      try {
        coordinates += '${gpsInfo[0].toString()}° ';
        if (gpsInfo[1]
            .toString()
            .isNotEmpty) {
          coordinates += '${gpsInfo[1].toString()}\' ';
        }
        var gpsInfoParts = gpsInfo[2].toString().split('/');
        double result = (double.parse(gpsInfoParts[0]) / double.parse(gpsInfoParts[1]));
        coordinates += '${result.toStringAsFixed(2)}" $direction';
      } catch (e) {
        print('Coordinate parse problem');
        coordinates = '';
      }
      //print('Lat: ${coordinates.toStringAsFixed(6)}');
    }

    return coordinates;
  }

  Future<String> getFileSize(int decimals) async {
    //var file = File(filepath);
    int bytes = await image.length();
    if (bytes <= 0) return "0 B";
    const suffixes = ["B", "KB", "MB", "GB", "TB", "PB", "EB", "ZB", "YB"];
    var i = (log(bytes) / log(1024)).floor();
    return ((bytes / pow(1024, i)).toStringAsFixed(decimals)) + ' ' + suffixes[i];
  }

  String getLocationFullName(String title) {
    switch(title.toUpperCase()) {
      case 'N': return 'North';
      case 'S': return 'South';
      case 'W': return 'West';
      case 'E': return 'East';
    }
    return title;
  }

  @action
  void _changeLoading() {
    isPageLoading = !isPageLoading;
  }
}
