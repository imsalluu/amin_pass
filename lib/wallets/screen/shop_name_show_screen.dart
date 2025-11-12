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

    final List<Map<String, dynamic>> shops = [
      {
        'name': 'Starbucks',
        'logo':
        'https://1000logos.net/wp-content/uploads/2017/02/Starbucks-Logo.png',
      },
      {
        'name': 'Nike',
        'logo':
        'https://1000logos.net/wp-content/uploads/2017/03/Nike-Logo.png',
      },
      {
        'name': 'Apple',
        'logo':
        'https://1000logos.net/wp-content/uploads/2016/10/Apple-Logo.png',
      },
      {
        'name': 'Amazon',
        'logo':
        'https://1000logos.net/wp-content/uploads/2016/10/Amazon-logo.png',
      },
      {
        'name': 'Adidas',
        'logo':
        'https://1000logos.net/wp-content/uploads/2017/05/Adidas-logo.png',
      },
      {
        'name': 'Netflix',
        'logo':
        'https://1000logos.net/wp-content/uploads/2017/05/Netflix-Logo.png',
      },
      {
        'name': 'McDonald\'s',
        'logo':
        'https://1000logos.net/wp-content/uploads/2017/03/McDonalds-logo.png',
      },
      {
        'name': 'Zara',
        'logo':
        'https://1000logos.net/wp-content/uploads/2017/05/Zara-logo.png',
      },
    ];

    // 🔹 Shop card widget
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
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: isDark ? Colors.grey.shade800 : Colors.white,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color:
                    isDark ? Colors.grey.shade700 : Colors.grey.shade300,
                    width: 0.8,
                  ),
                ),
                padding: const EdgeInsets.all(5), // ✅ smaller logo inside
                child: ClipOval(
                  child: Image.network(
                    shop['logo'],
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) => Icon(
                      Icons.storefront,
                      size: 20,
                      color: isDark ? Colors.white54 : Colors.black54,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  shop['name'],
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                    color: isDark ? Colors.white : Colors.black,
                  ),
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                size: 16,
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
        backgroundColor:
        isDark ? theme.colorScheme.background : const Color(0xFFF5F7FA),
        body: Column(
          children: [
            // Header
            Container(
              height: 80,
              width: double.infinity,
              color: const Color(0xFF7AA3CC),
              alignment: Alignment.center,
              child: const Text(
                "Cards",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
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
                    color: isDark ? Colors.grey.shade900 : Colors.white,
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
