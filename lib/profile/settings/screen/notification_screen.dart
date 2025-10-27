import 'package:flutter/material.dart';

class PushNotificationsScreen extends StatefulWidget {
  const PushNotificationsScreen({super.key});

  @override
  State<PushNotificationsScreen> createState() =>
      _PushNotificationsScreenState();
}

class _PushNotificationsScreenState extends State<PushNotificationsScreen> {
  bool master = true;
  bool sms = false;
  bool notifi = true;
  bool birthday = true;


  Widget _sectionTitle(String t, Color textColor) => Padding(
    padding: const EdgeInsets.fromLTRB(16, 18, 16, 8),
    child: Text(t,
        style: TextStyle(
            fontSize: 16, fontWeight: FontWeight.w700, color: textColor)),
  );

  Widget _tile({
    required String title,
    String? subtitle,
    Widget? trailing,
    VoidCallback? onTap,
    Color? textColor,
    Color? subTextColor,
  }) {
    return Material(
      color: Colors.white,
      child: InkWell(
        onTap: onTap,
        child: ListTile(
          title: Text(title,
              style: TextStyle(
                  fontSize: 15.5,
                  fontWeight: FontWeight.w500,
                  color: textColor ?? Colors.black)),
          subtitle: subtitle == null
              ? null
              : Text(subtitle,
              style: TextStyle(
                  color: subTextColor ??
                      (textColor?.withOpacity(0.6) ?? Colors.black54),
                  fontSize: 12.5)),
          trailing: trailing,
          contentPadding: const EdgeInsets.symmetric(horizontal: 12),
          visualDensity: const VisualDensity(vertical: -1),
        ),
      ),
    );
  }

  Widget _card(List<Widget> children) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white, // White background
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300, width: 1), // Grey border
      ),
      child: Column(
        children: [
          for (int i = 0; i < children.length; i++) ...[
            children[i],
            if (i != children.length - 1) const SizedBox(height: 12),
          ],
        ],
      ),
    );
  }


  void _save() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Notification preferences saved')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Notifications',
            style: TextStyle(fontWeight: FontWeight.w700)),
      ),
      body:ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
        children: [
          // Master notification switch
          _card([
            _tile(
              title: 'Enable notifications',
              subtitle: 'Turn all notifications on or off',
              trailing: Switch(
                value: master,
                activeColor: Colors.white,
                activeTrackColor: const Color(0xff7AA3CC),
                onChanged: (v) => setState(() => master = v),
              ),
            ),
          ]),
          const SizedBox(height: 25),

          // SMS Updates - single card
          _card([
            _tile(
              title: 'SMS Updates',
              trailing: Switch(
                value: sms && master,
                onChanged: master ? (v) => setState(() => sms = v) : null,
                activeColor: Colors.white,
                activeTrackColor: const Color(0xff7AA3CC),
              ),
            ),
          ]),
          const SizedBox(height: 18),

          // Push Notification - single card
          _card([
            _tile(
              title: 'Push Notification',
              trailing: Switch(
                value: notifi && master,
                onChanged: master ? (v) => setState(() => notifi = v) : null,
                activeColor: Colors.white,
                activeTrackColor: const Color(0xff7AA3CC),
              ),
            ),
          ]),
          const SizedBox(height: 18),

          // Birthday Rewards - single card
          _card([
            _tile(
              title: 'Birthday Rewards',
              trailing: Switch(
                value: birthday && master,
                onChanged: master ? (v) => setState(() => birthday = v) : null,
                activeColor: Colors.white,
                activeTrackColor: const Color(0xff7AA3CC),
              ),
            ),
          ]),

          const SizedBox(height: 24),

          // Save button
          SizedBox(
            height: 48,
            width: double.infinity,
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xff7AA3CC), Color(0xff7AA3CC)],
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: _save,
                child: const Text(
                  'Save',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600,color: Colors.black),
                ),
              ),
            ),
          ),
        ],
      )

    );
  }
}
