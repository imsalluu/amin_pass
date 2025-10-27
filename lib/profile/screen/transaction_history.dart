import 'package:flutter/material.dart';

class TransactionHistoryScreen extends StatelessWidget {
  const TransactionHistoryScreen({super.key});

  final List<Map<String, dynamic>> transactions = const [
    {
      "title": "Cafe Name",
      "subtitle": "Earned 5 points",
      "date": "12 Oct 2025",
      "type": "earn",
      "id": "",
      "status": "",
      "imageUrl": "https://images.unsplash.com/photo-1554118811-1e0d58224f24?w=100&h=100&fit=crop&crop=center"
    },
    {
      "title": "Free Coffee Redeemed",
      "subtitle": "Used 100 points",
      "date": "12 Oct 2025",
      "type": "redeem",
      "id": "",
      "status": "Complete",
      "imageUrl": "https://images.unsplash.com/photo-1544787219-7f47ccb76574?w=100&h=100&fit=crop&crop=center"
    },
    {
      "title": "Cafe Name",
      "subtitle": "Earned 5 points",
      "date": "12 Oct 2025",
      "type": "earn",
      "id": "#TXN-9282",
      "status": "",
      "imageUrl": "https://images.unsplash.com/photo-1554118811-1e0d58224f24?w=100&h=100&fit=crop&crop=center"
    },
    {
      "title": "Free Coffee Redeemed",
      "subtitle": "Used 100 points",
      "date": "12 Oct 2025",
      "type": "redeem",
      "id": "",
      "status": "Completed",
      "imageUrl": "https://images.unsplash.com/photo-1544787219-7f47ccb76574?w=100&h=100&fit=crop&crop=center"
    },
    {
      "title": "Cafe Name",
      "subtitle": "Earned 5 points",
      "date": "12 Oct 2025",
      "type": "earn",
      "id": "#TXN-9282",
      "status": "",
      "imageUrl": "https://images.unsplash.com/photo-1554118811-1e0d58224f24?w=100&h=100&fit=crop&crop=center"
    },
    {
      "title": "Free Coffee Redeemed",
      "subtitle": "Used 100 points",
      "date": "12 Oct 2025",
      "type": "redeem",
      "id": "",
      "status": "Completed",
      "imageUrl": "https://images.unsplash.com/photo-1544787219-7f47ccb76574?w=100&h=100&fit=crop&crop=center"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Transaction History"),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        titleTextStyle: const TextStyle(
          color: Colors.black,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: transactions.length,
        itemBuilder: (context, index) {
          final tx = transactions[index];
          return Container(
            height: 115,
            width: 408,
            margin: const EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: Colors.grey.shade300, // Gray color border
                width: 1.0, // Border width
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // First Row: Image + Title + Points + Date
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Network Image
                      Container(
                        width: 52,
                        height: 52,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          image: DecorationImage(
                            image: NetworkImage(tx["imageUrl"]),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),

                      // Title and Points
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              tx["title"],
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              tx["subtitle"],
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Date on the right side
                      Text(
                        tx["date"],
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),

                  // Second Row: Transaction ID (if exists)
                  if (tx["id"].isNotEmpty) ...[
                    const SizedBox(height: 8),
                    Text(
                      "Transaction ID: ${tx["id"]}",
                      style: const TextStyle(
                        color: Color(0xFFE53935),
                        fontSize: 12,
                      ),
                    ),
                  ],

                  // Third Row: Status (if exists)
                  if (tx["status"].isNotEmpty) ...[
                    const SizedBox(height: 4),
                    Text(
                      "Status: ${tx["status"]}",
                      style: const TextStyle(
                        color: Color(0xFF43A047),
                        fontSize: 12,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}