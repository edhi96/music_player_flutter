import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  static const Color whiteColor = Color(0xFFF9f9FA);
  static const Color blackColor = Color(0xFF1d1d1d);
  static const Color yellowColor = Color(0xFFFCA639);
  static const Color greenColor = Color(0xFF0b5c46);
  static const Color blueColor = Color(0xFF242B54);
  static const Color grayColor = Color(0xFFCBC7D0);
}

class AppFontStyle {
  AppFontStyle._();
}

final TextTheme myTextTheme = TextTheme(
  displayLarge: GoogleFonts.robotoMono(fontSize: 92, fontWeight: FontWeight.w300),
  displayMedium: GoogleFonts.robotoMono(
    fontSize: 57,
    fontWeight: FontWeight.w300,
  ),
  displaySmall: GoogleFonts.robotoMono(fontSize: 46, fontWeight: FontWeight.w400),
  headlineMedium: GoogleFonts.robotoMono(
    fontSize: 32,
    fontWeight: FontWeight.w400,
  ),
  headlineSmall: GoogleFonts.robotoMono(fontSize: 23, fontWeight: FontWeight.w400),
  titleLarge: GoogleFonts.dmSans(
    fontSize: 19,
    fontWeight: FontWeight.w600,
  ),
  titleMedium: GoogleFonts.dmSans(
    fontSize: 18,
    fontWeight: FontWeight.w600,
  ),
  titleSmall: GoogleFonts.dmSans(
    fontSize: 17,
    fontWeight: FontWeight.w600,
  ),
  bodyLarge: GoogleFonts.dmSans(
    fontSize: 16,
    fontWeight: FontWeight.w600,
  ),
  bodyMedium: GoogleFonts.dmSans(
    fontSize: 15,
    fontWeight: FontWeight.w600,
  ),
  labelLarge: GoogleFonts.dmSans(
    fontSize: 14,
    fontWeight: FontWeight.w600,
  ),
  bodySmall: GoogleFonts.dmSans(
    fontSize: 12,
    fontWeight: FontWeight.w600,
  ),
  labelSmall: GoogleFonts.dmSans(fontSize: 10, fontWeight: FontWeight.w600),
);
