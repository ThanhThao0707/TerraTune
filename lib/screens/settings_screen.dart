// lib/screens/settings_screen.dart
// Màn hình cài đặt: Farmer Account, Display, Data & Sync, Sign out

import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'login_screen.dart';
import '../widgets/app_header.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

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
                // ── Farmer Account ────────────────────────────────────
                _SettingsSection(
                  children: [
                    _AccountHeader(),
                    _SettingsRow(
                      icon: Icons.person_outline_rounded,
                      label: 'Profile',
                      subtitle: 'Name, phone, email',
                    ),
                    _SettingsRow(
                      icon: Icons.language_outlined,
                      label: 'Language',
                      subtitle: 'App display language',
                    ),
                    _SettingsRow(
                      icon: Icons.phone_android_rounded,
                      label: 'Device Pairing',
                      subtitle: 'Manage connected sensors',
                      showDivider: false,
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                // ── Display ───────────────────────────────────────────
                _SettingsSection(
                  header: (
                    icon: Icons.dark_mode_outlined,
                    label: 'Display'
                  ),
                  children: [
                    _SettingsRow(
                      icon: Icons.dark_mode_outlined,
                      label: 'Dark mode',
                      subtitle: 'Reduce eye strain in low light',
                      trailing: Switch(
                        value: false,
                        onChanged: (_) {},
                        activeColor: AppColors.primaryGreen,
                      ),
                    ),
                    _SettingsRow(
                      icon: Icons.storage_outlined,
                      label: 'Data saver',
                      subtitle: 'Reduce map and image loading',
                      showDivider: false,
                      trailing: Switch(
                        value: false,
                        onChanged: (_) {},
                        activeColor: AppColors.primaryGreen,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                // ── Data & Sync ───────────────────────────────────────
                _SettingsSection(
                  header: (icon: Icons.storage_outlined, label: 'Data & Sync'),
                  children: [
                    _SettingsRow(
                      icon: Icons.sync_rounded,
                      label: 'Sync now',
                      subtitle: 'Last sync 2 minutes ago',
                    ),
                    _SettingsRow(
                      icon: Icons.download_outlined,
                      label: 'Export data',
                      subtitle: 'Download CSV of sensors reading',
                    ),
                    _SettingsRow(
                      icon: Icons.security_outlined,
                      label: 'Privacy',
                      subtitle: 'Data sharing and permissions',
                      showDivider: false,
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                // ── Danger Zone ───────────────────────────────────────
                _DangerZone(),

                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

// ─── Settings Section Container ───────────────────────────────────────────────
class _SettingsSection extends StatelessWidget {
  final List<Widget> children;
  final ({IconData icon, String label})? header;

  const _SettingsSection({required this.children, this.header});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.lightGreen,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (header != null)
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 14, 16, 4),
              child: Row(
                children: [
                  Icon(header!.icon, size: 18, color: AppColors.textDark),
                  const SizedBox(width: 8),
                  Text(
                    header!.label,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                ],
              ),
            ),
          ...children,
        ],
      ),
    );
  }
}

// ─── Account Header Row ───────────────────────────────────────────────────────
class _AccountHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          CircleAvatar(
            radius: 28,
            backgroundColor: AppColors.primaryGreen,
            child: const Icon(Icons.person, color: Colors.white, size: 28),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Farmer Account',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                ),
                Text(
                  'Manage your profile and preferences',
                  style: Theme.of(context).textTheme.bodyMedium,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Single Settings Row ──────────────────────────────────────────────────────
class _SettingsRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String subtitle;
  final Widget? trailing;
  final bool showDivider;

  const _SettingsRow({
    required this.icon,
    required this.label,
    required this.subtitle,
    this.trailing,
    this.showDivider = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: [
              Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  color: AppColors.mediumGreen.withOpacity(0.25),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: AppColors.textDark, size: 19),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(label,
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(fontSize: 14)),
                    Text(subtitle,
                        style: Theme.of(context).textTheme.bodyMedium),
                  ],
                ),
              ),
              trailing ??
                  const Icon(Icons.chevron_right_rounded,
                      color: AppColors.textLight, size: 20),
            ],
          ),
        ),
        if (showDivider)
          Divider(
              height: 1,
              indent: 16,
              endIndent: 16,
              color: Colors.black.withOpacity(0.06)),
      ],
    );
  }
}

// ─── Danger Zone (Sign out / Delete) ─────────────────────────────────────────
class _DangerZone extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.lightGreen,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          // Sign out
          GestureDetector(
            onTap: () => _signOut(context),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              child: Row(
                children: [
                  Container(
                    width: 38,
                    height: 38,
                    decoration: BoxDecoration(
                      color: Colors.red.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(Icons.logout_rounded,
                        color: Colors.red, size: 19),
                  ),
                  const SizedBox(width: 12),
                  const Text(
                    'Sign out',
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),
          ),

          Divider(height: 1, indent: 16, color: Colors.black.withOpacity(0.06)),

          // Delete account
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            child: Row(
              children: [
                Container(
                  width: 38,
                  height: 38,
                  decoration: BoxDecoration(
                    color: Colors.red.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(Icons.delete_outline_rounded,
                      color: Colors.red, size: 19),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Delete account',
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                      ),
                    ),
                    Text(
                      'Permanently remove all data',
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _signOut(BuildContext context) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Đăng xuất'),
        content: const Text('Bạn có chắc muốn đăng xuất không?'),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Huỷ')),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Đăng xuất',
                style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );

    if (confirm == true && context.mounted) {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => const LoginScreen()),
        (_) => false,
      );
    }
  }
}
