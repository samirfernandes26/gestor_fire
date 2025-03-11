import 'package:flutter/material.dart';

class AppNavigatorKey {
  static AppNavigatorKey? _instance;

  final navKey = GlobalKey<NavigatorState>();

  AppNavigatorKey._();

  static AppNavigatorKey get instance => _instance ??= AppNavigatorKey._();
}
