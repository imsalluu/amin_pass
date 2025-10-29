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
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final List<Widget> _screens = [
      HomeScreen(onRewardButtonTap: (isEarnPoints) {
        setState(() {
          _currentIndex = 1; // Rewards tab index
          startWithEarnPoints = isEarnPoints;
        });
      }),
      RewardRedeemModal(
        key: ValueKey(startWithEarnPoints),
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
            color: isDark ? Colors.white : Colors.black87,
            borderRadius: BorderRadius.circular(25),
            boxShadow: [
              BoxShadow(
                color: isDark
                    ? Colors.black.withOpacity(0.2)
                    : Colors.black.withOpacity(0.3),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(25),
            child: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              backgroundColor: isDark ? Colors.white : Colors.black87,
              elevation: 0,
              currentIndex: _currentIndex,
              showSelectedLabels: false,
              showUnselectedLabels: false,
              selectedItemColor: const Color(0xFF80BFFF),
              unselectedItemColor: isDark ? Colors.black87 : Colors.white70,
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
                  isDark: isDark,
                ),
                _buildBarItem(
                  icon: Icons.card_giftcard_outlined,
                  activeIcon: Icons.card_giftcard,
                  label: 'Rewards',
                  isActive: _currentIndex == 1,
                  isDark: isDark,
                ),
                _buildBarItem(
                  icon: Icons.credit_card_outlined,
                  activeIcon: Icons.credit_card,
                  label: 'Card',
                  isActive: _currentIndex == 2,
                  isDark: isDark,
                ),
                _buildBarItem(
                  icon: Icons.person_outline,
                  activeIcon: Icons.person,
                  label: 'Profile',
                  isActive: _currentIndex == 3,
                  isDark: isDark,
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
    required bool isDark,
  }) {
    return BottomNavigationBarItem(
      icon: _NavIcon(
        icon: icon,
        activeIcon: activeIcon,
        active: isActive,
        label: label,
        isDark: isDark,
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
  final bool isDark;

  const _NavIcon({
    required this.icon,
    required this.activeIcon,
    required this.active,
    required this.label,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    final Color activeColor = const Color(0xFF80BFFF);
    final Color inactiveColor = isDark ? Colors.black : Colors.white;

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
            color: active ? activeColor : inactiveColor,
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
