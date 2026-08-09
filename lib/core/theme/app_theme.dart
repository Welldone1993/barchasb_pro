import 'package:flutter/material.dart';

class AppTheme {
  // Define constant colors for better reusability and consistency
  static const Color _primaryColor = Color(0xFF1A3B5C);
  static const Color _scaffoldBackgroundColor = Color(0xFFF3F4F6);
  static const Color _surfaceColor = Colors.white;
  static const Color _inputFillColor = Color(0xFFE8EFFF);
  static const Color _textColorOnPrimary = Colors.white;
  static const Color _textColorOnSurface = _primaryColor;
  static const Color _iconColor = _primaryColor;
  static const Color _hintColor = Colors.grey;

  /// Light Theme Configuration based on the provided UI images.
  static ThemeData get lightTheme => ThemeData(
    useMaterial3: true,
    fontFamily: 'IranSans',
    // فونتی که مشخص کردید
    scaffoldBackgroundColor: _scaffoldBackgroundColor,
    brightness: Brightness.light,

    colorScheme: const ColorScheme.light(
      primary: _primaryColor,
      onPrimary: _textColorOnPrimary,
      secondary: Colors.lightBlue,
      onSecondary: _textColorOnPrimary,
      surface: _surfaceColor,
      onSurface: _textColorOnSurface,
      background: _scaffoldBackgroundColor,
      onBackground: _textColorOnSurface,
      error: Colors.redAccent,
      onError: Colors.white,
    ),

    // --- Component Themes ---
    appBarTheme: const AppBarTheme(
      backgroundColor: _surfaceColor,
      elevation: 1,
      centerTitle: true,
      titleTextStyle: TextStyle(
        fontFamily: 'IranSans',
        color: _textColorOnSurface,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      iconTheme: IconThemeData(color: _iconColor),
    ),

    textTheme: const TextTheme(
      // برای تیترهای بزرگ مثل "ورود"
      displayMedium: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.bold,
        color: _textColorOnSurface,
      ),
      // برای تیترهای کوچکتر
      headlineMedium: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w600,
        color: _textColorOnSurface,
      ),
      // برای متن‌های اصلی بدنه
      bodyLarge: TextStyle(fontSize: 16, color: Color(0xFF333333)),
      bodyMedium: TextStyle(fontSize: 14, color: Color(0xFF555555)),
      // استایل متن دکمه‌ها
      labelLarge: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: _textColorOnPrimary,
      ),
      labelMedium: TextStyle(fontSize: 14, color: _textColorOnPrimary),
      labelSmall: TextStyle(fontSize: 12, fontWeight: FontWeight.w100, color: _textColorOnPrimary),
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: _inputFillColor,
      hintStyle: TextStyle(color: _hintColor, fontSize: 14),
      prefixIconColor: _iconColor,
      contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none, // بدون حاشیه در حالت عادی
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        // حاشیه با رنگ اصلی در حالت فوکوس برای بازخورد بهتر
        borderSide: const BorderSide(color: _primaryColor, width: 1.5),
      ),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: _primaryColor,
        foregroundColor: _textColorOnPrimary,
        minimumSize: const Size(double.infinity, 55),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        textStyle: const TextStyle(
          fontFamily: 'IranSans',
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),

    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: _primaryColor,
        textStyle: const TextStyle(
          fontFamily: 'IranSans',
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  );

  // می‌توانید تم دارک را هم اینجا اضافه کنید
  // static ThemeData get darkTheme => ThemeData(...);
}
