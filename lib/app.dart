import 'package:amin_pass/auth/screen/login_screen.dart';
import 'package:amin_pass/auth/screen/splash_screen.dart';
import 'package:flutter/material.dart';

class AminPass extends StatelessWidget {
  const AminPass({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen()
    );
  }
}