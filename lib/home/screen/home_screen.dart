import 'package:amin_pass/rewards/rewards_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final double percent = 0.7; // 70%
  final int points = 70;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // ✅ Fixed Top Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: Column(
                children: [
                  // Top row
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 26,
                        backgroundColor: Colors.blueGrey.shade100,
                        backgroundImage:
                        const NetworkImage('https://picsum.photos/200'),
                      ),
                      const SizedBox(width: 12),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Hi, Jane!',
                                style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.w700)),
                            SizedBox(height: 2),
                            Text("What's up"),
                          ],
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.notifications_none, size: 28),
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
                                Text('Points',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600)),
                              ],
                            ),
                            const SizedBox(height: 6),
                            Text(
                              '$points',
                              style: const TextStyle(
                                  fontSize: 28, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 6),
                            SizedBox(
                              width: 180,
                              child: Text(
                                'You need ${100 - 70} more points to get your next reward',
                                style: const TextStyle(
                                    fontSize: 12, color: Colors.black),
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
                                  valueColor: const AlwaysStoppedAnimation<Color>(
                                      Colors.blue),
                                ),
                              ),
                              Text('${(percent * 100).toInt()}%',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18)),
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
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const RewardRedeemModal(startWithEarnPoints: true),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            backgroundColor: const Color(0xff7AA3CC),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            elevation: 0,
                          ),
                          child: const Text('Earn Points',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black)),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const RewardRedeemModal(startWithEarnPoints: false),
                              ),
                            );
                          },
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            backgroundColor: Colors.white,
                            side: const BorderSide(color: Colors.black12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          child: const Text('View All Rewards',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black)),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 10),

            // ✅ Scrollable section (only this part scrolls)
            Expanded(
              child: SingleChildScrollView(
                padding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Upcoming Reward
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text('Upcoming Reward',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w500)),
                    ),
                    const SizedBox(height: 10),

                    Container(
                      height: 142,
                      width: double.infinity,
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Business Name',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w500)),
                          const SizedBox(height: 6),
                          const Text('Next Reward: Free Coffee',
                              style: TextStyle(fontSize: 14)),
                          const SizedBox(height: 10),
                          const Text('Just 10 points away!',
                              style: TextStyle(
                                  fontSize: 12, color: Colors.black87)),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              Expanded(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: LinearProgressIndicator(
                                    value: percent,
                                    minHeight: 16,
                                    backgroundColor: Colors.grey.shade200,
                                    valueColor: const AlwaysStoppedAnimation(
                                        Color(0xff7AA3CC)),
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
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text('Recent Activity',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w500)),
                    ),
                    const SizedBox(height: 8),

                    const ActivityItem(
                      icon: Icons.add_circle,
                      color: Colors.green,
                      text: "5 Point earned at Cafe ABC",
                      date: "12 Oct 2025",
                    ),
                    const ActivityItem(
                      icon: Icons.card_giftcard,
                      color: Colors.black,
                      text: "Reward 'Free Coffee' redeemed",
                      date: "10 Oct 2025",
                    ),
                    const ActivityItem(
                      icon: Icons.label,
                      color: Colors.black,
                      text: "10 Points earned at store B",
                      date: "09 Oct 2025",
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

  const ActivityItem({
    super.key,
    required this.icon,
    required this.color,
    required this.text,
    required this.date,
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
                    style: const TextStyle(
                        fontWeight: FontWeight.w600, fontSize: 16)),
                const SizedBox(height: 4),
                Text(date,
                    style: const TextStyle(color: Colors.black, fontSize: 12)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
