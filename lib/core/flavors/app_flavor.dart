import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum AppFlavor { dev, prod }

class AppFlavorConfig {
  const AppFlavorConfig({
    required this.flavor,
    required this.appName,
    required this.primaryColor,
    required this.bannerColor,
    required this.bannerName,
  });

  final AppFlavor flavor;
  final String appName;
  final Color primaryColor;
  final Color bannerColor;
  final String bannerName;

  bool get isDevelopment => flavor == AppFlavor.dev;

  static const dev = AppFlavorConfig(
    flavor: AppFlavor.dev,
    appName: 'VersaSaude Motorista Dev',
    primaryColor: Color(0xFFFF6B35),
    bannerColor: Color(0xFF8C2F00),
    bannerName: 'DEV',
  );

  static const prod = AppFlavorConfig(
    flavor: AppFlavor.prod,
    appName: 'VersaSaude Motorista',
    primaryColor: Colors.blueAccent,
    bannerColor: Colors.blueAccent,
    bannerName: 'PROD',
  );

  static AppFlavorConfig fromName(String? flavorName) {
    switch (flavorName) {
      case 'dev':
        return dev;
      case 'prod':
      case null:
        return prod;
      default:
        return prod;
    }
  }

  static AppFlavorConfig get current => fromName(appFlavor);
}
