part of 'extensions.dart';

extension DurationX on int {
  Duration get inDuration => Duration(seconds: this);
}

extension XDateTimeExtension on DateTime {
  String get dayOfWeek => DateFormat('EEE').format(this);
  String get dayOfMonth => DateFormat('dd').format(this);
  String get fullMonthName => DateFormat('MMMM').format(this);
  String get year => DateFormat('y').format(this);

  String formatToWord({String? pattern, String locale = 'en'}) {
    return pattern == null
        ? DateFormat.yMMMMd().format(this)
        : DateFormat(pattern, locale).format(this);
  }

  String formatToWordWithTime() {
    return "${DateFormat("d MMM y").format(this)}, ${DateFormat.jm().format(this)}";
  }

  String toFormatDate([String pattern = 'dd/MM/yyyy', String? locale]) {
    if (locale != null && locale.isNotEmpty) {
      initializeDateFormatting(locale);
    }
    return DateFormat(pattern, locale).format(this);
  }

  String toFormatTime([String pattern = 'h:mm a', String? locale]) {
    if (locale != null && locale.isNotEmpty) {
      initializeDateFormatting(locale);
    }
    return DateFormat(pattern, locale).format(this);
  }

  String toFormatDividerDate([String pattern = 'dd-MM-yyyy', String? locale]) {
    if (locale != null && locale.isNotEmpty) {
      initializeDateFormatting(locale);
    }
    return DateFormat(pattern, locale).format(this);
  }
}

extension XDateString on String {
  DateTime? toDate() {
    try {
      final DateTime? st = DateTime.tryParse(this);
      return st;
      // ignore: unused_catch_clause
    } on FormatException catch (e) {
      return null;
    }
  }

  DateTime toDateTimeFormat([String format = 'dd/MM/yyyy']) {
    return DateFormat(format).parse(this);
  }

  DateTime fromStringToDateTimeFormat([String format = 'dd MMM yyyy hh:mm a']) {
    return DateFormat(format).parse(this);
  }
}

extension DateTimeExtension on DateTime {
  String get formattedDay => day.toString().padLeft(2, '0');

  String get weekdayName {
    switch (weekday) {
      case 1:
        return 'Mon';
      case 2:
        return 'Tue';
      case 3:
        return 'Wed';
      case 4:
        return 'Thu';
      case 5:
        return 'Fri';
      case 6:
        return 'Sat';
      case 7:
        return 'Sun';
      default:
        return '';
    }
  }

  String get monthName {
    return switch (month) {
      1 => 'Jan',
      2 => 'Feb',
      3 => 'Mar',
      4 => 'Apr',
      5 => 'May',
      6 => 'Jun',
      7 => 'Jul',
      8 => 'Aug',
      9 => 'Sep',
      10 => 'Oct',
      11 => 'Nov',
      12 => 'Dec',
      _ => throw ArgumentError('Invalid month: $month'),
    };
  }

  bool isSameDay(DateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }
}
