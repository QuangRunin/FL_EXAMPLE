// ignore_for_file: unnecessary_this

extension DateTimeEx on DateTime {
  /// Formats the DateTime object as a string based on the provided [format].
  ///
  /// Supported format tokens:
  /// - 'dd': Day of the month (01-31)
  /// - 'MM': Month (01-12)
  /// - 'MMM': Short month name (Jan-Dec)
  /// - 'MMMM': Full month name (January-December)
  /// - 'yyyy': Year
  /// - 'HH': Hour (00-23)
  /// - 'hh': Hour (01-12)
  /// - 'mm': Minute (00-59)
  /// - 'ss': Second (00-59)
  /// - 'a': AM/PM marker
  /// - 'EEE': Short day name (Mon-Sun)
  /// - 'EEEE': Full day name (Monday-Sunday)
  ///
  /// Example usage:
  /// DateTime now = DateTime.now();
  /// String formattedDate = now.format('dd/MM/yyyy');
  String format(String format) {
    final Map<String, String> shortMonths = {
      '01': 'Jan',
      '02': 'Feb',
      '03': 'Mar',
      '04': 'Apr',
      '05': 'May',
      '06': 'Jun',
      '07': 'Jul',
      '08': 'Aug',
      '09': 'Sep',
      '10': 'Oct',
      '11': 'Nov',
      '12': 'Dec'
    };

    final Map<String, String> fullMonths = {
      '01': 'January',
      '02': 'February',
      '03': 'March',
      '04': 'April',
      '05': 'May',
      '06': 'June',
      '07': 'July',
      '08': 'August',
      '09': 'September',
      '10': 'October',
      '11': 'November',
      '12': 'December'
    };

    final Map<String, String> shortDays = {
      '1': 'Mon',
      '2': 'Tue',
      '3': 'Wed',
      '4': 'Thu',
      '5': 'Fri',
      '6': 'Sat',
      '7': 'Sun'
    };

    final Map<String, String> fullDays = {
      '1': 'Monday',
      '2': 'Tuesday',
      '3': 'Wednesday',
      '4': 'Thursday',
      '5': 'Friday',
      '6': 'Saturday',
      '7': 'Sunday'
    };

    return format.replaceAllMapped(
      RegExp(r'(dd|MM|MMM|MMMM|yyyy|HH|hh|mm|ss|a|EEE|EEEE|[^\w])'),
      (Match m) {
        switch (m.group(0)) {
          case 'dd':
            return this.day.toString().padLeft(2, '0');
          case 'MM':
            return this.month.toString().padLeft(2, '0');
          case 'MMM':
            return shortMonths[this.month.toString().padLeft(2, '0')]!;
          case 'MMMM':
            return fullMonths[this.month.toString().padLeft(2, '0')]!;
          case 'yyyy':
            return this.year.toString();
          case 'HH':
            return this.hour.toString().padLeft(2, '0');
          case 'hh':
            final int hour = this.hour > 12 ? this.hour - 12 : this.hour;
            return hour.toString().padLeft(2, '0');
          case 'mm':
            return this.minute.toString().padLeft(2, '0');
          case 'ss':
            return this.second.toString().padLeft(2, '0');
          case 'a':
            return this.hour < 12 ? 'AM' : 'PM';
          case 'EEE':
            return shortDays[this.weekday.toString()]!;
          case 'EEEE':
            return fullDays[this.weekday.toString()]!;
          default:
            return m.group(0)!;
        }
      },
    );
  }

  /// Returns true if the DateTime object represents a date in the past.
  bool isPast() {
    return this.isBefore(DateTime.now());
  }

  /// Returns true if the DateTime object represents a date in the future.
  bool isFuture() {
    return this.isAfter(DateTime.now());
  }

  // String _formatUnit(int count, bool abbreviated, String unit) {
  //   final langCode = GetStorage().read<String?>(AppConst.langID);
  //   final String pluralUnit = abbreviated
  //       ? '${unit[0]}${unit[1]}'
  //       : '$unit${count != 1 && langCode == 'en' ? 's' : ''}';
  //   if (count == 1) {
  //     return '1 $pluralUnit';
  //   } else {
  //     return '$count $pluralUnit';
  //   }
  // }

  // /// Calculates the number of months between this date and the given [dateTime].
  // int _calculateMonths(DateTime now, DateTime dateTime) =>
  //     (now.year - dateTime.year) * 12 + now.month - dateTime.month;
}
