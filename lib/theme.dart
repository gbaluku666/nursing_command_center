import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const Color navyBlue = Color(0xFF0A192F);
  static const Color navyPurple = Color(0xFF240046);
  static const Color neonPurple = Color(0xFF7B2CBF);
  static const Color marbleWhite = Color(0xFFE0E1DD);

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: navyBlue,
    primaryColor: navyPurple,
    textTheme: GoogleFonts.playfairDisplayTextTheme(
      ThemeData.dark().textTheme,
    ).apply(bodyColor: marbleWhite, displayColor: marbleWhite),
  );

  // This is the "Elevated Selection Button" decoration you requested
  static BoxDecoration elevatedDecoration = BoxDecoration(
    color: navyBlue,
    borderRadius: BorderRadius.circular(15),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.5),
        offset: const Offset(6, 6),
        blurRadius: 12,
      ),
      BoxShadow(
        color: neonPurple.withOpacity(0.2),
        offset: const Offset(-2, -2),
        blurRadius: 8,
      ),
    ],
  );
}