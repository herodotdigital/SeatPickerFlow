import 'package:flutter/material.dart';

const primaryColor = MaterialColor(
  0xFF451CC7,
  <int, Color>{
    50: Color.fromRGBO(136, 14, 79, .1),
    100: Color.fromRGBO(136, 14, 79, .2),
    200: Color.fromRGBO(136, 14, 79, .3),
    300: Color.fromRGBO(136, 14, 79, .4),
    400: Color.fromRGBO(136, 14, 79, .5),
    500: Color.fromRGBO(136, 14, 79, .6),
    600: Color.fromRGBO(136, 14, 79, .7),
    700: Color.fromRGBO(136, 14, 79, .8),
    800: Color.fromRGBO(136, 14, 79, .9),
    900: Color.fromRGBO(136, 14, 79, 1),
  },
);

const appbarColor = Colors.white;

const cardBackground = Color(0xFFE4E8Ef);

const shieldColor = Color(0xFFD15235);

const titleTextStyle = TextStyle(
  color: Colors.black,
  fontWeight: FontWeight.bold,
  fontSize: 22,
  letterSpacing: 1,
);

const primaryTextStyle = TextStyle(
  color: Color(0xFF0E0E0E),
  fontWeight: FontWeight.bold,
  fontSize: 20,
  letterSpacing: 1,
);

const secondaryTextStyle = TextStyle(
  color: Color(0xFF0E0E0E),
  fontWeight: FontWeight.w500,
  fontSize: 13,
);

const additionalTextStyle = TextStyle(
  color: Color(0xFF536072),
  fontSize: 13,
  letterSpacing: 1,
);

const sectorTextStyle = TextStyle(
  color: primaryColor,
  fontWeight: FontWeight.bold,
  fontSize: 22,
);

const summaryPrimaryTextStyle = TextStyle(
  color: Colors.white,
  fontWeight: FontWeight.bold,
  fontSize: 26,
);

const summarySecondaryTextStyle = TextStyle(
  color: Colors.white54,
  fontWeight: FontWeight.bold,
  fontSize: 20,
);

const priceTextStyle = TextStyle(
  color: primaryColor,
  fontSize: 24,
  fontWeight: FontWeight.bold,
);
