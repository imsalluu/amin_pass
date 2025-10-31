import 'package:flutter/material.dart';

class RewardRedeemModal extends StatefulWidget {
  final bool startWithEarnPoints;

  const RewardRedeemModal({super.key, this.startWithEarnPoints = true});

  @override
  State<RewardRedeemModal> createState() => _RewardRedeemModalState();
}

class _RewardRedeemModalState extends State<RewardRedeemModal> {
  late bool showEarnPoints;
  int userPoints = 120;

  final List<Map<String, dynamic>> earnPoints = [
    {
      'title': 'Midnight Mocha',
      'desc': 'A rich and indulgent blend of dark chocolate and bold espresso.',
      'points': 30,
      'imageUrl':
      'https://images.unsplash.com/photo-1509042239860-f550ce710b93?w=600',
    },
    {
      'title': 'Cappuccino Bliss',
      'desc': 'Smooth, creamy, and full of flavor. Earn while you sip!',
      'points': 40,
      'imageUrl':
      'https://images.unsplash.com/photo-1511920170033-f8396924c348?w=600',
    },
  ];

  final List<Map<String, dynamic>> rewards = [
    {
      'title': 'Free Latte',
      'desc': 'Redeem for 100 points',
      'expire': '30 Nov 2025',
      'points': 100,
      'imageUrl':
      'https://images.unsplash.com/photo-1509042239860-f550ce710b93?w=600',
      'claimed': false,
    },
    {
      'title': 'Iced Americano',
      'desc': 'Redeem for 120 points',
      'expire': '30 Nov 2025',
      'points': 120,
      'imageUrl':
      'https://images.unsplash.com/photo-1504674900247-0877df9cc836?w=600',
      'claimed': false,
    },
  ];

  @override
  void initState() {
    super.initState();
    showEarnPoints = widget.startWithEarnPoints;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final sw = MediaQuery.of(context).size.width;
    final isDesktop = sw >= 900;

    final mainContent = Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _tabButton(
                'Earn Points',
                showEarnPoints,
                    () => setState(() => showEarnPoints = true),
                isDark,
                isDesktop,
              ),
              SizedBox(width: isDesktop ? 12 : 20),
              _tabButton(
                'View All Rewards',
                !showEarnPoints,
                    () => setState(() => showEarnPoints = false),
                isDark,
                isDesktop,
              ),
            ],
          ),
          const SizedBox(height: 16),
          Expanded(
            child: showEarnPoints
                ? EarnPointsTab(
              earnPoints: earnPoints,
              isDark: isDark,
              isDesktop: isDesktop,
            )
                : ViewAllRewardsTab(
              userPoints: userPoints,
              rewards: rewards,
              isDark: isDark,
              isDesktop: isDesktop,
              onClaim: (points) =>
                  setState(() => userPoints -= points),
            ),
          ),
        ],
      ),
    );

    // Desktop layout
    if (isDesktop) {
      return Scaffold(
        backgroundColor: theme.scaffoldBackgroundColor,
        body: Column(
          children: [
            Container(
              height: 80,
              width: double.infinity,
              color: const Color(0xFF7AA3CC),
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Stack(
                children: [
                  const Center(
                    child: Text(
                      'Reward Redeem',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.notifications_none,
                          size: 28, color: Colors.black),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(child: mainContent),
          ],
        ),
      );
    }

    // Mobile layout
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: theme.scaffoldBackgroundColor,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new,
              color: isDark ? Colors.white : Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: Text(
          'Reward Redeem',
          style: TextStyle(
              color: isDark ? Colors.white : Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 16),
        ),
      ),
      body: mainContent,
    );
  }

  Widget _tabButton(
      String text, bool active, VoidCallback onTap, bool isDark, bool isDesktop) {
    return Expanded(
      flex: isDesktop ? 0 : 1,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: isDesktop ? 160 : double.infinity,
          height: 42,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(color: isDark ? Colors.white24 : Colors.black12),
            color: active ? const Color(0xFF7AA3CC) : Colors.transparent,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Text(
            text,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: active
                  ? Colors.black
                  : (isDark ? Colors.white : Colors.black87),
            ),
          ),
        ),
      ),
    );
  }
}

// ------------------- Earn Points Tab -------------------
class EarnPointsTab extends StatelessWidget {
  final List<Map<String, dynamic>> earnPoints;
  final bool isDark;
  final bool isDesktop;

  const EarnPointsTab({
    super.key,
    required this.earnPoints,
    required this.isDark,
    required this.isDesktop,
  });

  @override
  Widget build(BuildContext context) {
    final crossAxisCount = isDesktop ? 2 : 1;

    return Center(
      child: SizedBox(
        width: isDesktop ? 1000 : double.infinity,
        child: GridView.builder(
          padding: const EdgeInsets.symmetric(vertical: 6),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
            childAspectRatio: isDesktop ? 2.2 : 2.0,
          ),
          itemCount: earnPoints.length,
          itemBuilder: (context, index) {
            final item = earnPoints[index];
            return Container(
              width: double.infinity,
              height: 160, // ✅ Fixed height for mobile
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isDark ? Colors.black12 : Colors.white,
                border: Border.all(
                    color: isDark ? Colors.white24 : Colors.black12),
                borderRadius: BorderRadius.circular(24),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.network(
                      item['imageUrl'] ?? '',
                      width: 120,
                      height: 120,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 28),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(item['title'] ?? '',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17,
                                      color: isDark
                                          ? Colors.white
                                          : Colors.black)),
                              const SizedBox(height: 4),
                              Text(item['desc'] ?? '',
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: isDark
                                          ? Colors.white70
                                          : Colors.black)),
                            ],
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Text('Earn ${item['points']} pts',
                              style: const TextStyle(
                                  color: Color(0xFF357ABD),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 13.5)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

/// ------------------- View All Rewards Tab -------------------
class ViewAllRewardsTab extends StatefulWidget {
  final int userPoints;
  final List<Map<String, dynamic>> rewards;
  final Function(int) onClaim;
  final bool isDark;
  final bool isDesktop;

  const ViewAllRewardsTab({
    super.key,
    required this.userPoints,
    required this.rewards,
    required this.onClaim,
    required this.isDark,
    required this.isDesktop,
  });

  @override
  State<ViewAllRewardsTab> createState() => _ViewAllRewardsTabState();
}

class _ViewAllRewardsTabState extends State<ViewAllRewardsTab> {
  late int userPoints;

  @override
  void initState() {
    super.initState();
    userPoints = widget.userPoints;
  }

  @override
  Widget build(BuildContext context) {
    final isDark = widget.isDark;
    final isDesktop = widget.isDesktop;
    final crossAxisCount = isDesktop ? 2 : 1;

    return Center(
      child: SizedBox(
        width: isDesktop ? 1000 : double.infinity,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Icon(Icons.monetization_on,
                    color: Colors.amber, size: 20),
                const SizedBox(width: 6),
                Text('Your Points',
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: isDark ? Colors.white : Colors.black)),
                const SizedBox(width: 6),
                Text('$userPoints',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: isDark ? Colors.white : Colors.black)),
              ],
            ),
            const SizedBox(height: 10),
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.symmetric(vertical: 6),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                  childAspectRatio: isDesktop ? 2.2 : 2.0, // ✅ compact ratio
                ),
                itemCount: widget.rewards.length,
                itemBuilder: (context, index) {
                  final item = widget.rewards[index];
                  return Container(
                    width: double.infinity,
                    height: 120, // ✅ smaller height for mobile
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: isDark ? Colors.black12 : Colors.white,
                      border: Border.all(
                          color: isDark ? Colors.white24 : Colors.black12),
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween, // ✅ remove extra gap
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start, // vertical center
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: Image.network(
                                item['imageUrl'] ?? '',
                                width: isDesktop ? 120 : 120,
                                height: isDesktop ? 120 : 120,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center, // center vertically
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(item['title'] ?? '',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                          color: isDark
                                              ? Colors.white
                                              : Colors.black)),
                                  const SizedBox(height: 4),
                                  Text(
                                    item['desc'] ?? '',
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: isDark
                                            ? Colors.white70
                                            : Colors.black87),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Expire: ${item['expire']}',
                                style: TextStyle(
                                    fontSize: 12.5,
                                    color: isDark
                                        ? Colors.white70
                                        : Colors.grey)),
                            GestureDetector(
                              onTap: item['claimed'] == true
                                  ? null
                                  : () {
                                if (userPoints >= item['points']) {
                                  widget.onClaim(item['points']);
                                  setState(() => item['claimed'] = true);
                                } else {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(
                                    const SnackBar(
                                      content: Text('Not enough points!'),
                                      backgroundColor: Colors.redAccent,
                                    ),
                                  );
                                }
                              },
                              child: Container(
                                width: isDesktop ? 100 : 90,
                                height: 38,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: item['claimed'] == true
                                      ? Colors.grey
                                      : const Color(0xFF7AA3CC),
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Text(
                                  item['claimed'] == true
                                      ? 'Claimed'
                                      : 'Claim',
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 14.5,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
