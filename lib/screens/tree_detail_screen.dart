

import 'package:flutter/material.dart';
import '../models/tree_node.dart';
import '../theme/app_theme.dart';
import '../widgets/app_header.dart';

class TreeDetailScreen extends StatelessWidget {
  final TreeNode tree;

  const TreeDetailScreen({super.key, required this.tree});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundGreen,
      body: Column(
        children: [
          // Header với back button + tree name
          _TreeDetailHeader(tree: tree),

          // Scrollable content
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  // ── Status Card ────────────────────────────────────
                  _StatusCard(tree: tree),
                  const SizedBox(height: 12),

                  // ── Acoustic Signature ─────────────────────────────
                  _AcousticSignatureCard(),
                  const SizedBox(height: 12),

                  // ── Recommended Actions ────────────────────────────
                  _RecommendedActionsCard(tree: tree),
                  const SizedBox(height: 12),

                  // ── Device Status ──────────────────────────────────
                  _DeviceStatusCard(tree: tree),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Custom Header ─────────────────────────────────────────────────────────────
class _TreeDetailHeader extends StatelessWidget {
  final TreeNode tree;

  const _TreeDetailHeader({required this.tree});

  Color get _dotColor {
    switch (tree.status) {
      case TreeStatus.healthy:
        return AppColors.healthy;
      case TreeStatus.drought:
        return AppColors.drought;
      default:
        return AppColors.warning;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.pinkAccent,
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 8,
        bottom: 14,
        left: 16,
        right: 16,
      ),
      child: Row(
        children: [
          // Back button
          GestureDetector(
            onTap: () => Navigator.pop(context),
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
          ),
          const SizedBox(width: 12),

          // Tree name + location
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  tree.name,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    color: AppColors.textDark,
                  ),
                ),
                Text(
                  '${tree.species} · ${tree.location}',
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.textMedium,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
          ),

          // Status badge
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.7),
              borderRadius: BorderRadius.circular(50),
            ),
            child: Row(
              children: [
                Container(
                  width: 7,
                  height: 7,
                  decoration: BoxDecoration(
                    color: _dotColor,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 5),
                Text(tree.statusEmoji, style: const TextStyle(fontSize: 14)),
                const SizedBox(width: 4),
                Text(
                  tree.statusLabel,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textDark,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Big Status Card ──────────────────────────────────────────────────────────
class _StatusCard extends StatelessWidget {
  final TreeNode tree;

  const _StatusCard({required this.tree});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.lightGreen,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Text(tree.statusEmoji, style: const TextStyle(fontSize: 48)),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                tree.statusLabel,
                style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w800,
                  color: AppColors.textDark,
                ),
              ),
              Text(
                'Active ${tree.lastActiveLabel}',
                style: const TextStyle(
                  fontSize: 13,
                  color: AppColors.textMedium,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ─── Acoustic Signature Card ──────────────────────────────────────────────────
class _AcousticSignatureCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.lightGreen,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            children: [
              const Icon(Icons.campaign_outlined,
                  color: AppColors.textDark, size: 20),
              const SizedBox(width: 8),
              Text(
                'Acoustic Signature',
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(fontWeight: FontWeight.w700),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Spectrogram placeholder
          Container(
            height: 120,
            width: double.infinity,
            decoration: BoxDecoration(
              color: const Color(0xFF0D1B2A),
              borderRadius: BorderRadius.circular(10),
            ),
            child: CustomPaint(
              painter: _SpectrogramPainter(),
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Frequency (Hz)',
                          style: TextStyle(
                            color: Colors.white54,
                            fontSize: 9,
                          ),
                        ),
                        Text(
                          'Time (seconds)',
                          style: TextStyle(
                            color: Colors.white54,
                            fontSize: 9,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),

          // Audio buttons
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Text('Play audio'),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.mediumGreen,
                  ),
                  child: const Text('Hear Alert Tone'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}


class _SpectrogramPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final rng = [
      0.3, 0.6, 0.4, 0.8, 1.0, 0.7, 0.9, 0.5, 0.6, 0.4,
      0.7, 0.8, 0.3, 0.5, 0.9, 0.6, 0.4, 0.7, 0.8, 0.5,
    ];
    final colors = [
      Colors.teal.shade300,
      Colors.green.shade400,
      Colors.red.shade400,
      Colors.orange.shade400,
      Colors.yellow.shade300,
    ];

    final cellW = size.width / 20;
    final cellH = (size.height - 24) / 8;
    final paint = Paint();

    for (int col = 0; col < 20; col++) {
      for (int row = 0; row < 8; row++) {
        final intensity = rng[(col + row) % rng.length];
        final colorIdx = (intensity * (colors.length - 1)).round();
        paint.color = colors[colorIdx].withOpacity(0.6 + intensity * 0.4);
        canvas.drawRRect(
          RRect.fromRectAndRadius(
            Rect.fromLTWH(
              col * cellW + 1,
              row * cellH + 4,
              cellW - 2,
              cellH - 2,
            ),
            const Radius.circular(2),
          ),
          paint,
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// ─── Recommended Actions Card ─────────────────────────────────────────────────
class _RecommendedActionsCard extends StatelessWidget {
  final TreeNode tree;

  const _RecommendedActionsCard({required this.tree});

  static const _chipColors = [
    Color(0xFFFFCDD2), // hồng
    Color(0xFFD7CCC8), // nâu nhạt
    Color(0xFFB2EBF2), // xanh dương nhạt
    Color(0xFFC8E6C9), // xanh lá nhạt
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.lightGreen,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            children: [
              const Icon(Icons.check_circle_outline,
                  color: AppColors.textDark, size: 20),
              const SizedBox(width: 8),
              Text(
                'Recommended Actions',
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(fontWeight: FontWeight.w700),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Action chips
          ...List.generate(tree.recommendedActions.length, (i) {
            return Container(
              width: double.infinity,
              margin: const EdgeInsets.only(bottom: 8),
              padding:
                  const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              decoration: BoxDecoration(
                color: _chipColors[i % _chipColors.length],
                borderRadius: BorderRadius.circular(50),
              ),
              child: Text(
                tree.recommendedActions[i],
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textDark,
                ),
              ),
            );
          }),

          const SizedBox(height: 8),

          // Action buttons row
          Row(
            children: [
              // Call Expert
              Expanded(
                flex: 3,
                child: ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.phone_in_talk_rounded, size: 18),
                  label: const Text('Call Expert'),
                ),
              ),
              const SizedBox(width: 8),
              // Save
              _RoundIconBtn(
                icon: Icons.bookmark_border_rounded,
                onTap: () {},
              ),
              const SizedBox(width: 8),
              // Refresh
              _RoundIconBtn(
                icon: Icons.refresh_rounded,
                onTap: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _RoundIconBtn extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _RoundIconBtn({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: AppColors.mediumGreen.withOpacity(0.3),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(icon, color: AppColors.textDark, size: 20),
      ),
    );
  }
}

// ─── Device Status Card ───────────────────────────────────────────────────────
class _DeviceStatusCard extends StatelessWidget {
  final TreeNode tree;

  const _DeviceStatusCard({required this.tree});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.lightGreen,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.bar_chart_rounded,
                  color: AppColors.textDark, size: 20),
              const SizedBox(width: 8),
              Text(
                'Device Status',
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(fontWeight: FontWeight.w700),
              ),
            ],
          ),
          const SizedBox(height: 14),

          _DeviceStatusRow(
            icon: Icons.battery_4_bar_rounded,
            label: 'Battery',
            value: '${tree.batteryPercent}%',
            fillRatio: tree.batteryPercent / 100,
            color: tree.batteryPercent > 30
                ? AppColors.healthy
                : AppColors.drought,
          ),
          const SizedBox(height: 10),
          _DeviceStatusRow(
            icon: Icons.bluetooth_rounded,
            label: 'Connection',
            value: tree.isConnected ? 'Connected' : 'Offline',
            fillRatio: tree.isConnected ? 1.0 : 0.0,
            color: tree.isConnected ? AppColors.healthy : Colors.grey,
          ),
          const SizedBox(height: 10),
          _DeviceStatusRow(
            icon: Icons.signal_cellular_4_bar_rounded,
            label: 'Signal strength',
            value: '${(tree.signalStrength * 100).round()}%',
            fillRatio: tree.signalStrength,
            color: AppColors.mediumGreen,
          ),
        ],
      ),
    );
  }
}

class _DeviceStatusRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final double fillRatio;
  final Color color;

  const _DeviceStatusRow({
    required this.icon,
    required this.label,
    required this.value,
    required this.fillRatio,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: AppColors.textMedium, size: 18),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            label,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
        // Mini progress bar
        SizedBox(
          width: 80,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: fillRatio,
              minHeight: 6,
              backgroundColor: Colors.black12,
              valueColor: AlwaysStoppedAnimation(color),
            ),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          value,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: color,
              ),
        ),
      ],
    );
  }
}
