import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:amin_pass/auth/screen/login_screen.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final TextEditingController _nameController = TextEditingController(text: "Jane");
  final TextEditingController _emailController = TextEditingController(text: "example@gmail.com");
  final TextEditingController _numberController = TextEditingController(text: "+880 1960679565");
  final TextEditingController _addressController = TextEditingController(text: "Dhaka, Bangladesh");

  File? _selectedImage;
  final ImagePicker _picker = ImagePicker();
  final String networkImageUrl = "https://example.com/your-image.jpg";

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _selectedImage = File(image.path);
      });
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _numberController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final sw = MediaQuery.of(context).size.width;
    final isDesktop = sw >= 900;

    final mainContent = SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
      child: Column(
        children: [
          // Profile Image Box
          Stack(
            children: [
              Container(
                width: 88,
                height: 88,
                decoration: BoxDecoration(
                  color: isDark ? Colors.grey.shade800 : const Color(0xFFF5F5F5),
                  border: Border.all(color: isDark ? Colors.grey.shade700 : Colors.grey.shade300, width: 1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: _selectedImage != null
                      ? Image.file(_selectedImage!, width: 120, height: 120, fit: BoxFit.cover)
                      : Image.network(
                    networkImageUrl,
                    width: 120,
                    height: 120,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Icon(Icons.person, size: 40, color: isDark ? Colors.grey.shade400 : Colors.grey);
                    },
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Center(
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(isDark ? Colors.grey.shade400 : Colors.grey),
                        ),
                      );
                    },
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: GestureDetector(
                  onTap: _pickImage,
                  child: Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: const Color(0xFF7AA3CC),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: const Icon(Icons.edit, color: Colors.white, size: 16),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Profile Fields
          _buildProfileField("Name", _nameController, hint: "Enter your name", isDark: isDark, isDesktop: isDesktop),
          const SizedBox(height: 16),
          _buildProfileField("Email Address", _emailController, hint: "Enter your email", keyboardType: TextInputType.emailAddress, isDark: isDark, isDesktop: isDesktop),
          const SizedBox(height: 16),
          _buildProfileField("Number", _numberController, hint: "Enter your phone number", keyboardType: TextInputType.phone, isDark: isDark, isDesktop: isDesktop),
          const SizedBox(height: 16),
          _buildProfileField("Address", _addressController, hint: "Enter your address", isDark: isDark, isDesktop: isDesktop),
          const SizedBox(height: 32),

          // Save Changes Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF7AA3CC),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              child: Text(
                'Save Changes',
                style: TextStyle(
                  color: isDark ? Colors.black : Colors.black,
                  fontSize: isDesktop ? 14 : 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );

    if (isDesktop) {
      // Desktop layout with top container including AppBar
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
                  // Centered title
                  Align(
                    alignment: Alignment.center,
                    child: const Text(
                      "Edit Profile",
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                  ),
                  // Back button
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
                child: SizedBox(width: 600, child: mainContent),
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
        title: Text(
          "Edit Profile",
          style: TextStyle(
            color: theme.textTheme.bodyLarge?.color,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: theme.scaffoldBackgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: theme.iconTheme.color),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
      ),
      body: mainContent,
    );
  }

  Widget _buildProfileField(String label, TextEditingController controller,
      {String hint = "",
        TextInputType keyboardType = TextInputType.text,
        required bool isDark,
        bool isDesktop = false}) {
    final fieldHeight = isDesktop ? 40.0 : 50.0;
    final fontSize = isDesktop ? 13.0 : 14.0;
    final contentPadding = isDesktop
        ? const EdgeInsets.symmetric(horizontal: 10, vertical: 8)
        : const EdgeInsets.symmetric(horizontal: 12, vertical: 14);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.w500, color: isDark ? Colors.white : Colors.black)),
        const SizedBox(height: 6),
        SizedBox(
          height: fieldHeight,
          child: TextFormField(
            controller: controller,
            keyboardType: keyboardType,
            style: TextStyle(color: isDark ? Colors.white : Colors.black, fontSize: fontSize),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: TextStyle(color: isDark ? Colors.grey.shade400 : Colors.grey, fontSize: fontSize),
              contentPadding: contentPadding,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: isDark ? Colors.grey.shade700 : Colors.grey),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Color(0xFF7AA3CC)),
              ),
              fillColor: isDark ? Colors.black12 : Colors.white,
              filled: true,
            ),
          ),
        ),
      ],
    );
  }
}
