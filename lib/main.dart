import 'package:flutter/material.dart';
import 'package:seat_picker_flow/screens/main_picker_screen.dart';
import 'theme.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Seat Picker Flow',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: primaryColor,
        scaffoldBackgroundColor: appbarColor,
        appBarTheme: AppBarTheme(
          color: appbarColor,
          elevation: 0,
          brightness: Brightness.light
        ),
      ),
      home: MainPickerScreen(),
    );
  }
}
