import 'package:amin_pass/profile/settings/screen/privacy_policy_screen.dart';
import 'package:amin_pass/profile/settings/screen/terms_and_condition.dart';
import 'package:amin_pass/profile/settings/screen/notification_screen.dart';
import 'package:amin_pass/profile/settings/screen/password_change_screen.dart';
import 'package:amin_pass/theme/app_color.dart';
import 'package:amin_pass/theme/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();
    final isDark = themeProvider.isDarkMode;

    return Scaffold(
      backgroundColor:
      isDark ? AppColors.darkBackground : AppColors.lightBackground,
      appBar: AppBar(
        elevation: 0,
        backgroundColor:
        isDark ? AppColors.darkBackground : AppColors.lightBackground,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new,
              color: isDark ? Colors.white : Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: Text(
          'Settings',
          style: TextStyle(
            color: isDark ? Colors.white : Colors.black,
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
                iconColor: AppColors.primary,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const PasswordChangeScreen()),
                  );
                },
              ),
              const SizedBox(height: 8),
              ProfileOption(
                icon: Icons.notifications,
                title: "Notification",
                iconColor: AppColors.primary,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const PushNotificationsScreen()),
                  );
                },
              ),
              const SizedBox(height: 8),
              ProfileOption(
                icon: isDark ? Icons.light_mode : Icons.dark_mode,
                title: "App Theme",
                iconColor: AppColors.primary,
                trailing: Switch(
                  value: isDark,
                  onChanged: (value) {
                    themeProvider.toggleTheme(value);
                  },
                  activeColor: AppColors.primary,
                ),
                onTap: () {},
              ),
              const SizedBox(height: 8),
              ProfileOption(
                icon: Icons.privacy_tip,
                title: "Privacy Policy",
                iconColor: AppColors.primary,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const PrivacySafetyScreen()),
                  );
                },
              ),
              const SizedBox(height: 8),
              ProfileOption(
                icon: Icons.help_rounded,
                title: "Terms of Condition",
                iconColor: AppColors.primary,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const TermsAndCondition()),
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
    final isDark = context.watch<ThemeProvider>().isDarkMode;

    return Card(
      color: isDark ? AppColors.darkBackground : Colors.white,
      shadowColor: isDark ? Colors.transparent : Colors.grey.shade300,
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: isDark ? Colors.grey.shade500 : Colors.grey.shade300,
        ),
      ),
      child: ListTile(
        leading: Icon(icon, color: iconColor),
        title: Text(
          title,
          style: TextStyle(
            fontSize: 18,
            color: isDark ? Colors.white : Colors.black,
          ),
        ),
        trailing: trailing ??
            Icon(Icons.arrow_forward_ios,
                size: 16, color: isDark ? Colors.white70 : Colors.black54),
        onTap: onTap,
      ),
    );
  }
}
