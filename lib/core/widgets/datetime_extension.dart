extension DateTimeExtension on DateTime {
  /// Check if date is today
  bool isToday() {
    final now = DateTime.now();
    return year == now.year && month == now.month && day == now.day;
  }

  /// Check if date is tomorrow
  bool isTomorrow() {
    final tomorrow = DateTime.now().add(const Duration(days: 1));
    return year == tomorrow.year &&
        month == tomorrow.month &&
        day == tomorrow.day;
  }

  /// Get formatted date string (yyyy-MM-dd)
  String toFormattedDate() {
    return '$year-${month.toString().padLeft(2, '0')}-${day.toString().padLeft(2, '0')}';
  }

  /// Get formatted date string (dd-MM-yyyy)
  String toDDMMYYYY() {
    return '${day.toString().padLeft(2, '0')}-${month.toString().padLeft(2, '0')}-$year';
  }

  /// Get formatted time string (HH:mm)
  String toFormattedTime() {
    return '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}';
  }

  /// Get formatted datetime string (yyyy-MM-dd HH:mm)
  String toFormattedDateTime() {
    return '${toFormattedDate()} ${toFormattedTime()}';
  }

  /// Get time difference in minutes
  int differenceInMinutes(DateTime other) {
    return difference(other).inMinutes;
  }

  /// Get time difference in hours
  int differenceInHours(DateTime other) {
    return difference(other).inHours;
  }

  /// Get time difference in days
  int differenceInDays(DateTime other) {
    return difference(other).inDays;
  }

  /// Get relative time string (e.g., "1 year, 2 months ago")
  String toRelativeTime() {
    final now = DateTime.now();
    if (isAfter(now)) return 'in the future';

    int years = now.year - year;
    int months = now.month - month;
    int days = now.day - day;

    if (days < 0) {
      months--;
      days += DateTime(now.year, now.month, 0).day;
    }

    if (months < 0) {
      years--;
      months += 12;
    }

    final parts = <String>[];
    if (years > 0) parts.add('$years year${years > 1 ? 's' : ''}');
    if (months > 0) parts.add('$months month${months > 1 ? 's' : ''}');
    if (days > 0 && years == 0) parts.add('$days day${days > 1 ? 's' : ''}');

    if (parts.isEmpty) {
      final diff = now.difference(this);
      if (diff.inHours > 0) {
        return '${diff.inHours} hour${diff.inHours > 1 ? 's' : ''} ago';
      }
      if (diff.inMinutes > 0) {
        return '${diff.inMinutes} minute${diff.inMinutes > 1 ? 's' : ''} ago';
      }
      return 'just now';
    }

    return '${parts.take(2).join(', ')} ago';
  }
}
