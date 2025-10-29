import 'package:amin_pass/auth/screen/sign_up_screen.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class QRScannerScreen extends StatefulWidget {
  final Function(String)? onScanned;

  const QRScannerScreen({super.key, this.onScanned});

  @override
  State<QRScannerScreen> createState() => _QRScannerScreenState();
}

class _QRScannerScreenState extends State<QRScannerScreen>
    with SingleTickerProviderStateMixin {
  final MobileScannerController cameraController = MobileScannerController();
  late AnimationController _animationController;
  String? scannedCode;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _animationController.dispose();
    cameraController.dispose();
    super.dispose();
  }

  void _onDetect(BarcodeCapture capture) {
    for (final barcode in capture.barcodes) {
      final code = barcode.rawValue;
      if (code != null && scannedCode != code) {
        setState(() {
          scannedCode = code;
        });

        if (widget.onScanned != null) {
          widget.onScanned!(code);
          Navigator.pop(context, code);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Scanned: $code')),
          );
          cameraController.stop();
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor = isDarkMode ? Colors.black : Colors.white;
    final iconColor = isDarkMode ? Colors.white : Colors.black;
    final borderColor = const Color(0xFF7AA3CC);
    final size = MediaQuery.of(context).size;
    final isWeb = kIsWeb || size.width >= 1024;

    final scanBoxSize = isWeb ? 300.0 : 250.0;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Camera view
            MobileScanner(
              controller: cameraController,
              onDetect: _onDetect,
            ),

            // Overlay mask
            ColorFiltered(
              colorFilter: ColorFilter.mode(
                isDarkMode
                    ? Colors.white.withOpacity(0.5)
                    : Colors.black.withOpacity(0.5),
                BlendMode.srcOut,
              ),
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: isDarkMode ? Colors.white : Colors.black,
                      backgroundBlendMode: BlendMode.dstOut,
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      height: scanBoxSize,
                      width: scanBoxSize,
                      decoration: BoxDecoration(
                        color: backgroundColor,
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Red border box
            Container(
              height: scanBoxSize,
              width: scanBoxSize,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: borderColor, width: 3),
              ),
            ),

            // Animated scanning line
            AnimatedBuilder(
              animation: _animationController,
              builder: (context, child) {
                return Positioned(
                  top: MediaQuery.of(context).size.height * 0.5 -
                      (scanBoxSize / 2) +
                      (scanBoxSize * _animationController.value),
                  child: Container(
                    height: 2,
                    width: scanBoxSize - 20,
                    color: borderColor,
                  ),
                );
              },
            ),

            // Header
            Positioned(
              top: 20,
              left: 0,
              right: 0,
              child: Center(
                child: Container(
                  width: isWeb ? 400 : double.infinity,
                  margin: isWeb
                      ? const EdgeInsets.symmetric(horizontal: 24)
                      : null,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: Icon(Icons.close, color: iconColor),
                        onPressed: () => Navigator.pop(context),
                      ),
                      Text(
                        'Scan Shop QR Code',
                        style: TextStyle(
                          color: iconColor,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(width: 48),
                    ],
                  ),
                ),
              ),
            ),

            // Manual Next Button
            if (widget.onScanned == null)
              Positioned(
                bottom: 40,
                left: isWeb ? size.width / 2 - 200 : 40,
                right: isWeb ? size.width / 2 - 200 : 40,
                child: SizedBox(
                  width: isWeb ? 400 : double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SignUpScreen(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                      scannedCode == null ? Colors.grey : borderColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: const Text(
                      'Use This Code',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
