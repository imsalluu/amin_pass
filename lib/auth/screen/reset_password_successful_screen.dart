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
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 40.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 100),

              // ✅ SVG Logo Section
              Column(
                children: [Image.asset('assets/images/Check.png', height: 140)],
              ),
              const SizedBox(height: 40),
              // Login title
              const Text(
                'Password Changed',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 18),
              const Text(
                'Your password has been changed successfully',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
              ),

              SizedBox(height: 20),
              // Login Form
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF7AA3CC), // gold color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Text(
                    "Back To Again",
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
