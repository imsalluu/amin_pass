import 'package:amin_pass/common/screen/bottom_nav_bar.dart';
import 'package:flutter/material.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar:BottomNavController(),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top profile section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const CircleAvatar(
                        radius: 25,
                        backgroundImage:
                        NetworkImage('https://via.placeholder.com/150'),
                      ),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text("Hi, Jane!",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold)),
                          Text("What's up",
                              style: TextStyle(color: Colors.grey)),
                        ],
                      ),
                    ],
                  ),
                  const Icon(Icons.notifications_none, size: 28),
                ],
              ),

              const SizedBox(height: 25),

              // Points Card
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFFF2E2A9),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Row(
                          children: [
                            Icon(Icons.check_circle, color: Colors.green),
                            SizedBox(width: 8),
                            Text("Points",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold)),
                          ],
                        ),
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            SizedBox(
                              height: 45,
                              width: 45,
                              child: CircularProgressIndicator(
                                value: 0.7,
                                strokeWidth: 6,
                                backgroundColor: Colors.white,
                                valueColor:
                                AlwaysStoppedAnimation(Colors.teal),
                              ),
                            ),
                            const Text(
                              "70%",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 14),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      "70",
                      style:
                      TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                    ),
                    const Text(
                      "You need 30 more points to get your next reward",
                      style: TextStyle(color: Colors.grey),
                    ),
                    const SizedBox(height: 15),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFD4AF37),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                            child: const Text("Earn Points",
                                style: TextStyle(color: Colors.white)),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () {},
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(color: Color(0xFFD4AF37)),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                            child: const Text("View All Rewards",
                                style: TextStyle(color: Colors.black)),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 25),

              // Upcoming Reward
              const Text(
                "Upcoming Reward",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Business Name",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16)),
                    const Text("Next Reward: Free Coffee",
                        style: TextStyle(color: Colors.black87)),
                    const SizedBox(height: 8),
                    const Text("Just 10 points away!",
                        style: TextStyle(color: Colors.grey)),
                    const SizedBox(height: 8),
                    LinearProgressIndicator(
                      value: 0.9,
                      backgroundColor: Colors.grey.shade300,
                      color: const Color(0xFFD4AF37),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 25),

              // Recent Activity
              const Text(
                "Recent Activity",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              const SizedBox(height: 10),
              const ActivityItem(
                icon: Icons.add_circle,
                color: Colors.green,
                text: "5 Point earned at Cafe ABC",
                date: "12 Oct 2025",
              ),
              const ActivityItem(
                icon: Icons.card_giftcard,
                color: Colors.amber,
                text: "Reward ‘Free Coffee’ redeemed",
                date: "10 Oct 2025",
              ),
              const ActivityItem(
                icon: Icons.store,
                color: Colors.black,
                text: "10 Points earned at store B",
                date: "09 Oct 2025",
              ),
            ],
          ),
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
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(text,
                    style: const TextStyle(fontWeight: FontWeight.w500)),
                Text(date, style: const TextStyle(color: Colors.grey)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
