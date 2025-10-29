import 'package:amin_pass/auth/screen/login_screen.dart';
import 'package:flutter/material.dart';

class ResetPasswordSuccessfulScreen extends StatefulWidget {
  const ResetPasswordSuccessfulScreen({super.key});

  @override
  State<ResetPasswordSuccessfulScreen> createState() =>
      _ResetPasswordSuccessfulScreenState();
}

class _ResetPasswordSuccessfulScreenState
    extends State<ResetPasswordSuccessfulScreen> {
  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor = isDarkMode ? Colors.black : Colors.white;
    final textColor = isDarkMode ? Colors.white : Colors.black;
    final secondaryTextColor = isDarkMode ? Colors.white70 : Colors.black87;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 40.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 100),

              // Check Image
              Image.asset(
                'assets/images/Check.png',
                height: 140,
              ),
              const SizedBox(height: 40),

              // Title
              Text(
                'Password Changed',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: textColor,
                ),
              ),
              const SizedBox(height: 18),
              Text(
                'Your password has been changed successfully',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: secondaryTextColor,
                ),
              ),
              const SizedBox(height: 20),

              // Back to Login Button
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const LoginScreen()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF7AA3CC),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Text(
                    "Back To Login",
                    style: TextStyle(fontSize: 16, color: Colors.black),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
