enum OpenStreetMapRoutes { REVERSE }

extension OpenStreetMapRoutesString on OpenStreetMapRoutes {
  String get rawValue {
    switch (this) {
      case OpenStreetMapRoutes.REVERSE:
        return 'reverse';
      default:
        throw Exception('OpenStreetMap Routes Not Founf');
    }
  }
}