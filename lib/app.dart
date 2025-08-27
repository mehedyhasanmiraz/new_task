import 'package:flutter/material.dart';
import 'package:new_task/ui/screens/splash_screen.dart';

class TaskManagerApp extends StatelessWidget {
   TaskManagerApp({super.key});

  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: TaskManagerApp.navigatorKey,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorSchemeSeed: Colors.green,
        textTheme: TextTheme(
          titleLarge: TextStyle(fontSize: 24,fontWeight: FontWeight.w600),
          bodyMedium: TextStyle(fontWeight: FontWeight.w400,color: Colors.grey),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            fixedSize: Size.fromWidth(double.maxFinite,),
            backgroundColor: Colors.green,
            foregroundColor: Colors.white,
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          fillColor: Colors.white,
          filled: true,
          hintStyle: TextStyle(fontWeight: FontWeight.w400, color: Colors.grey),
          contentPadding: EdgeInsets.symmetric(horizontal: 16),
          border: _getZeroBorder(),
          enabledBorder: _getZeroBorder(),
          errorBorder: _getZeroBorder(),

        ),
      ),
      home: SplashScreen(),
    );
  }
}

OutlineInputBorder _getZeroBorder() {
  return OutlineInputBorder(borderSide: BorderSide.none);
}
