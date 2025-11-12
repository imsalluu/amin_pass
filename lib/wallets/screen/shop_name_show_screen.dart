import 'package:amin_pass/wallets/screen/add_to_wallet_screen.dart';
import 'package:flutter/material.dart';

class ShopNameShowScreen extends StatefulWidget {
  const ShopNameShowScreen({super.key});

  @override
  State<ShopNameShowScreen> createState() => _ShopNameShowScreenState();
}

class _ShopNameShowScreenState extends State<ShopNameShowScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final sw = MediaQuery.of(context).size.width;
    const desktopBreakpoint = 900;
    final isDesktop = sw >= desktopBreakpoint;

    // Mock data — replace with API later
    final List<Map<String, dynamic>> shops = [
      {
        'name': 'Coffee Shop',
        'logo': 'https://cdn-icons-png.flaticon.com/512/1046/1046784.png',
      },
      {
        'name': 'Gym Center',
        'logo': 'https://cdn-icons-png.flaticon.com/512/2965/2965567.png',
      },
      {
        'name': 'Bakery House',
        'logo': 'https://cdn-icons-png.flaticon.com/512/4069/4069153.png',
      },
    ];

    // 🔹 Shop card
    Widget buildShopCard(Map<String, dynamic> shop) {
      return GestureDetector(
        onTap: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => AddToWalletScreen(shopName: shop['name']),
            ),
          );
        },
        child: Container(
          margin: const EdgeInsets.only(bottom: 16),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: isDark ? Colors.grey.shade900 : Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isDark ? Colors.grey.shade700 : Colors.grey.shade300,
            ),
            boxShadow: [
              if (!isDark)
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 8,
                  offset: const Offset(0, 3),
                ),
            ],
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 28,
                backgroundColor: isDark ? Colors.grey.shade800 : Colors.white,
                backgroundImage: NetworkImage(shop['logo']),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  shop['name'],
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: isDark ? Colors.white : Colors.black,
                  ),
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                size: 18,
                color: isDark ? Colors.white70 : Colors.black54,
              ),
            ],
          ),
        ),
      );
    }

    // 🔹 Shop list
    final shopList = ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      itemCount: shops.length,
      itemBuilder: (context, index) => buildShopCard(shops[index]),
    );

    // 💻 Desktop layout
    if (isDesktop) {
      return Scaffold(
        backgroundColor: isDark
            ? theme.colorScheme.background
            : const Color(0xFFF5F7FA), // neutral light tone
        body: Column(
          children: [
            // Header bar
            Container(
              height: 80,
              width: double.infinity,
              color: const Color(0xFF7AA3CC),
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: const Align(
                alignment: Alignment.center,
                child: Text(
                  "Cards",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: Container(
                  constraints: const BoxConstraints(maxWidth: 600),
                  margin:
                  const EdgeInsets.symmetric(horizontal: 40, vertical: 30),
                  decoration: BoxDecoration(
                    // ✅ fixed color to remove red tint
                    color: isDark
                        ? Colors.grey.shade900
                        : Colors.white, // explicitly white for light mode
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: isDark
                          ? Colors.grey.shade800.withOpacity(0.3)
                          : Colors.grey.shade300,
                    ),
                    boxShadow: [
                      if (!isDark)
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 3),
                        ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: shopList,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }

    // 📱 Mobile layout
    return Scaffold(
      backgroundColor: isDark ? theme.colorScheme.background : Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: isDark ? theme.colorScheme.background : Colors.white,
        elevation: 0.4,
        centerTitle: true,
        title: Text(
          "Cards",
          style: TextStyle(
            color: isDark ? Colors.white : Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: shopList,
    );
  }
}
