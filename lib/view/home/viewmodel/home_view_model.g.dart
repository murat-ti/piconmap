// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$HomeViewModel on HomeViewModelBase, Store {
  final _$imageAtom = Atom(name: 'HomeViewModelBase.image');

  @override
  dynamic get image {
    _$imageAtom.reportRead();
    return super.image;
  }

  @override
  set image(dynamic value) {
    _$imageAtom.reportWrite(value, super.image, () {
      super.image = value;
    });
  }

  final _$imagePickerAtom = Atom(name: 'HomeViewModelBase.imagePicker');

  @override
  ImagePicker get imagePicker {
    _$imagePickerAtom.reportRead();
    return super.imagePicker;
  }

  @override
  set imagePicker(ImagePicker value) {
    _$imagePickerAtom.reportWrite(value, super.imagePicker, () {
      super.imagePicker = value;
    });
  }

  final _$isPageLoadingAtom = Atom(name: 'HomeViewModelBase.isPageLoading');

  @override
  bool get isPageLoading {
    _$isPageLoadingAtom.reportRead();
    return super.isPageLoading;
  }

  @override
  set isPageLoading(bool value) {
    _$isPageLoadingAtom.reportWrite(value, super.isPageLoading, () {
      super.isPageLoading = value;
    });
  }

  final _$infoAtom = Atom(name: 'HomeViewModelBase.info');

  @override
  Map<dynamic, dynamic> get info {
    _$infoAtom.reportRead();
    return super.info;
  }

  @override
  set info(Map<dynamic, dynamic> value) {
    _$infoAtom.reportWrite(value, super.info, () {
      super.info = value;
    });
  }

  final _$isInternetAvailableAtom =
      Atom(name: 'HomeViewModelBase.isInternetAvailable');

  @override
  bool get isInternetAvailable {
    _$isInternetAvailableAtom.reportRead();
    return super.isInternetAvailable;
  }

  @override
  set isInternetAvailable(bool value) {
    _$isInternetAvailableAtom.reportWrite(value, super.isInternetAvailable, () {
      super.isInternetAvailable = value;
    });
  }

  final _$anchoredBannerAtom = Atom(name: 'HomeViewModelBase.anchoredBanner');

  @override
  BannerAd? get anchoredBanner {
    _$anchoredBannerAtom.reportRead();
    return super.anchoredBanner;
  }

  @override
  set anchoredBanner(BannerAd? value) {
    _$anchoredBannerAtom.reportWrite(value, super.anchoredBanner, () {
      super.anchoredBanner = value;
    });
  }

  final _$loadingAnchoredBannerAtom =
      Atom(name: 'HomeViewModelBase.loadingAnchoredBanner');

  @override
  bool get loadingAnchoredBanner {
    _$loadingAnchoredBannerAtom.reportRead();
    return super.loadingAnchoredBanner;
  }

  @override
  set loadingAnchoredBanner(bool value) {
    _$loadingAnchoredBannerAtom.reportWrite(value, super.loadingAnchoredBanner,
        () {
      super.loadingAnchoredBanner = value;
    });
  }

  final _$loadImageAsyncAction = AsyncAction('HomeViewModelBase.loadImage');

  @override
  Future<void> loadImage() {
    return _$loadImageAsyncAction.run(() => super.loadImage());
  }

  final _$closeImageAsyncAction = AsyncAction('HomeViewModelBase.closeImage');

  @override
  Future<void> closeImage() {
    return _$closeImageAsyncAction.run(() => super.closeImage());
  }

  final _$openMapAsyncAction = AsyncAction('HomeViewModelBase.openMap');

  @override
  Future<void> openMap(String coordinates) {
    return _$openMapAsyncAction.run(() => super.openMap(coordinates));
  }

  final _$HomeViewModelBaseActionController =
      ActionController(name: 'HomeViewModelBase');

  @override
  void _changeLoading() {
    final _$actionInfo = _$HomeViewModelBaseActionController.startAction(
        name: 'HomeViewModelBase._changeLoading');
    try {
      return super._changeLoading();
    } finally {
      _$HomeViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
image: ${image},
imagePicker: ${imagePicker},
isPageLoading: ${isPageLoading},
info: ${info},
isInternetAvailable: ${isInternetAvailable},
anchoredBanner: ${anchoredBanner},
loadingAnchoredBanner: ${loadingAnchoredBanner}
    ''';
  }
}
