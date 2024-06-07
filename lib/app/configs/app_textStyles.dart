// ignore_for_file: non_constant_identifier_names, constant_identifier_names
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

abstract class AppTextStyles {
  AppTextStyles._();

  static TextStyle customText({
    Color? color,
    FontWeight fontWeight = FontWeight.normal,
    double letterSpacing = 0,
    double fonSize = 15,
  }) {
    return GoogleFonts.poppins(
        fontSize: fonSize.sp, fontWeight: fontWeight, color: color, letterSpacing: letterSpacing);
  }

  static TextStyle customText12({
    Color? color,
    FontWeight fontWeight = FontWeight.normal,
    double letterSpacing = 0,
  }) {
    return GoogleFonts.poppins(
        fontSize: 13.sp, fontWeight: fontWeight, color: color, letterSpacing: letterSpacing);
  }

  static TextStyle customText14({
    Color? color,
    FontWeight fontWeight = FontWeight.normal,
    double letterSpacing = 0,
  }) {
    return GoogleFonts.poppins(
      fontSize: 14.sp, fontWeight: fontWeight, color: color, letterSpacing: letterSpacing,);
  }


  static TextStyle customText16({
    Color? color,
    FontWeight fontWeight = FontWeight.normal,
    double letterSpacing = 0,
  }) {
    return GoogleFonts.poppins(
        fontSize: 16.sp, fontWeight: fontWeight, color: color, letterSpacing: letterSpacing);
  }

  static TextStyle customText18({
    Color? color,
    FontWeight fontWeight = FontWeight.normal,
    double letterSpacing = 0,
  }) {
    return GoogleFonts.poppins(
        fontSize: 18.sp, fontWeight: fontWeight, color: color, letterSpacing: letterSpacing);
  }

  static TextStyle customText20({
    Color? color,
    FontWeight fontWeight = FontWeight.normal,
    double letterSpacing = 0,
  }) {
    return GoogleFonts.poppins(
        fontSize: 20.sp, fontWeight: fontWeight, color: color, letterSpacing: letterSpacing);
  }

  static TextStyle customText22({
    Color? color,
    FontWeight fontWeight = FontWeight.normal,
    double letterSpacing = 0,
  }) {
    return GoogleFonts.poppins(
        fontSize: 22.sp, fontWeight: fontWeight, color: color, letterSpacing: letterSpacing);
  }

  static TextStyle customText24({
    Color? color,
    FontWeight fontWeight = FontWeight.normal,
    double letterSpacing = 0,
  }) {
    return GoogleFonts.poppins(
        fontSize: 24.sp, fontWeight: fontWeight, color: color, letterSpacing: letterSpacing);
  }

  static TextStyle customText26({
    Color? color,
    FontWeight fontWeight = FontWeight.normal,
    double letterSpacing = 0,
  }) {
    return GoogleFonts.poppins(
        fontSize: 26.sp, fontWeight: fontWeight, color: color, letterSpacing: letterSpacing);
  }

  static TextStyle customText28({
    Color? color,
    FontWeight fontWeight = FontWeight.normal,
    double letterSpacing = 0,
  }) {
    return GoogleFonts.poppins(
        fontSize: 28.sp, fontWeight: fontWeight, color: color, letterSpacing: letterSpacing);
  }
}
