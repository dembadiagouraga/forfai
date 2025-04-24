import 'package:intl/intl.dart';
import 'extensions.dart';
import 'helper.dart';
import 'tr_keys.dart';

abstract class TimeService {
  TimeService._();

  static final String _timeFormat =
      AppHelpers.getHourFormat24() ? 'HH:mm' : 'h:mm a';

  static String dateFormatAgo(DateTime? time) {
    final date = time?.difference(DateTime.now()) ?? const Duration();
    if (date.inDays < 0) {
      return dateFormatDMY(time);
    }
    return "${AppHelpers.getTranslation(TrKeys.today)} ${timeFormat(time)}";
    // final date = time?.difference(DateTime.now()) ?? const Duration();
    // if (date.inDays < -30) {
    //   return "${date.inDays.abs() ~/ 30} ${AppHelpers.getTranslation(TrKeys.monthAgo).toLowerCase()}";
    // }
    // if (date.inDays <= -7) {
    //   return "${date.inDays.abs() ~/ 7} ${AppHelpers.getTranslation(TrKeys.weekAgo).toLowerCase()}";
    // }
    // if (date.inDays < 0) {
    //   return "${date.inDays.abs()} ${AppHelpers.getTranslation(TrKeys.daysAgo).toLowerCase()}";
    // }
    // if (date.inDays < 0) {
    //   return "${AppHelpers.getTranslation(TrKeys.aDaysAgo).toLowerCase()}";
    // }
    // if (date.inHours < 0) {
    //   return "${date.inHours.abs()} ${AppHelpers.getTranslation(TrKeys.hoursAgo).toLowerCase()}";
    // }
    // if (date.inMinutes < 0) {
    //   return "${date.inMinutes.abs()} ${AppHelpers.getTranslation(TrKeys.minutesAgo).toLowerCase()}";
    // }
    // return AppHelpers.getTranslation(TrKeys.aFewSecondAgo);
  }

  static String dateFormatProduct(DateTime? time) {
    final date = time?.withoutTime.difference(DateTime.now().withoutTime) ??
        const Duration();
    if (date.inHours < -24) {
      return "${AppHelpers.getTranslation(TrKeys.posted)} ${dateFormatAgo(time)}";
    }
    if (date.inDays == -1) {
      return "${AppHelpers.getTranslation(TrKeys.posted)} ${AppHelpers.getTranslation(TrKeys.yesterday).toLowerCase()} ${AppHelpers.getTranslation(TrKeys.at).toLowerCase()} ${DateFormat(_timeFormat).format(time ?? DateTime.now())}";
    }
    return "${AppHelpers.getTranslation(TrKeys.posted)} ${AppHelpers.getTranslation(TrKeys.today).toLowerCase()} ${AppHelpers.getTranslation(TrKeys.at).toLowerCase()} ${DateFormat(_timeFormat).format(time ?? DateTime.now())}";
  }

  static String dateFormatSince(DateTime? time) {
    return DateFormat("MMM yyyy").format(time ?? DateTime.now());
  }

  static String dateFormatMonth(DateTime? time) {
    return DateFormat("MMMM").format(time ?? DateTime.now());
  }

  static DateTime dateFormatYMD(DateTime? time) {
    return DateTime.tryParse(
            DateFormat("yyyy-MM-dd").format(time ?? DateTime.now())) ??
        DateTime.now();
  }

  static String dateFormatMDYHm(DateTime? time) {
    return DateFormat("d MMM, yyyy - $_timeFormat").format(time ?? DateTime.now());
  }

  static String dateFormatDMYHm(DateTime? time) {
    return DateFormat("dd.MM.yyyy - $_timeFormat").format(time ?? DateTime.now());
  }

  static String dateFormatYMDHm(DateTime? time) {
    return DateFormat("yyyy-MM-dd $_timeFormat").format(time ?? DateTime.now());
  }

  static String dateFormatDMY(DateTime? time) {
    return DateFormat("d MMM, yyyy").format(time ?? DateTime.now());
  }

  static String dateFormatDM(DateTime? time) {
    if (DateTime.now().year == time?.year) {
      return DateFormat("d MMMM").format(time ?? DateTime.now());
    }
    return DateFormat("d MMMM, yyyy").format(time ?? DateTime.now());
  }

  static String dateFormatHM(DateTime? time) {
    return DateFormat(_timeFormat).format(time ?? DateTime.now());
  }

  static String dateFormatWDM(DateTime? time) {
    return DateFormat("EEE, d MMM").format(time ?? DateTime.now());
  }

  static String dateFormatForChat(DateTime? time) {
    final date = time?.withoutTime.difference(DateTime.now().withoutTime) ??
        const Duration();
    if (date.inHours > -24) {
      return DateFormat(_timeFormat).format(time ?? DateTime.now());
    }
    if (date.inDays > -7) {
      return DateFormat("EEEE").format(time ?? DateTime.now());
    }
    if (date.inDays <= -365) {
      return DateFormat("dd MMM").format(time ?? DateTime.now());
    }
    return DateFormat("dd MMM, yyyy").format(time ?? DateTime.now());
  }

  static String dateFormatForNotification(DateTime? time) {
    return DateFormat("d MMM, $_timeFormat").format(time ?? DateTime.now());
  }

  static String timeFormat(DateTime? time) {
    return DateFormat(_timeFormat).format(time ?? DateTime.now());
  }

  static String formatHHMMSS(int seconds) {
    seconds = (seconds % 3600).truncate();
    int minutes = (seconds / 60).truncate();
    String minutesStr = (minutes).toString().padLeft(2, '0');
    String secondsStr = (seconds % 60).toString().padLeft(2, '0');
    return "$minutesStr:$secondsStr";
  }
}
