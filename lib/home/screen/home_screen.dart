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

    final mq = MediaQuery.of(context);
    final sw = mq.size.width;
    const desktopBreakpoint = 900;
    final isDesktop = sw >= desktopBreakpoint;

    // central max width for desktop/tablet
    final contentMaxWidth = isDesktop ? 1050.0 : double.infinity;

    return Scaffold(
      backgroundColor: Colors.grey.shade800, // outer frame color like screenshot
      body: SafeArea(
        child: Row(
          children: [
            // left slim sidebar for desktop
            // main area
            Expanded(
              child: Center(
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: contentMaxWidth),
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 18, horizontal: 12),
                    // central card that mimics screenshot frame
                    decoration: BoxDecoration(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: _buildInnerContent(context, isDark),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }


  Widget _buildInnerContent(BuildContext context, bool isDark) {
    final theme = Theme.of(context);
    // We'll create a top blue header band that visually matches the screenshot,
    // and then content sections below it.
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Top blue header area (with rounded top corners)
        Container(
          decoration: const BoxDecoration(
            color: Color(0xFF8DAFE8), // bluish header
            borderRadius: BorderRadius.only(topLeft: Radius.circular(8), topRight: Radius.circular(8)),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Row(
            children: [
              // avatar + greeting
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
                    Text('Hi, Jane!',
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700, color: theme.textTheme.bodyLarge?.color)),
                    const SizedBox(height: 2),
                    Text("What's up", style: TextStyle(color: theme.textTheme.bodyMedium?.color)),
                  ],
                ),
              ),
              // small bell icon on header right
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.notifications_none, size: 28, color: theme.iconTheme.color),
              ),
            ],
          ),
        ),

        // Main content area (white) overlapping slightly to create card feel
        // We'll use negative margin by wrapping in a container and pushing it up using transform.
        Transform.translate(
          offset: const Offset(0, -12),
          child: Container(
            padding: const EdgeInsets.fromLTRB(20, 18, 20, 20),
            decoration: BoxDecoration(
              color: theme.scaffoldBackgroundColor,
              borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(8), bottomRight: Radius.circular(8)),
            ),
            child: Column(
              children: [
                // Points card (light blue rounded card) — placed over the white content
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xFF8DBAE9),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    children: [
                      // left texts
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: const [
                              Icon(Icons.check_circle, color: Colors.green),
                              SizedBox(width: 8),
                              Text('Points', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black)),
                            ],
                          ),
                          const SizedBox(height: 6),
                          Text('$points', style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.black)),
                          const SizedBox(height: 6),
                          SizedBox(
                            width: 180,
                            child: Text('You need ${100 - 70} more points to get your next reward',
                                style: TextStyle(fontSize: 12, color: isDark ? Colors.black : Colors.black)),
                          ),
                        ],
                      ),
                      const Spacer(),
                      // circular progress
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
                                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.black)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 12),

                // Buttons row
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          widget.onRewardButtonTap(true); // Earn Points
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          backgroundColor: const Color(0xff7AA3CC),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                          elevation: 0,
                        ),
                        child: Text('Earn Points', style: TextStyle(fontWeight: FontWeight.bold, color: isDark ? Colors.black : Colors.black)),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          widget.onRewardButtonTap(false); // View All Rewards
                        },
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          backgroundColor: isDark ? Colors.grey.shade900 : Colors.white,
                          side: BorderSide(color: isDark ? Colors.white24 : Colors.black12),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                        ),
                        child: Text('View All Rewards',
                            style: TextStyle(fontWeight: FontWeight.bold, color: isDark ? Colors.white : Colors.black)),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 18),

                // Row with Upcoming Reward (left) and Recent Activity (right)
                // On small screens this will stack vertically, on wide screens it's a Row
                LayoutBuilder(builder: (context, constraints) {
                  final isWide = constraints.maxWidth > 700;
                  return isWide
                      ? Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Left: Upcoming Reward
                      Expanded(child: _upcomingRewardBlock(isDark, theme)),
                      const SizedBox(width: 20),
                      // Right: Recent Activity
                      Expanded(child: _recentActivityBlock(isDark, theme)),
                    ],
                  )
                      : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _upcomingRewardBlock(isDark, theme),
                      const SizedBox(height: 14),
                      _recentActivityBlock(isDark, theme),
                    ],
                  );
                }),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _upcomingRewardBlock(bool isDark, ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Upcoming Reward', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: theme.textTheme.bodyLarge?.color)),
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
              Text('Business Name', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: theme.textTheme.bodyLarge?.color)),
              const SizedBox(height: 6),
              Text('Next Reward: Free Coffee', style: TextStyle(fontSize: 14, color: theme.textTheme.bodyMedium?.color)),
              const SizedBox(height: 10),
              Text('Just 10 points away!', style: TextStyle(fontSize: 12, color: isDark ? Colors.white70 : Colors.black87)),
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
      ],
    );
  }

  Widget _recentActivityBlock(bool isDark, ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Recent Activity', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: theme.textTheme.bodyLarge?.color)),
        const SizedBox(height: 8),
        ActivityItem(icon: Icons.add_circle, color: Colors.green, text: "5 Point earned at Cafe ABC", date: "12 Oct 2025", isDark: isDark),
        ActivityItem(icon: Icons.card_giftcard, color: isDark ? Colors.white : Colors.black, text: "Reward 'Free Coffee' redeemed", date: "10 Oct 2025", isDark: isDark),
        ActivityItem(icon: Icons.label, color: isDark ? Colors.white : Colors.black, text: "10 Points earned at store B", date: "09 Oct 2025", isDark: isDark),
      ],
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
                Text(text, style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16, color: isDark ? Colors.white : Colors.black)),
                const SizedBox(height: 4),
                Text(date, style: TextStyle(color: isDark ? Colors.white70 : Colors.black, fontSize: 12)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
