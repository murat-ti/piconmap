import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

extension NetworkImageExtension on String {
  String get randomImage => 'https://picsum.photos/200/300';

  String get randomSquareImage => 'https://picsum.photos/200';

  String get customProfileImage => 'https://www.gravatar.com/avatar/?d=mp';

  String get customHighProfileImage => 'https://www.gravatar.com/avatar/?d=mp&s=200';
}

extension LaunchExtension on String {
  Future<bool> get launchEmail => launch('mailto:$this');

  Future<bool> get launchPhone => launch('tel:$this');

  Future<bool> get launchWebsite => (contains('http')) ? launch('$this') : launch('http://$this');

  Future<bool> get launchGoogleMap => launch('http://maps.google.com/?q=$this');
}

extension ParseDateExtension on String {
  String? dtFormat(var inType, var outType) {
    try {
      var datetime = DateFormat(inType).parse(this);
      return DateFormat(outType).format(datetime);
    } catch (er) {
      return '$this';
    }
  }
}
