import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class ThemeProvider extends ChangeNotifier{

  ThemeMode themeMode =ThemeMode.light;
  bool get isDarkMode => themeMode == ThemeMode.dark;

  void toggleTheme(){

   themeMode = themeMode == ThemeMode.light ?ThemeMode.dark:ThemeMode.light;
    notifyListeners();

  }


}

class MyTheme{

  static final lightMode =ThemeData(
    textTheme: TextTheme(
      titleLarge: GoogleFonts.ubuntu(color: Colors.white54,fontSize: 22,fontWeight: FontWeight.bold),
      titleSmall: GoogleFonts.ubuntu(color: Colors.black,fontSize: 12),
      labelSmall: GoogleFonts.ubuntu(color: Colors.black38,fontSize: 13),
      bodySmall: GoogleFonts.ubuntu(color: Colors.black,fontSize: 15),
    ),
    unselectedWidgetColor:Colors.black,
    primaryColorLight:Colors.white,
    scaffoldBackgroundColor:Colors.white,
    primaryColor: Colors.blueAccent,
    secondaryHeaderColor:Colors.black,
      iconTheme: const IconThemeData(color: Colors.white,opacity: 0.8)




  );
  static final darkMode =ThemeData(
    textTheme: TextTheme(
      titleLarge: GoogleFonts.ubuntu(color: Colors.black,fontSize: 22,fontWeight: FontWeight.bold),
      titleSmall: GoogleFonts.ubuntu(color: Colors.black,fontSize: 12),
      labelSmall: GoogleFonts.ubuntu(color: Colors.white54,fontSize: 13),
      bodySmall: GoogleFonts.ubuntu(color: Colors.white,fontSize: 15),
    ),
    unselectedWidgetColor: Colors.white70,
    primaryColorLight: Colors.black,
    scaffoldBackgroundColor: Colors.grey.shade900,
    primaryColor: Colors.blueAccent[700],
    secondaryHeaderColor: Colors.white,
      iconTheme: const IconThemeData(color: Colors.black,opacity: 0.8)




  );

}