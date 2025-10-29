// bottom_nav_controller.dart
import 'package:amin_pass/card/screen/loyalty_card_screen.dart';
import 'package:amin_pass/profile/screen/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:amin_pass/home/screen/home_screen.dart';
import 'package:amin_pass/rewards/rewards_screen.dart';

class BottomNavController extends StatefulWidget {
  const BottomNavController({super.key});

  @override
  State<BottomNavController> createState() => _BottomNavControllerState();
}

class _BottomNavControllerState extends State<BottomNavController>
    with AutomaticKeepAliveClientMixin {
  int _currentIndex = 0;

  late bool startWithEarnPoints;

  @override
  void initState() {
    super.initState();
    startWithEarnPoints = true;
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    final List<Widget> _screens = [
      HomeScreen(onRewardButtonTap: (isEarnPoints) {
        setState(() {
          _currentIndex = 1; // Rewards tab index
          startWithEarnPoints = isEarnPoints;
        });
      }),
      RewardRedeemModal(
        key: ValueKey(startWithEarnPoints), // ✅ force rebuild when value changes
        startWithEarnPoints: startWithEarnPoints,
      ),
      LoyaltyCardScreen(),
      ProfileScreen(),
    ];


    return Scaffold(
      extendBody: true,
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(12, 0, 12, 14),
        child: Container(
        height: 90,
        decoration: BoxDecoration(
          color: Colors.white, // <-- change from Colors.black
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1), // lighter shadow
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(25),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.white, // <-- change from Colors.black
            elevation: 0,
            currentIndex: _currentIndex,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            selectedItemColor: const Color(0xFF80BFFF), // keep active color
            unselectedItemColor: Colors.black54, // adjust unselected to contrast white
            onTap: (index) {
              if (_currentIndex != index) {
                setState(() {
                  _currentIndex = index;
                });
              }
            },
            items: [
              _buildBarItem(
                icon: Icons.home_outlined,
                activeIcon: Icons.home,
                label: 'Home',
                isActive: _currentIndex == 0,
              ),
              _buildBarItem(
                icon: Icons.card_giftcard_outlined,
                activeIcon: Icons.card_giftcard,
                label: 'Rewards',
                isActive: _currentIndex == 1,
              ),
              _buildBarItem(
                icon: Icons.credit_card_outlined,
                activeIcon: Icons.credit_card,
                label: 'Card',
                isActive: _currentIndex == 2,
              ),
              _buildBarItem(
                icon: Icons.person_outline,
                activeIcon: Icons.person,
                label: 'Profile',
                isActive: _currentIndex == 3,
              ),
            ],
          ),
        ),
      ),

    ),
    );
  }

  BottomNavigationBarItem _buildBarItem({
    required IconData icon,
    required IconData activeIcon,
    required String label,
    required bool isActive,
  }) {
    return BottomNavigationBarItem(
      icon: _NavIcon(
        icon: icon,
        activeIcon: activeIcon,
        active: isActive,
        label: label,
      ),
      label: '',
    );
  }
}

class _NavIcon extends StatelessWidget {
  final IconData icon;
  final IconData activeIcon;
  final bool active;
  final String label;

  const _NavIcon({
    required this.icon,
    required this.activeIcon,
    required this.active,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    final Color activeColor = const Color(0xFF80BFFF);
    final Color inactiveColor = Colors.black; // for white background

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          decoration: BoxDecoration(
            color: active ? activeColor.withOpacity(0.2) : Colors.transparent,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Icon(
            active ? activeIcon : icon,
            color: active ? activeColor : inactiveColor, // updated
            size: 24,
          ),
        ),
        if (active)
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Text(
              label,
              style: TextStyle(
                color: activeColor,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
      ],
    );
  }
}
