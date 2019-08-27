import 'package:flutter/material.dart';
import 'package:seat_picker_flow/screens/main_picker_screen.dart';
import 'theme.dart';

import 'package:flutter/foundation.dart' show debugDefaultTargetPlatformOverride;
import 'package:flutter/services.dart';

void main() {
  debugDefaultTargetPlatformOverride = TargetPlatform.fuchsia;
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
    return MaterialApp(
      title: 'Seat Picker Flow',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: primaryColor,
        scaffoldBackgroundColor: appbarColor,
        appBarTheme: AppBarTheme(
          color: appbarColor,
          elevation: 0,
        ),
      ),
      home: MainPickerScreen(),
    );
  }
}
