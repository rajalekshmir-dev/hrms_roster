import 'package:flutter/material.dart';
import '../widgets/common_toast.dart';

class ToastService {
  static final ToastService _instance = ToastService._internal();
  factory ToastService() => _instance;
  ToastService._internal();

  static GlobalKey<ScaffoldMessengerState>? scaffoldMessengerKey;

  static void init(GlobalKey<ScaffoldMessengerState> key) {
    scaffoldMessengerKey = key;
  }

  static BuildContext? get _context => scaffoldMessengerKey?.currentContext;

  // Show success message
  static void success(String message, {Duration? duration}) {
    if (_context != null) {
      CommonToast.showSuccess(_context!, message: message, duration: duration ?? const Duration(seconds: 2));
    }
  }

  // Show error message
  static void error(String message, {Duration? duration}) {
    if (_context != null) {
      CommonToast.showError(_context!, message: message, duration: duration ?? const Duration(seconds: 3));
    }
  }

  // Show info message
  static void info(String message, {Duration? duration}) {
    if (_context != null) {
      CommonToast.showInfo(_context!, message: message, duration: duration ?? const Duration(seconds: 2));
    }
  }

  // Show warning message
  static void warning(String message, {Duration? duration}) {
    if (_context != null) {
      CommonToast.showWarning(_context!, message: message, duration: duration ?? const Duration(seconds: 3));
    }
  }
}