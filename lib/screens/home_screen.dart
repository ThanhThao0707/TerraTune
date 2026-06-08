
import 'package:flutter/material.dart';
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

  @override
  Widget build(BuildContext context) {
    // Danh sách screens tương ứng với mỗi tab
    // Dùng Consumer để lấy user an toàn tại đây, tránh lỗi Provider scope
    final screens = [
      _HomeTabContent(
        onTreeTap: _openTreeDetail,
        displayName: 'Vườn xoài Hà Nội',
      ),
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
  final String displayName;

  const _HomeTabContent({required this.onTreeTap, required this.displayName});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        // ── App Header (hồng) ──────────────────────────────────────────
        SliverToBoxAdapter(
          child: TerraAppHeader(
            subtitle: displayName,
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
