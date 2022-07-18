enum MapQueryEnum { FORMAT, LANGUAGE, EXTRATAGS, NAMEDETAILS, LATITUDE, LONGITUDE }

extension MapQueryEnumString on MapQueryEnum {
  String get rawValue {
    switch (this) {
      case MapQueryEnum.FORMAT:
        return 'format';
      case MapQueryEnum.LANGUAGE:
        return 'accept-language';
      case MapQueryEnum.EXTRATAGS:
        return 'extratags';
      case MapQueryEnum.NAMEDETAILS:
        return 'namedetails';
      case MapQueryEnum.LATITUDE:
        return 'lat';
      case MapQueryEnum.LONGITUDE:
        return 'lon';
      default:
        throw Exception('Routes Not Found');
    }
  }
}