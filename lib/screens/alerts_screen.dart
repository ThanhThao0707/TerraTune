// lib/screens/alerts_screen.dart
// Màn hình thông báo: Active Alerts + Notification Preferences

import 'package:flutter/material.dart';
import '../models/tree_node.dart';
import '../theme/app_theme.dart';
import '../widgets/app_header.dart';

class AlertsScreen extends StatelessWidget {
  const AlertsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const TerraAppHeader(subtitle: 'Vườn xoài Hà Nội'),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                // ── Active Alerts ────────────────────────────────────
                _ActiveAlertsCard(),
                const SizedBox(height: 16),

                // ── Notification Preferences ─────────────────────────
                _NotificationPrefsCard(),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

// ─── Active Alerts Card ───────────────────────────────────────────────────────
class _ActiveAlertsCard extends StatelessWidget {
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
              const Icon(Icons.warning_amber_rounded,
                  color: AppColors.textDark, size: 20),
              const SizedBox(width: 8),
              Text(
                'Active Alerts',
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(fontWeight: FontWeight.w700),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Alert list
          ...mockAlerts.map((alert) => _AlertItem(alert: alert)),
        ],
      ),
    );
  }
}

class _AlertItem extends StatelessWidget {
  final TreeAlert alert;

  const _AlertItem({required this.alert});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: alert.isUrgent
            ? AppColors.pinkAccent
            : AppColors.lightGreen.withOpacity(0.7),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: alert.isUrgent
              ? AppColors.drought.withOpacity(0.3)
              : Colors.transparent,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 8,
            height: 8,
            margin: const EdgeInsets.only(top: 4),
            decoration: BoxDecoration(
              color: alert.isUrgent ? AppColors.drought : AppColors.healthy,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              '${alert.treeName}: ${alert.message}',
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Notification Preferences Card ───────────────────────────────────────────
class _NotificationPrefsCard extends StatefulWidget {
  @override
  State<_NotificationPrefsCard> createState() => _NotificationPrefsCardState();
}

class _NotificationPrefsCardState extends State<_NotificationPrefsCard> {
  bool _soundEnabled = true;
  bool _vibrationEnabled = true;

  static const _prefs = [
    (icon: Icons.campaign_outlined, label: 'Alert sound', sub: 'Play sound when alert arrives'),
    (icon: Icons.timer_outlined, label: 'Vibration', sub: 'Haptic feedback on alert'),
    (icon: Icons.access_time_outlined, label: 'Frequency', sub: 'How often to receive alerts'),
    (icon: Icons.language_outlined, label: 'Language', sub: 'Alert language'),
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
          Row(
            children: [
              const Icon(Icons.notifications_outlined,
                  color: AppColors.textDark, size: 20),
              const SizedBox(width: 8),
              Text(
                'Notification Preferences',
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(fontWeight: FontWeight.w700),
              ),
            ],
          ),
          const SizedBox(height: 14),

          ..._prefs.asMap().entries.map((e) => _PrefRow(
                icon: e.value.icon,
                label: e.value.label,
                subtitle: e.value.sub,
              )),
        ],
      ),
    );
  }
}

class _PrefRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String subtitle;

  const _PrefRow({
    required this.icon,
    required this.label,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.mediumGreen.withOpacity(0.3),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: AppColors.textDark, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(fontSize: 14),
                ),
                Text(
                  subtitle,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
          const Icon(Icons.chevron_right_rounded,
              color: AppColors.textLight, size: 20),
        ],
      ),
    );
  }
}
