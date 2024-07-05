import 'package:flutter/material.dart';
import 'package:tuan08/app/page/auth/login.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme(
          brightness: Brightness.light,
          primary: const Color.fromARGB(255, 116, 116, 116),
          onPrimary: Colors.white,
          secondary: Colors.pinkAccent,
          onSecondary: Colors.white,
          error: Colors.red,
          onError: Colors.white,
          background: Colors.grey[100]!,
          onBackground: Colors.black,
          surface: Colors.white,
          onSurface: Colors.black,
        ),
        textTheme: const TextTheme(
          displaySmall: TextStyle(fontSize: 14.0, color: Colors.black),
          displayLarge: TextStyle(
              fontSize: 24.0, fontWeight: FontWeight.bold, color: Colors.black),
          displayMedium: TextStyle(
              fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        buttonTheme: ButtonThemeData(
          buttonColor: const Color.fromARGB(255, 0, 0, 0),
          textTheme: ButtonTextTheme.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        appBarTheme: const AppBarTheme(
          color: Color.fromARGB(175, 255, 255, 255),
          iconTheme: IconThemeData(color: Color.fromARGB(255, 0, 0, 0)),
          titleTextStyle: TextStyle(color: Color.fromARGB(255, 0, 0, 0), fontSize: 20.0),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.grey[200],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: const BorderSide(color: Color.fromARGB(255, 110, 110, 110)),
          ),
          hintStyle:  const TextStyle(color: Colors.grey),
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Colors.pinkAccent,
        ),
      ),
      home: const LoginScreen(),
      
    );
    
  }
}
//21dh112915
//312003
//thanh123