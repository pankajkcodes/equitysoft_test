import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

double height(BuildContext context) {
  return MediaQuery.of(context).size.height;
}

double width(BuildContext context) {
  return MediaQuery.of(context).size.width;
}

TextStyle bodyText1({required Color color}) {
  return GoogleFonts.lato(
      fontSize: 21, color: color, fontWeight: FontWeight.bold);
}

TextStyle bodyText1small({required Color color}) {
  return GoogleFonts.lato(
      fontSize: 16, color: color, fontWeight: FontWeight.normal);
}

TextStyle bodyText1Bigger({required Color color}) {
  return GoogleFonts.lato(
      fontSize: 25, color: color, fontWeight: FontWeight.bold);
}
