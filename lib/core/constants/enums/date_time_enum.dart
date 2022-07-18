enum DateTimeType {
  NOT_PARSED_DATETIME,
  SERVER_DATETIME,
  LAST_MODIFY,
  HUMAN_DATE
}

extension DateTimeTypeExtension on DateTimeType {
  String get format {
    switch (this) {
      case DateTimeType.NOT_PARSED_DATETIME:
        return 'yyyy:MM:dd HH:mm:ss';
      case DateTimeType.SERVER_DATETIME:
        return 'yyyy-MM-dd HH:mm:ss';
      case DateTimeType.LAST_MODIFY:
        return 'EEE, d MMM yyyy HH:mm:ss Z';
      case DateTimeType.HUMAN_DATE:
        return 'EEEE, d MMMM yyyy';
      default:
        throw Exception('DateFormat Not Found');
    }
  }
}
