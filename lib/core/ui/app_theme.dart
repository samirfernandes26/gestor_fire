import 'package:flutter/material.dart';
import 'package:gestor_fire/core/flavors/app_flavor.dart';

sealed class AppTheme {
  static const _erroTextStyle = TextStyle(fontSize: 14);
  static const _defaultHintStyle = TextStyle(fontSize: 16);

  static ThemeData light(AppFlavorConfig flavor) {
    final primaryColor = flavor.primaryColor;
    final borderColor = _darken(primaryColor, amount: 0.12);
    final labelStyle = _labelStyle(primaryColor);
    final inputBorder = _inputBorder(borderColor);
    final inputDecorationTheme = _inputDecorationTheme(
      primaryColor: primaryColor,
      labelStyle: labelStyle,
      inputBorder: inputBorder,
    );

    return ThemeData.light(useMaterial3: true).copyWith(
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryColor,
        surface: Colors.grey.shade100,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: primaryColor,
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
        shadowColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      scaffoldBackgroundColor: primaryColor,
      inputDecorationTheme: inputDecorationTheme,
      elevatedButtonTheme: _elevatedButtonThemeData(primaryColor),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
      ),
      cardTheme: const CardThemeData(color: Colors.white),
      bottomSheetTheme: BottomSheetThemeData(
        dragHandleColor: Colors.grey.shade500,
        backgroundColor: Colors.white,
      ),
      datePickerTheme: DatePickerThemeData(
        todayBackgroundColor: WidgetStateProperty.all<Color>(primaryColor),
      ),
    );
  }

  static ThemeData dark(AppFlavorConfig flavor) {
    final primaryColor = flavor.primaryColor;
    final borderColor = _darken(primaryColor, amount: 0.12);
    final labelStyle = _labelStyle(primaryColor);
    final inputBorder = _inputBorder(borderColor);
    final inputDecorationTheme = _inputDecorationTheme(
      primaryColor: primaryColor,
      labelStyle: labelStyle,
      inputBorder: inputBorder,
    );

    return ThemeData.dark(useMaterial3: true).copyWith(
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryColor,
        brightness: Brightness.dark,
        surface: Colors.grey.shade800,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.grey.shade800,
        titleTextStyle: TextStyle(
          color: Colors.grey.shade100,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
        iconTheme: IconThemeData(color: Colors.grey.shade100),
      ),
      shadowColor: Colors.transparent,
      scaffoldBackgroundColor: Colors.grey.shade900,
      inputDecorationTheme: inputDecorationTheme.copyWith(
        fillColor: Colors.grey.shade700,
        outlineBorder: inputDecorationTheme.outlineBorder?.copyWith(
          color: Colors.transparent,
        ),
        enabledBorder: inputDecorationTheme.enabledBorder?.copyWith(
          borderSide: inputBorder.borderSide.copyWith(color: Colors.transparent),
        ),
        labelStyle: labelStyle.copyWith(color: Colors.grey.shade400),
        prefixIconColor: Colors.grey.shade400,
        suffixIconColor: Colors.grey.shade400,
      ),
      elevatedButtonTheme: _elevatedButtonThemeData(primaryColor),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
      ),
      cardTheme: CardThemeData(color: Colors.grey.shade800),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: Colors.grey.shade800,
        dragHandleColor: Colors.grey.shade500,
      ),
      datePickerTheme: DatePickerThemeData(
        backgroundColor: Colors.grey.shade900,
        surfaceTintColor: Colors.grey.shade900,
        headerForegroundColor: Colors.white,
        weekdayStyle: const TextStyle(color: Colors.white),
        dayStyle: const TextStyle(color: Colors.white),
        headerHelpStyle: const TextStyle(color: Colors.white),
        headerHeadlineStyle: const TextStyle(color: Colors.white),
        dayForegroundColor: WidgetStateProperty.all<Color>(Colors.white),
        todayForegroundColor: WidgetStateProperty.all<Color>(Colors.white),
        todayBackgroundColor: WidgetStateProperty.all<Color>(primaryColor),
        yearStyle: const TextStyle(color: Colors.white),
        yearForegroundColor: WidgetStateProperty.all<Color>(Colors.white),
        yearBackgroundColor: WidgetStateProperty.all<Color>(Colors.transparent),
        dividerColor: Colors.white,
      ),
    );
  }

  static ElevatedButtonThemeData _elevatedButtonThemeData(Color primaryColor) =>
      ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          minimumSize: const Size.fromHeight(56),
          backgroundColor: primaryColor,
          textStyle: const TextStyle(
            fontSize: 16,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      );

  static TextStyle _labelStyle(Color primaryColor) => TextStyle(
    color: primaryColor,
    fontWeight: FontWeight.w500,
    fontSize: 16,
  );

  static OutlineInputBorder _inputBorder(Color borderColor) =>
      OutlineInputBorder(
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        borderSide: BorderSide(color: borderColor),
      );

  static InputDecorationTheme _inputDecorationTheme({
    required Color primaryColor,
    required TextStyle labelStyle,
    required OutlineInputBorder inputBorder,
  }) => InputDecorationTheme(
    border: inputBorder,
    outlineBorder: inputBorder.borderSide,
    filled: true,
    fillColor: Colors.white,
    contentPadding: const EdgeInsets.all(16),
    labelStyle: labelStyle,
    hintStyle: _defaultHintStyle,
    enabledBorder: inputBorder.copyWith(
      borderSide: BorderSide(color: primaryColor, width: 1.0),
    ),
    focusedBorder: inputBorder.copyWith(
      borderSide: BorderSide(color: primaryColor, width: 2.0),
    ),
    errorBorder: inputBorder.copyWith(
      borderSide: const BorderSide(color: Colors.redAccent, width: 2.0),
    ),
    errorStyle: _erroTextStyle,
    floatingLabelBehavior: FloatingLabelBehavior.auto,
    floatingLabelStyle: labelStyle,
    prefixIconColor: primaryColor,
    suffixIconColor: primaryColor,
  );

  static Color _darken(Color color, {double amount = 0.1}) {
    final hslColor = HSLColor.fromColor(color);
    final adjustedLightness = (hslColor.lightness - amount).clamp(0.0, 1.0);

    return hslColor.withLightness(adjustedLightness).toColor();
  }
}
