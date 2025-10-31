import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class LoyaltyCardScreen extends StatelessWidget {
  const LoyaltyCardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final sw = MediaQuery.of(context).size.width;
    const desktopBreakpoint = 900;
    final isDesktop = sw >= desktopBreakpoint;

    // 🔹 Main content (Loyalty Card)
    final cardContent = Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 18, vertical: 40),
      decoration: BoxDecoration(
        color: const Color(0xFF7AA3CC),
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.symmetric(vertical: 34, horizontal: 18),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // 🔹 Top Row (Shop info + points)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const CircleAvatar(
                    radius: 14,
                    backgroundImage: NetworkImage(
                      'https://cdn-icons-png.flaticon.com/512/1046/1046784.png',
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    "Coffee Shop",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              const Text(
                "Points 250",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: Colors.black,
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),

          // 🔹 Network Image (Safe)
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              'https://img.freepik.com/free-vector/loyalty-program-illustration_335657-3389.jpg',
              height: 100,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                height: 100,
                color: Colors.grey.shade200,
                alignment: Alignment.center,
                child: const Icon(Icons.image_not_supported, size: 30),
              ),
            ),
          ),

          const SizedBox(height: 10),

          // 🔹 Reward Name + Status
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                "Reward Name",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                "Status",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // 🔹 QR Code (centered)
          QrImageView(
            data: "https://example.com/qrcode",
            version: QrVersions.auto,
            size: 110,
            backgroundColor: Colors.white,
          ),
        ],
      ),
    );

    // 💻 Desktop/Web Layout
    if (isDesktop) {
      return Scaffold(
        backgroundColor:
        isDark ? theme.colorScheme.background : const Color(0xFFF5F7FA),
        body: Column(
          children: [
            // 🔸 Top Blue Header
            Container(
              height: 80,
              width: double.infinity,
              color: const Color(0xFF7AA3CC),
              alignment: Alignment.center,
              child: const Text(
                "Loyalty Card",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),

            // 🔸 Centered card (no background container)
            Expanded(
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 600),
                  child: cardContent,
                ),
              ),
            ),
          ],
        ),
      );
    }

    // 📱 Mobile Layout (unchanged)
    return Scaffold(
      backgroundColor: isDark ? theme.colorScheme.background : Colors.white,
      appBar: AppBar(
        title: Text(
          "Loyalty Card",
          style: TextStyle(
            color: isDark ? Colors.white : Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        backgroundColor: theme.scaffoldBackgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: theme.iconTheme.color),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
      ),
      body: cardContent,
    );
  }
}
