import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: avoid_classes_with_only_static_members
class FlutterFlowTheme {
  static const Color primaryColor = Color(0xFF25263E);
  static const Color secondaryColor = Color(0xFFFF4553);
  static const Color tertiaryColor = Color(0xFF252854);

  String primaryFontFamily = 'Poppins';
  String secondaryFontFamily = 'Roboto';

  static TextStyle get title1 => GoogleFonts.getFont(
        'Poppins',
        color: Color(0xFF535480),
        fontWeight: FontWeight.bold,
        fontSize: 26,
      );
  static TextStyle get title2 => GoogleFonts.getFont(
        'Poppins',
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 22,
      );
  static TextStyle get title3 => GoogleFonts.getFont(
        'Poppins',
        color: Colors.white,
        fontWeight: FontWeight.w500,
        fontSize: 20,
      );
  static TextStyle get subtitle1 => GoogleFonts.getFont(
        'Poppins',
        color: Colors.black,
        fontWeight: FontWeight.normal,
        fontSize: 14,
      );
  static TextStyle get subtitle2 => GoogleFonts.getFont(
        'Poppins',
        color: Colors.white,
        fontWeight: FontWeight.normal,
        fontSize: 16,
      );
  static TextStyle get bodyText1 => GoogleFonts.getFont(
        'Poppins',
        color: Colors.white,
        fontWeight: FontWeight.normal,
        fontSize: 14,
      );
  static TextStyle get bodyText2 => GoogleFonts.getFont(
        'Poppins',
        color: Color(0xFFB2B2B2),
        fontWeight: FontWeight.normal,
        fontSize: 14,
      );
}

extension TextStyleHelper on TextStyle {
  TextStyle override(
          {String fontFamily,
          Color color,
          double fontSize,
          FontWeight fontWeight,
          FontStyle fontStyle}) =>
      GoogleFonts.getFont(
        fontFamily,
        color: color ?? this.color,
        fontSize: fontSize ?? this.fontSize,
        fontWeight: fontWeight ?? this.fontWeight,
        fontStyle: fontStyle ?? this.fontStyle,
      );
}
