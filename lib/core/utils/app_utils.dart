import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

SizedBox sh(double height) => SizedBox(height: height.h);
SizedBox sw(double width) => SizedBox(width: width.w);

String getFormattedThNumber(int num) {
  if (num <= 0) return '';
  if (num == 1) return 'st';
  if (num == 2) return 'nd';
  if (num == 3) return 'rd';
  if (num > 3) return 'th';
  return '';
}

String getFormatedDate(DateTime dateTime, {String? format}) {
  final DateFormat formatter = DateFormat(format ?? 'MMMd');
  final String formatted = formatter.format(dateTime);
  return formatted;
}

DateTime getTimeRemovedDate(DateTime dateTime) {
  return DateTime(dateTime.year, dateTime.month, dateTime.day);
}

DateTime getTomorrowDate() {
  DateTime kTomorrowDate = DateTime(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  ).add(
    const Duration(days: 1),
  );
  return kTomorrowDate;
}

DateTime getDefaultReminderDate({int hour = 18}) {
  DateTime kReminderDate = DateTime(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
    hour,
  );
  return kReminderDate;
}

bool isDateYesterday(DateTime? date) {
  if (date == null) return false;
  DateTime today = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
  DateTime comparedDate = DateTime(date.year, date.month, date.day);
  return today.subtract(const Duration(days: 1)).day == comparedDate.day;
}

bool isDateToday(DateTime? date) {
  if (date == null) return false;
  DateTime today = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
  DateTime comparedDate = DateTime(date.year, date.month, date.day);
  return today.day == comparedDate.day && today.month == comparedDate.month && today.year == comparedDate.year;
}

String formatSleepTime(int minutes) {
  int hours = (minutes ~/ 60) % 12;
  int mins = minutes % 60;
  String period = minutes < 720 ? "AM" : "PM"; // Before 720 min (12 PM) is AM
  if (hours == 0) hours = 12; // Convert 0 to 12 for AM/PM format
  return "${hours.toString().padLeft(2, '0')}:${mins.toString().padLeft(2, '0')} $period";
}

DateTime convertSleepMinutesToDateTime(int minutes) {
  DateTime now = DateTime.now();
  int hours = minutes ~/ 60;
  int mins = minutes % 60;
  return DateTime(now.year, now.month, now.day, hours, mins);
}

String getCurrencyFormatedStr(double amount) {
  String formattedAmount = NumberFormat.currency(locale: 'en_US', symbol: '').format(amount);
  return formattedAmount;
}

String formatTo12Hour(int hours, int minutes, {bool showTimeOnly = false, bool showPeriodOnly = false}) {
  // Validate input
  if (hours < 0 || hours > 23 || minutes < 0 || minutes > 59) {
    return '';
  }

  // Determine AM or PM
  String period = hours >= 12 ? 'PM' : 'AM';

  // Convert to 12-hour format
  int formattedHour = hours % 12;
  formattedHour = formattedHour == 0 ? 12 : formattedHour;

  // Format minutes with leading zero if needed
  String formattedMinutes = minutes.toString().padLeft(2, '0');

  return '${showPeriodOnly ? '' : '$formattedHour:$formattedMinutes'}${showTimeOnly ? '' : ' $period'}';
}
