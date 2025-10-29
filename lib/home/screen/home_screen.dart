import 'package:amin_pass/rewards/rewards_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  final Function(bool) onRewardButtonTap;
  const HomeScreen({super.key, required this.onRewardButtonTap});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final double percent = 0.7; // 70%
  final int points = 70;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: Column(
                children: [
                  // Top row
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 26,
                        backgroundColor: isDark ? Colors.grey.shade800 : Colors.blueGrey.shade100,
                        backgroundImage: const NetworkImage('https://picsum.photos/200'),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Hi, Jane!',
                              style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w700,
                                  color: theme.textTheme.bodyLarge?.color),
                            ),
                            const SizedBox(height: 2),
                            Text("What's up", style: TextStyle(color: theme.textTheme.bodyMedium?.color)),
                          ],
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.notifications_none, size: 28, color: theme.iconTheme.color),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Points Card
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFF8DBAE9),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: const [
                                Icon(Icons.check_circle, color: Colors.green),
                                SizedBox(width: 8),
                                Text('Points', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600,color: Colors.black)),
                              ],
                            ),
                            const SizedBox(height: 6),
                            Text(
                              '$points',
                              style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold,color: Colors.black),
                            ),
                            const SizedBox(height: 6),
                            SizedBox(
                              width: 180,
                              child: Text(
                                'You need ${100 - 70} more points to get your next reward',
                                style: TextStyle(fontSize: 12, color: isDark ? Colors.black : Colors.black),
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        SizedBox(
                          height: 72,
                          width: 72,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              SizedBox(
                                height: 72,
                                width: 72,
                                child: CircularProgressIndicator(
                                  value: percent,
                                  strokeWidth: 8,
                                  backgroundColor: Colors.white,
                                  valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
                                ),
                              ),
                              Text('${(percent * 100).toInt()}%',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      color: isDark ? Colors.black : Colors.black)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Buttons Row
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            widget.onRewardButtonTap(true); // Earn Points
                          },
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            backgroundColor: const Color(0xff7AA3CC),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            elevation: 0,
                          ),
                          child: Text('Earn Points',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: isDark ? Colors.black : Colors.black)),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {
                            widget.onRewardButtonTap(false); // View All Rewards
                          },
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            backgroundColor: isDark ? Colors.grey.shade900 : Colors.white,
                            side: BorderSide(color: isDark ? Colors.white24 : Colors.black12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          child: Text('View All Rewards',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: isDark ? Colors.white : Colors.black)),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),

            // Scrollable section
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Upcoming Reward
                    Text('Upcoming Reward',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w500, color: theme.textTheme.bodyLarge?.color)),
                    const SizedBox(height: 10),
                    Container(
                      height: 142,
                      width: double.infinity,
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: isDark ? Colors.black12 : Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: isDark ? Colors.grey.shade700 : Colors.grey.shade300),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Business Name',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  color: theme.textTheme.bodyLarge?.color)),
                          const SizedBox(height: 6),
                          Text('Next Reward: Free Coffee',
                              style: TextStyle(
                                  fontSize: 14, color: theme.textTheme.bodyMedium?.color)),
                          const SizedBox(height: 10),
                          Text('Just 10 points away!',
                              style: TextStyle(
                                  fontSize: 12, color: isDark ? Colors.white70 : Colors.black87)),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              Expanded(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: LinearProgressIndicator(
                                    value: percent,
                                    minHeight: 16,
                                    backgroundColor: isDark ? Colors.grey.shade800 : Colors.grey.shade200,
                                    valueColor: const AlwaysStoppedAnimation(Color(0xff7AA3CC)),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                            ],
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Recent Activity
                    Text('Recent Activity',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w500, color: theme.textTheme.bodyLarge?.color)),
                    const SizedBox(height: 8),

                    ActivityItem(
                      icon: Icons.add_circle,
                      color: Colors.green,
                      text: "5 Point earned at Cafe ABC",
                      date: "12 Oct 2025",
                      isDark: isDark,
                    ),
                    ActivityItem(
                      icon: Icons.card_giftcard,
                      color: isDark ? Colors.white : Colors.black,
                      text: "Reward 'Free Coffee' redeemed",
                      date: "10 Oct 2025",
                      isDark: isDark,
                    ),
                    ActivityItem(
                      icon: Icons.label,
                      color: isDark ? Colors.white : Colors.black,
                      text: "10 Points earned at store B",
                      date: "09 Oct 2025",
                      isDark: isDark,
                    ),
                    const SizedBox(height: 60),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ActivityItem extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String text;
  final String date;
  final bool isDark;

  const ActivityItem({
    super.key,
    required this.icon,
    required this.color,
    required this.text,
    required this.date,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(text,
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        color: isDark ? Colors.white : Colors.black)),
                const SizedBox(height: 4),
                Text(date,
                    style: TextStyle(color: isDark ? Colors.white70 : Colors.black, fontSize: 12)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
