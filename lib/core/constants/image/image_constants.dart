class ImageConstants {
  static ImageConstants? _instance;
  static ImageConstants get instance {
    _instance ??= ImageConstants._init();
    return _instance!;
  }

  ImageConstants._init();

  String get logo => toPng('logo');
  String get map => toPng('map');

  String toPng(String name) => 'assets/png/$name.png';
}