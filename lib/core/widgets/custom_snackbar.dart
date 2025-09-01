import 'package:flutter/material.dart';

import '../../core/utils/enums.dart';

class CustomSnackBar {
  static final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();

  static void show({
    required String message,
    required SnackBarStatus status,
    Duration? duration,
    Duration? animationDuration,
    EdgeInsets? margin,
    double? borderRadius,
    VoidCallback? onActionPressed,
    String? actionLabel,
  }) {
    final SnackBar snackBar = SnackBar(
      content: Text(
        message,
        style: const TextStyle(color: Colors.white, fontSize: 16),
      ),
      backgroundColor: status.color,
      duration: duration ?? Duration(seconds: 2),
      margin: margin ?? EdgeInsets.all(10),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          borderRadius ?? 15,
        ),
      ),
      action: actionLabel != null && onActionPressed != null
          ? SnackBarAction(
              label: actionLabel,
              textColor: Colors.white,
              onPressed: onActionPressed,
            )
          : null,
      animation: CurvedAnimation(
        curve: Curves.easeInOut,
        parent: const AlwaysStoppedAnimation(1),
      ),
    );

    scaffoldMessengerKey.currentState
      ?..removeCurrentSnackBar()
      ..showSnackBar(snackBar);
  }

  static void showSuccess(
    String message, {
    Duration? duration,
    VoidCallback? onActionPressed,
    String? actionLabel,
  }) {
    show(
      message: message,
      status: SnackBarStatus.success,
      duration: duration,
      onActionPressed: onActionPressed,
      actionLabel: actionLabel,
    );
  }

  static void showError(
    String message, {
    Duration? duration,
    VoidCallback? onActionPressed,
    String? actionLabel,
  }) {
    show(
      message: message,
      status: SnackBarStatus.error,
      duration: duration,
      onActionPressed: onActionPressed,
      actionLabel: actionLabel,
    );
  }
}