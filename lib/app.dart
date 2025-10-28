import 'package:amin_pass/auth/screen/login_screen.dart';
import 'package:amin_pass/auth/screen/splash_screen.dart';
import 'package:amin_pass/theme/theme_data.dart';
import 'package:amin_pass/theme/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AminPass extends StatelessWidget {
  const AminPass({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
       return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: themeProvider.isDarkMode
              ? ThemeMode.dark
              : ThemeMode.light,
          home: SplashScreen(),
        );
      },
    );
  }
}
