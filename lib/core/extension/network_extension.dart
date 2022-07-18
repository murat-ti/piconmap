import '../constants/enums/request_type.dart';

extension NetworkTypeExtension on RequestType? {
  String get stringValue {
    switch (this) {
      case RequestType.GET:
        return 'GET';
      case RequestType.POST:
        return 'POST';
      case RequestType.DELETE:
        return 'DELETE';
      case RequestType.PUT:
        return 'PUT';
      case RequestType.DOWNLOAD:
        return 'DOWNLOAD';
      default:
        throw 'Method Not Found';
    }
  }
}