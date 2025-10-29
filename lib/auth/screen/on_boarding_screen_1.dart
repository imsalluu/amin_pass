import 'package:amin_pass/auth/screen/on_boarding_screen_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OnboardingScreenOne extends StatelessWidget {
  const OnboardingScreenOne({super.key});

  @override
  Widget build(BuildContext context) {
    // Detect current theme
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDarkMode ? Colors.black : Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Logo Section
              SizedBox(
                width: 138,
                height: 120,
                child: SvgPicture.asset(
                  isDarkMode
                      ? 'assets/images/logo_dark.svg' // Dark mode logo
                      : 'assets/images/aminpass_logo.svg',      // Light mode logo
                  fit: BoxFit.contain,
                ),
              ),

              const SizedBox(height: 60),

              // QR Illustration Section
              Image.asset(
                'assets/images/on_boarding_one.png',
                height: 274,
                fit: BoxFit.contain,
              ),

              const SizedBox(height: 16),

              // Description Text
              Text(
                "Quickly scan the store's QR code to earn\nor redeem your loyalty points",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: isDarkMode ? Colors.white : Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 40),

              // Button aligned to the right
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    width: 152,
                    height: 39,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF7AA3CC),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => OnboardingScreenTwo(),
                          ),
                        );
                      },
                      child: const Text(
                        "Next",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
