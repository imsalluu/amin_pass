import 'package:flutter/material.dart';

class TermsAndCondition extends StatelessWidget {
  const TermsAndCondition({super.key});

  // Bullet point widget
  Widget _bullet(String text, {Color textColor = Colors.black}) => Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.only(top: 6),
        child: Icon(Icons.circle, size: 6, color: textColor),
      ),
      const SizedBox(width: 8),
      Expanded(
        child: Text(
          text,
          style: TextStyle(fontSize: 14, height: 1.35, color: textColor),
        ),
      ),
    ],
  );

  // Section header
  Widget _h(String text, {Color color = Colors.black}) => Padding(
    padding: const EdgeInsets.only(top: 18, bottom: 6),
    child: Text(
      text,
      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: color),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Terms & Condition',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Welcome to Loyalty! By using our app. You agree to the following Terms of Service.",
              style: TextStyle(fontSize: 14, height: 1.45),
            ),
            _h('User Eligibility:'),
            _bullet('User must be at least 13 years old to use Loyalty. User under 18 require parental consent.'),
            _h('Account Creation:'),
            _bullet('You are responsible for accurate information during account creation. Do not share login credentials.'),
            _h('Data Security:'),
            _bullet('We use industry-standard security measures to protect your data. However, please be aware that no online platform is entirely secure.'),
          ],
        ),
      ),
    );
  }
}
