import 'package:flutter/material.dart';


class RewardRedeemModal extends StatefulWidget {
  const RewardRedeemModal({super.key});

  @override
  State<RewardRedeemModal> createState() => _RewardRedeemModalState();
}

class _RewardRedeemModalState extends State<RewardRedeemModal> {
  bool showEarnPoints = true;
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
      'claimed': true,
    },
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
      'title': 'Free Latte',
      'desc': 'Redeem for 100 points',
      'expire': '30 Nov 2025',
      'points': 100,
      'imageUrl':
      'https://images.unsplash.com/photo-1509042239860-f550ce710b93?w=600',
      'claimed': false,
    },
  ];

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
          'Reward Redeem Modal',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => showEarnPoints = true),
                    child: Container(
                      height: 40,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black12),
                        color: showEarnPoints
                            ? const Color(0xFF7AA3CC)
                            : Colors.white,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Text(
                        'Earn Points',
                        style: TextStyle(
                          fontSize: 14,
                          color: showEarnPoints
                              ? Colors.black
                              : Colors.black87,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => showEarnPoints = false),
                    child: Container(
                      height: 40,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black12),
                        color: showEarnPoints
                            ? Colors.white
                            : const Color(0xFF7AA3CC),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Text(
                        'View All Rewards',
                        style: TextStyle(
                          fontSize: 14,
                          color: showEarnPoints
                              ? Colors.black87
                              : Colors.black,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: showEarnPoints
                  ? EarnPointsTab(earnPoints: earnPoints)
                  : ViewAllRewardsTab(
                userPoints: userPoints,
                rewards: rewards,
              ),
            ),
          ],
        ),
      ),
    );
  }
}



class EarnPointsTab extends StatelessWidget {
  final List<Map<String, dynamic>> earnPoints;

  const EarnPointsTab({super.key, required this.earnPoints});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: earnPoints.length,
      itemBuilder: (context, index) {
        final item = earnPoints[index];
        return Container(
          height: 159,
          width: 408,
          margin: const EdgeInsets.symmetric(vertical: 6),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black12),
            borderRadius: BorderRadius.circular(24),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: Image.network(
                  item['imageUrl'] ?? 'https://via.placeholder.com/150',
                  width: 124,
                  height: 124,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item['title'] ?? '',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15.5,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      item['desc'] ?? '',
                      style: const TextStyle(
                        fontSize: 13,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              Text(
                'Earn ${item['points']}',
                style: const TextStyle(
                  color: Color(0xFF357ABD),
                  fontWeight: FontWeight.w600,
                  fontSize: 13.5,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}



class ViewAllRewardsTab extends StatefulWidget {
  final int userPoints;
  final List<Map<String, dynamic>> rewards;

  const ViewAllRewardsTab({
    super.key,
    required this.userPoints,
    required this.rewards,
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
    return Column(
      children: [
        // Points counter
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const Icon(Icons.monetization_on, color: Colors.amber, size: 20),
            const SizedBox(width: 6),
            const Text(
              'Your Points',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
            ),
            const SizedBox(width: 6),
            Text(
              '$userPoints',
              style: const TextStyle(
                  fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Expanded(
          child: ListView.builder(
            itemCount: widget.rewards.length,
            itemBuilder: (context, index) {
              final item = widget.rewards[index];
              return Container(
                height: 159,
                width: 408,
                margin: const EdgeInsets.symmetric(vertical: 6),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black12),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(24),
                      child: Image.network(
                        item['imageUrl'] ?? 'https://via.placeholder.com/150',
                        width: 124,
                        height: 124,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item['title'] ?? '',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15.5,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            item['desc'] ?? '',
                            style: const TextStyle(
                              fontSize: 13,
                              color: Colors.black,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 4),
                            child: Text(
                              'Expire Date: ${item['expire']}',
                              style: const TextStyle(
                                fontSize: 12.5,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 10),
                    GestureDetector(
                      onTap: item['claimed'] == true
                          ? null
                          : () {
                        if (userPoints >= item['points']) {
                          setState(() {
                            userPoints = item['points'];
                            item['claimed'] = true;
                          });
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Not enough points!'),
                              backgroundColor: Colors.redAccent,
                            ),
                          );
                        }
                      },
                      child: Container(
                        width: 110,
                        height: 40,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: item['claimed'] == true
                              ? Colors.grey
                              : const Color(0xFF7AA3CC),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Text(
                          item['claimed'] == true ? 'Claimed' : 'Claim',
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
