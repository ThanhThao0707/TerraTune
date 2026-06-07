// lib/widgets/tree_card.dart
// Card hiển thị thông tin một cây trong danh sách Sentinel Node Status

import 'package:flutter/material.dart';
import '../models/tree_node.dart';
import '../theme/app_theme.dart';

class TreeCard extends StatelessWidget {
  final TreeNode tree;
  final VoidCallback onTap;

  const TreeCard({super.key, required this.tree, required this.onTap});

  // Màu nền card theo trạng thái
  Color get _cardColor {
    switch (tree.status) {
      case TreeStatus.healthy:
        return AppColors.lightGreen;
      case TreeStatus.drought:
        return const Color(0xFFFFE8E8); // Hồng nhạt cảnh báo
      case TreeStatus.warning:
        return const Color(0xFFFFF8E1); // Vàng nhạt
      case TreeStatus.offline:
        return const Color(0xFFEEEEEE);
    }
  }

  // Màu chấm trạng thái
  Color get _statusDotColor {
    switch (tree.status) {
      case TreeStatus.healthy:
        return AppColors.healthy;
      case TreeStatus.drought:
        return AppColors.drought;
      case TreeStatus.warning:
        return AppColors.warning;
      case TreeStatus.offline:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: _cardColor,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            // ── Phần trên: số thứ tự + tên + trạng thái ───────────────
            Padding(
              padding: const EdgeInsets.fromLTRB(14, 14, 14, 10),
              child: Row(
                children: [
                  // Số thứ tự
                  Container(
                    width: 38,
                    height: 38,
                    decoration: BoxDecoration(
                      color: AppColors.primaryGreen,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        tree.id.replaceAll('t', ''),
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),

                  // Tên cây + giống
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          tree.name,
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(fontWeight: FontWeight.w700),
                        ),
                        Text(
                          tree.species,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ),

                  // Status badge
                  _StatusBadge(
                    label: tree.statusLabel,
                    emoji: tree.statusEmoji,
                    dotColor: _statusDotColor,
                  ),
                ],
              ),
            ),

            // Thời gian hoạt động
            Padding(
              padding: const EdgeInsets.only(right: 14, bottom: 8),
              child: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  tree.lastActiveLabel,
                  style: Theme.of(context).textTheme.labelSmall,
                ),
              ),
            ),

            // Divider
            Divider(height: 1, color: Colors.black.withOpacity(0.06)),

            // ── Phần dưới: kết nối + signal ────────────────────────────
            Padding(
              padding: const EdgeInsets.fromLTRB(14, 8, 14, 12),
              child: Row(
                children: [
                  // Connected dot
                  Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: tree.isConnected
                          ? AppColors.healthy
                          : Colors.grey,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    tree.isConnected ? 'Connected' : 'Disconnected',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const Spacer(),
                  Text(
                    '${tree.batteryPercent}%',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Status Badge ─────────────────────────────────────────────────────────────
class _StatusBadge extends StatelessWidget {
  final String label;
  final String emoji;
  final Color dotColor;

  const _StatusBadge({
    required this.label,
    required this.emoji,
    required this.dotColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.7),
        borderRadius: BorderRadius.circular(50),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 7,
            height: 7,
            decoration: BoxDecoration(color: dotColor, shape: BoxShape.circle),
          ),
          const SizedBox(width: 5),
          Text(emoji, style: const TextStyle(fontSize: 14)),
          const SizedBox(width: 4),
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: AppColors.textDark,
            ),
          ),
        ],
      ),
    );
  }
}
