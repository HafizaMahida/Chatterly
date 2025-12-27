import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AppConstants {
  AppConstants._();

  static const String appName = 'Chatterly';
  static const String accept = 'Accept';
  static const String headerAccept = 'application/json';
  static const String contentType = 'contentType';
  static const String headerContentType = 'application/json';
  static const String nullString = 'null';
  static const String emptyString = '{}';
  static const String error = 'error';
  static const String success = 'success';

  static const int maxEmailLength = 255;
  static const int maxPasswordLength = 15;
  static const int minPasswordLength = 8;


  /// Hide Keyboard
  static hideKeyboard(BuildContext context) {
    FocusScope.of(context).unfocus();
  }


  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  static AppConstants constant = AppConstants._();

  showLog(String str) {
    if (kDebugMode) {
      debugPrint('-> $str');
    }
  }

  /// Get only date from Datetime
  String getDate(DateTime? dateTime) {
    if (dateTime == null) return '';

    return '${dateTime.year}-'
        '${dateTime.month.toString().padLeft(2, '0')}-'
        '${dateTime.day.toString().padLeft(2, '0')}';
  }

  /// Format chat time
  String formatChatTime(DateTime? dateTime) {
    if (dateTime == null) return '';

    final now = DateTime.now();
    final diff = now.difference(dateTime);

    if (diff.inSeconds < 60) {
      return 'Now';
    }

    if (diff.inMinutes < 60) {
      return '${diff.inMinutes} min${diff.inMinutes > 1 ? 's' : ''}';
    }

    if (diff.inHours < 24) {
      return '${diff.inHours} hour${diff.inHours > 1 ? 's' : ''}';
    }

    if (diff.inDays == 1) {
      return 'Yesterday';
    }

    if (diff.inDays < 7) {
      return '${diff.inDays} days';
    }

    // Older than a week → show date
    return '${dateTime.day.toString().padLeft(2, '0')} '
        '${_monthName(dateTime.month)}';
  }

  /// Month name
  String _monthName(int month) {
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
    ];
    return months[month - 1];
  }


  /// Get Presence
  String getPresenceFromId(String? id) {
    if (id == null) return '';

    final createdTime =
    DateTime.fromMillisecondsSinceEpoch(int.parse(id));

    final diff = DateTime.now().difference(createdTime);

    if (diff.inMinutes < 5) {
      return 'Online';
    }
    return formatChatTime(createdTime);
  }

}