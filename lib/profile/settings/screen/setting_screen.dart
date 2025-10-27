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

  Widget _sectionHeader(String text, Color textColor) => Padding(
    padding: const EdgeInsets.fromLTRB(16, 18, 16, 10),
    child: Text(
      text.toUpperCase(),
      style: TextStyle(
        color: textColor.withOpacity(0.7),
        fontWeight: FontWeight.w700,
        fontSize: 12,
        letterSpacing: .6,
      ),
    ),
  );

  Widget _tile({
    required IconData icon,
    required String title,
    VoidCallback? onTap,
    Widget? trailing,
    required Color iconColor,
    required Color textColor,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: ListTile(
          leading: Icon(icon, size: 22, color: iconColor),
          title: Text(title,),
          trailing: trailing ??
              Icon(Icons.chevron_right, color: textColor.withOpacity(0.5)),
          contentPadding: const EdgeInsets.symmetric(horizontal: 12),
          visualDensity: const VisualDensity(vertical: -1),
        ),
      ),
    );
  }


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
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PasswordChangeScreen()),
                  );
                },
              ),
              const SizedBox(height: 8),
              ProfileOption(
                icon: Icons.notifications,
                title: "Notification",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PushNotificationsScreen()),
                  );
                },
              ),
              const SizedBox(height: 8),
              ProfileOption(icon: Icons.dark_mode, title: "App Theme", onTap: () {}),
              const SizedBox(height: 8),
              ProfileOption(
                icon: Icons.privacy_tip,
                title: "Privacy Policy",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PrivacySafetyScreen()),
                  );
                },
              ),
              const SizedBox(height: 8),
              ProfileOption(
                icon: Icons.help_rounded,
                title: "Terms of Condition",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => TermsAndCondition()),
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

  const ProfileOption({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: Icon(icon, color: Colors.blue),
        title: Text(title, style: TextStyle(fontSize: 18)),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }
}

