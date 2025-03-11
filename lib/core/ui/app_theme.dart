import 'package:flutter/material.dart';

sealed class AppTheme {
  static final ElevatedButtonThemeData _elevatedButtonThemeData =
      ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          minimumSize: const Size.fromHeight(56),
          backgroundColor: Colors.blueAccent,
          textStyle: const TextStyle(
            fontSize: 16,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      );

  static const _erroTextStyle = TextStyle(fontSize: 14);

  static const _defaultLabelStyle = TextStyle(
    color: Colors.blueAccent,
    fontWeight: FontWeight.w500,
    fontSize: 16,
  );

  static const _defaultHintStyle = TextStyle(fontSize: 16);

  static final _defaultInputBorder = OutlineInputBorder(
    borderRadius: const BorderRadius.all(Radius.circular(8)),
    borderSide: BorderSide(color: Colors.blueAccent.shade700),
  );

  static final _defaulInputDecorationTheme = InputDecorationTheme(
    border: _defaultInputBorder,
    outlineBorder: _defaultInputBorder.borderSide,
    filled: true,
    fillColor: Colors.white,
    contentPadding: const EdgeInsets.all(16),
    labelStyle: _defaultLabelStyle,
    hintStyle: _defaultHintStyle,
    enabledBorder: _defaultInputBorder.copyWith(
      borderSide: const BorderSide(color: Colors.blueAccent, width: 1.0),
    ),
    focusedBorder: _defaultInputBorder.copyWith(
      borderSide: const BorderSide(color: Colors.blueAccent, width: 2.0),
    ),
    errorBorder: _defaultInputBorder.copyWith(
      borderSide: const BorderSide(color: Colors.redAccent, width: 2.0),
    ),
    errorStyle: _erroTextStyle,
    floatingLabelBehavior: FloatingLabelBehavior.auto,
    floatingLabelStyle: _defaultLabelStyle,
    prefixIconColor: Colors.blueAccent,
    suffixIconColor: Colors.blueAccent,
  );

  static ThemeData light = ThemeData.light(useMaterial3: true).copyWith(
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.blueAccent,
      surface: Colors.grey.shade100,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.blueAccent,
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
      shadowColor: Colors.transparent,
      iconTheme: IconThemeData(color: Colors.white),
    ),
    scaffoldBackgroundColor: Colors.blueAccent,
    inputDecorationTheme: _defaulInputDecorationTheme,
    elevatedButtonTheme: _elevatedButtonThemeData,
    cardTheme: const CardTheme(color: Colors.white),
    bottomSheetTheme: BottomSheetThemeData(
      dragHandleColor: Colors.grey.shade500,
      backgroundColor: Colors.white,
    ),
    datePickerTheme: const DatePickerThemeData(),
  );

  static ThemeData dark = ThemeData.dark(useMaterial3: true).copyWith(
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.blueAccent,
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
    inputDecorationTheme: _defaulInputDecorationTheme.copyWith(
      fillColor: Colors.grey.shade700,
      outlineBorder: _defaulInputDecorationTheme.outlineBorder?.copyWith(
        color: Colors.transparent,
      ),
      enabledBorder: _defaulInputDecorationTheme.enabledBorder?.copyWith(
        borderSide: _defaultInputBorder.borderSide.copyWith(
          color: Colors.transparent,
        ),
      ),
      labelStyle: _defaultLabelStyle.copyWith(color: Colors.grey.shade400),
      prefixIconColor: Colors.grey.shade400,
      suffixIconColor: Colors.grey.shade400,
    ),
    elevatedButtonTheme: _elevatedButtonThemeData,
    cardTheme: CardTheme(color: Colors.grey.shade800),
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
      todayBackgroundColor: WidgetStateProperty.all<Color>(Colors.blueAccent),
      yearStyle: const TextStyle(color: Colors.white),
      yearForegroundColor: WidgetStateProperty.all<Color>(Colors.white),
      yearBackgroundColor: WidgetStateProperty.all<Color>(Colors.transparent),
      dividerColor: Colors.white,
    ),
  );
}
