import 'package:amin_pass/auth/screen/login_screen.dart';
import 'package:amin_pass/auth/screen/otp_forgot_password_screen.dart';
import 'package:amin_pass/auth/screen/reset_password_screen.dart';
import 'package:amin_pass/auth/screen/scan_shop_screen.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OtpForgotPasswordScreen extends StatefulWidget {
  const OtpForgotPasswordScreen({super.key});

  @override
  State<OtpForgotPasswordScreen> createState() => _OtpForgotPasswordScreenState();
}

class _OtpForgotPasswordScreenState extends State<OtpForgotPasswordScreen> {
  final TextEditingController _otpTEController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              const SizedBox(height: 120),
              const Text(
                'Please Check your email',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 18),
              const Text(
                'We’ve sent a code to example@gmail.com',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 40),


              PinCodeTextField(
                controller: _otpTEController,
                length: 4,
                obscureText: false,
                animationType: AnimationType.fade,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                keyboardType: TextInputType.number,
                pinTheme: PinTheme(
                  shape: PinCodeFieldShape.box,
                  fieldWidth: 50,
                  fieldHeight: 50,
                ),
                animationDuration: Duration(milliseconds: 300),
                appContext: context,
                validator: (String? value) {
                  if (value == null || value.length < 4) {
                    return 'Enter your OTP';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 40),

              // Sign Up Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(context,MaterialPageRoute(builder: (context)=>ResetPasswordScreen(),),);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFD4AF37),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Text(
                    'Send Code',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _otpTEController.dispose();
    super.dispose();
  }
}