// lib/widgets/app_header.dart
// Header chung của app - logo + tên vườn + hamburger menu
// Màu nền hồng pastel theo thiết kế

import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class TerraAppHeader extends StatelessWidget {
  final String subtitle;
  final bool showBack;
  final VoidCallback? onBack;

  const TerraAppHeader({
    super.key,
    required this.subtitle,
    this.showBack = false,
    this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.pinkAccent,
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 8,
        bottom: 12,
        left: 16,
        right: 16,
      ),
      child: Row(
        children: [
          // Back button hoặc Logo
          if (showBack)
            GestureDetector(
              onTap: onBack ?? () => Navigator.pop(context),
              child: Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.4),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.chevron_left_rounded,
                    color: AppColors.textDark, size: 22),
              ),
            )
          else
            // Tree mascot icon
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: AppColors.primaryGreen,
                borderRadius: BorderRadius.circular(10),
              ),
              child:
                  const Center(child: Text('🌳', style: TextStyle(fontSize: 22))),
            ),

          const SizedBox(width: 10),

          // App name + subtitle
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'terratune',
                style: TextStyle(
                  color: AppColors.textDark,
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -0.5,
                ),
              ),
              Text(
                subtitle,
                style: const TextStyle(
                  color: AppColors.textMedium,
                  fontSize: 12,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),

          const Spacer(),

          // Hamburger / settings
          if (!showBack)
            GestureDetector(
              onTap: () {}, // TODO: open drawer
              child: Column(
                mainAxisSize: MainAxisSize.min,
                spacing: 4,
                children: List.generate(
                  3,
                  (_) => Container(
                    width: 20,
                    height: 2.5,
                    decoration: BoxDecoration(
                      color: AppColors.textDark,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
