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
      "imageUrl":
      "https://images.unsplash.com/photo-1554118811-1e0d58224f24?w=100&h=100&fit=crop&crop=center"
    },
    {
      "title": "Free Coffee Redeemed",
      "subtitle": "Used 100 points",
      "date": "12 Oct 2025",
      "type": "redeem",
      "id": "",
      "status": "Complete",
      "imageUrl":
      "https://images.unsplash.com/photo-1544787219-7f47ccb76574?w=100&h=100&fit=crop&crop=center"
    },
    {
      "title": "Cafe Name",
      "subtitle": "Earned 5 points",
      "date": "12 Oct 2025",
      "type": "earn",
      "id": "#TXN-9282",
      "status": "",
      "imageUrl":
      "https://images.unsplash.com/photo-1554118811-1e0d58224f24?w=100&h=100&fit=crop&crop=center"
    },
    {
      "title": "Free Coffee Redeemed",
      "subtitle": "Used 100 points",
      "date": "12 Oct 2025",
      "type": "redeem",
      "id": "",
      "status": "Completed",
      "imageUrl":
      "https://images.unsplash.com/photo-1544787219-7f47ccb76574?w=100&h=100&fit=crop&crop=center"
    },
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final sw = MediaQuery.of(context).size.width;
    final isDesktop = sw >= 900;

    Widget buildCard(Map<String, dynamic> tx) {
      return Container(
        height: 115,
        margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
        decoration: BoxDecoration(
          color: isDark ? Colors.black12 : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isDark ? Colors.grey.shade700 : Colors.grey.shade300,
            width: 1.0,
          ),
          boxShadow: [
            BoxShadow(
              color: isDark ? Colors.black26 : Colors.grey.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Image
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
                  const SizedBox(width: 10),
                  // Title & subtitle
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          tx["title"],
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: theme.textTheme.bodyMedium?.color),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          tx["subtitle"],
                          style: TextStyle(
                              color: theme.textTheme.bodySmall?.color?.withOpacity(0.7),
                              fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10), // ✅ added spacing between text and date
                  // Date
                  Text(
                    tx["date"],
                    style: TextStyle(
                      fontSize: 12,
                      color: theme.textTheme.bodySmall?.color,
                    ),
                  ),
                ],
              ),
              if (tx["id"].isNotEmpty) ...[
                const SizedBox(height: 6),
                Text(
                  "Transaction ID: ${tx["id"]}",
                  style: const TextStyle(color: Color(0xFFE53935), fontSize: 12),
                ),
              ],
              if (tx["status"].isNotEmpty) ...[
                const SizedBox(height: 4),
                Text(
                  "Status: ${tx["status"]}",
                  style: const TextStyle(color: Color(0xFF43A047), fontSize: 12),
                ),
              ],
            ],
          ),
        ),
      );
    }

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
                  Align(
                    alignment: Alignment.center,
                    child: const Text(
                      "Transaction History",
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Center(
                child: SizedBox(
                  width: 800,
                  child: GridView.builder(
                    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 12,
                      crossAxisSpacing: 12,
                      childAspectRatio: 2.2,
                    ),
                    itemCount: transactions.length,
                    itemBuilder: (context, index) => buildCard(transactions[index]),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }

    // Mobile layout
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text("Transaction History"),
        backgroundColor: theme.scaffoldBackgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: theme.textTheme.bodyMedium?.color),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        itemCount: transactions.length,
        separatorBuilder: (context, index) => const SizedBox(height: 8), // ✅ spacing between items
        itemBuilder: (context, index) => buildCard(transactions[index]),
      ),
    );
  }
}
