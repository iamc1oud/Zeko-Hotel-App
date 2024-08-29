import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

Map<String, int> weekdayMap = {
  'MONDAY': DateTime.monday, // 1
  'TUESDAY': DateTime.tuesday, // 2
  'WEDNESDAY': DateTime.wednesday, // 3
  'THURSDAY': DateTime.thursday, // 4
  'FRIDAY': DateTime.friday, // 5
  'SATURDAY': DateTime.saturday, // 6
  'SUNDAY': DateTime.sunday // 7
};

extension DateParser on String {
  toDDMMYY() {
    var format = DateFormat.yMd().format(DateTime.parse(this));
    return format;
  }

  toYYYYMMDD() {
    var format = DateFormat('yyyy-MM-dd').format(DateTime.parse(this));
    return format;
  }

  to24Hr() {
    final v = DateFormat('HH:mm').format(DateTime.parse(this));
    return v;
  }

  to12HrSmall() {
    final v = DateFormat('hh:mm a').format(DateTime.parse(this));

    return v.replaceAll(' ', '').replaceAll('AM', 'a').replaceAll('PM', 'p');
  }

  DateTime toLocale() {
    try {
      final v = DateTime.parse(this).add(DateTime.now().timeZoneOffset);
      return v;
    } catch (e) {
      return DateTime.now();
    }
  }

  DateTime toDateTime() {
    try {
      final v = DateTime.parse(this);
      return v;
    } catch (e) {
      return DateTime.now();
    }
  }

  to12Hr([String? locale]) {
    try {
      final v = DateFormat('hh:mm a', locale?.toLowerCase())
          .format(DateTime.parse(this));
      return v;
    } catch (e) {
      return '';
    }
  }

  toEEEMMMddyyyy() {
    String? d = this;
    // ignore: unnecessary_null_comparison
    if (d == null) {
      return;
    }
    var format = DateFormat('EEE, MMM dd, yyyy').format(DateTime.parse(this));
    return format;
  }

  toddMMMyyyy() {
    try {
      String? d = this;
      // ignore: unnecessary_null_comparison
      if (d == null) {
        return;
      }
      var format = DateFormat('dd MMM, yyyy').format(DateTime.parse(this));

      return format;
    } catch (e) {
      return "";
    }
  }

  String forAPI() {
    String? d = this;
    if (d == null) {
      return 'No date passed';
    }

    var parser =
        DateFormat("yyyy-MM-dd'T'HH:mm:ss'Z").format(DateTime.parse(this));

    return parser;
  }

  String toCustom(String pattern) {
    var format = DateFormat(pattern).format(DateTime.parse(this));
    return format;
  }

  String formatDuration(int hour, int minutes) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String hours = twoDigits(hour);
    String minute = twoDigits(minutes % 60);

    return "$hours hrs $minute mins";
  }

  String formatIntervalDuration(int hour, int minutes) {
    String twoDigits(int n) => n.toString();
    String hours = twoDigits(hour);
    String minute = twoDigits(minutes % 60);

    if (minutes == 0) {
      return "${hours}h";
    } else {
      return "${hours}h ${minute}m";
    }
  }

  int weekday() {
    // Convert the input to uppercase to ensure it matches the map keys
    String upperDayName = this.toUpperCase();

    // Use the map to get the corresponding weekday number
    int? weekday = weekdayMap[upperDayName];

    if (weekday != null) {
      return weekday;
    } else {
      throw ArgumentError('Invalid day name: $this');
    }
  }
}

extension DateTimeExtension on DateTime {
  DateTime applied(TimeOfDay time) {
    return DateTime(year, month, day, time.hour, time.minute);
  }
}

String getLocaleTime(Either<String, DateTime> value) {
  return value.fold(
    (dateString) {
      try {
        // Try to parse the string into a DateTime object
        DateTime parsedDateTime = DateTime.parse(dateString);
        // Convert to local time
        DateTime localDateTime = parsedDateTime.toLocal();
        // Format the DateTime
        return localDateTime.toString();
      } catch (e) {
        return 'Error: Invalid date format';
      }
    },
    (dateTime) {
      // Convert to local time
      DateTime localDateTime = dateTime.toLocal();
      // Format the DateTime
      return localDateTime.toString();
    },
  );
}
