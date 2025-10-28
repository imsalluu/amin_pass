import 'package:amin_pass/profile/settings/screen/privacy_policy_screen.dart';
import 'package:amin_pass/profile/settings/screen/terms_and_condition.dart';
import 'package:amin_pass/profile/settings/screen/notification_screen.dart';
import 'package:amin_pass/profile/settings/screen/password_change_screen.dart';
import 'package:flutter/material.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  bool isDarkMode = false; // toggle state

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: const Text(
          'Settings',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              ProfileOption(
                icon: Icons.lock,
                title: "Password Change",
                iconColor: Color(0xFF7AA3CC),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PasswordChangeScreen()),
                  );
                },
              ),
              const SizedBox(height: 8),
              ProfileOption(
                icon: Icons.notifications,
                title: "Notification",
                iconColor: Color(0xFF7AA3CC),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PushNotificationsScreen()),
                  );
                },
              ),
              const SizedBox(height: 8),
              ProfileOption(
                icon: Icons.dark_mode,
                title: "App Theme",
                iconColor: Color(0xFF7AA3CC),
                trailing: Switch(
                  value: isDarkMode,
                  onChanged: (val) {
                    setState(() {
                      isDarkMode = val;
                    });
                  },
                  activeColor: Color(0xFF7AA3CC),
                ),
                onTap: () {},
              ),
              const SizedBox(height: 8),
              ProfileOption(
                icon: Icons.privacy_tip,
                title: "Privacy Policy",
                iconColor:Color(0xFF7AA3CC),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PrivacySafetyScreen()),
                  );
                },
              ),
              const SizedBox(height: 8),
              ProfileOption(
                icon: Icons.help_rounded,
                title: "Terms of Condition",
                iconColor: Color(0xFF7AA3CC),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => TermsAndCondition()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProfileOption extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  final Color iconColor;
  final Widget? trailing;

  const ProfileOption({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
    required this.iconColor,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: Icon(icon, color: iconColor),
        title: Text(title, style: const TextStyle(fontSize: 18)),
        trailing: trailing ?? const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }
}
