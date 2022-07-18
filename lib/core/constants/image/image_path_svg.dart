class SVGImagePaths {
  static SVGImagePaths? _instance;
  static SVGImagePaths get instance {
    _instance ??= SVGImagePaths._init();
    return _instance!;
  }

  SVGImagePaths._init();

  String get cameraSVG => toSVG('camera');
  String get dateSVG => toSVG('clock');
  String get addressSVG => toSVG('home');
  String get citySVG => toSVG('skyline');
  String get countrySVG => toSVG('placeholder');
  String get coordinatesSVG => toSVG('germany');
  String get postcodeSVG => toSVG('postcode');
  String get isoSVG => toSVG('iso');
  String get fnumberSVG => toSVG('fnumber');
  String get flashSVG => toSVG('flash');
  String get focalLengthSVG => toSVG('focalLength');
  String get filenameSVG => toSVG('filename');
  String get resolutionSVG => toSVG('resolution');
  String get sizeSVG => toSVG('size');
  String get typeSVG => toSVG('type');
  String get locationSVG => toSVG('location');
  String get satelliteSVG => toSVG('satellite');
  String get altitudeSVG => toSVG('altitude');

  String toSVG(String name) => 'assets/svg/$name.svg';
}