import 'package:amin_pass/auth/screen/sign_up_screen.dart';
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

        // Auto navigate when scanned successfully
        if (widget.onScanned != null) {
          widget.onScanned!(code);
          Navigator.pop(context, code); // Return scanned data
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
    final scanBoxSize = 250.0;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Camera view
            MobileScanner(
              controller: cameraController,
              onDetect: _onDetect,
            ),

            // Transparent mask around scan box
            ColorFiltered(
              colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.5),
                BlendMode.srcOut,
              ),
              child: Stack(
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      color: Colors.black,
                      backgroundBlendMode: BlendMode.dstOut,
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      height: scanBoxSize,
                      width: scanBoxSize,
                      decoration: BoxDecoration(
                        color: Colors.white,
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
                border: Border.all(color: Color(0xFF7AA3CC), width: 3),
              ),
            ),

            // Animated red scanning line
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
                    color: Color(0xFF7AA3CC),
                  ),
                );
              },
            ),

            // Header
            Positioned(
              top: 20,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.black),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const Text(
                    'Scan Shop QR Code',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(width: 48),
                ],
              ),
            ),

            // Manual Next Button (if auto-navigate is not preferred)
            // ✅ Next Button (Fixed)
            if (widget.onScanned == null)
              Positioned(
                bottom: 40,
                left: 40,
                right: 40,
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
                    backgroundColor: scannedCode == null
                        ? Colors.grey
                        : const Color(0xFF7AA3CC),
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
          ],
        ),
      ),
    );
  }
}