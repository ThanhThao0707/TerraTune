// lib/widgets/bottom_nav_bar.dart
// Bottom navigation bar 4 tab: Home, Alerts, Settings, Info

import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class TerraBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final void Function(int) onTap;

  const TerraBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  static const _items = [
    (icon: Icons.home_rounded, label: 'Home'),
    (icon: Icons.notifications_outlined, label: 'Alerts'),
    (icon: Icons.settings_outlined, label: 'Settings'),
    (icon: Icons.info_outline_rounded, label: 'Info'),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 72 + MediaQuery.of(context).padding.bottom,
      color: AppColors.backgroundGreen,
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(_items.length, (i) {
          final item = _items[i];
          final isActive = i == currentIndex;
          return GestureDetector(
            onTap: () => onTap(i),
            behavior: HitTestBehavior.opaque,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: isActive ? AppColors.pinkButton : AppColors.primaryGreen,
                shape: BoxShape.circle,
              ),
              child: Icon(
                item.icon,
                color: isActive ? AppColors.textDark : Colors.white70,
                size: 22,
              ),
            ),
          );
        }),
      ),
    );
  }
}
