// lib/screens/home_screen.dart
// Màn hình chính - hiển thị danh sách cây (Sentinel Node Status) + Weekly Summary + Map
// Đây là tab Home trong bottom navigation

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../models/tree_node.dart';
import '../theme/app_theme.dart';
import '../widgets/tree_card.dart';
import '../widgets/weekly_summary_card.dart';
import '../widgets/bottom_nav_bar.dart';
import '../widgets/app_header.dart';
import 'tree_detail_screen.dart';
import 'alerts_screen.dart';
import 'farm_map_screen.dart';
import 'settings_screen.dart';
import 'login_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentTab = 0; // 0=Home, 1=Alerts, 2=Settings, 3=Info

  // Nội dung từng tab
  final List<Widget> _tabViews = [];

  @override
  void initState() {
    super.initState();
  }

  Future<void> _handleSignOut() async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Đăng xuất'),
        content: const Text('Bạn có chắc muốn đăng xuất không?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Huỷ'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text(
              'Đăng xuất',
              style: TextStyle(color: AppColors.drought),
            ),
          ),
        ],
      ),
    );
    if (confirm == true && mounted) {
      await context.read<AuthProvider>().signOut();
      if (mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const LoginScreen()),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // Danh sách screens tương ứng với mỗi tab
    final screens = [
      _HomeTabContent(onTreeTap: _openTreeDetail),
      const AlertsScreen(),
      const SettingsScreen(),
      const FarmMapScreen(),
    ];

    return Scaffold(
      backgroundColor: AppColors.backgroundGreen,
      body: screens[_currentTab],
      bottomNavigationBar: TerraBottomNavBar(
        currentIndex: _currentTab,
        onTap: (i) => setState(() => _currentTab = i),
      ),
    );
  }

  void _openTreeDetail(TreeNode tree) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => TreeDetailScreen(tree: tree)),
    );
  }
}

// ─── Home Tab Content ─────────────────────────────────────────────────────────
class _HomeTabContent extends StatelessWidget {
  final void Function(TreeNode) onTreeTap;

  const _HomeTabContent({required this.onTreeTap});

  @override
  Widget build(BuildContext context) {
    final user = context.read<AuthProvider>().user;

    return CustomScrollView(
      slivers: [
        // ── App Header (hồng) ──────────────────────────────────────────
        SliverToBoxAdapter(
          child: TerraAppHeader(
            subtitle: user?.displayName ?? 'Vườn xoài Hà Nội',
          ),
        ),

        SliverPadding(
          padding: const EdgeInsets.all(16),
          sliver: SliverList(
            delegate: SliverChildListDelegate([
              // ── Section: Sentinel Node Status ───────────────────────
              _SectionHeader(
                icon: Icons.graphic_eq_rounded,
                title: 'Sentinel Node Status',
              ),
              const SizedBox(height: 10),

              // Danh sách cây từ mock data
              ...mockTrees.map((tree) => Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: TreeCard(
                      tree: tree,
                      onTap: () => onTreeTap(tree),
                    ),
                  )),

              const SizedBox(height: 16),

              // ── Weekly Summary ───────────────────────────────────────
              const WeeklySummaryCard(),

              const SizedBox(height: 16),

              // ── Map shortcut ─────────────────────────────────────────
              _MapShortcut(),

              const SizedBox(height: 16),
            ]),
          ),
        ),
      ],
    );
  }
}

// ─── Section Header Widget ────────────────────────────────────────────────────
class _SectionHeader extends StatelessWidget {
  final IconData icon;
  final String title;

  const _SectionHeader({required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 20, color: AppColors.textDark),
        const SizedBox(width: 8),
        Text(
          title,
          style: Theme.of(context)
              .textTheme
              .titleMedium
              ?.copyWith(fontWeight: FontWeight.w700),
        ),
      ],
    );
  }
}

// ─── Map Shortcut Card ────────────────────────────────────────────────────────
class _MapShortcut extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const FarmMapScreen()),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        decoration: BoxDecoration(
          color: AppColors.lightGreen,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            const Icon(Icons.map_outlined,
                color: AppColors.primaryGreen, size: 22),
            const SizedBox(width: 12),
            Text(
              'Map',
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(fontWeight: FontWeight.w600),
            ),
            const Spacer(),
            const Icon(Icons.chevron_right_rounded,
                color: AppColors.primaryGreen),
          ],
        ),
      ),
    );
  }
}
