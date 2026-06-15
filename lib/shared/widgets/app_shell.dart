import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/routes.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';

/// Persistent bottom navigation wrapping the four primary destinations.
class AppShell extends StatelessWidget {
  final Widget child;
  const AppShell({super.key, required this.child});

  static const _tabs = [
    (Routes.home, Icons.dashboard_outlined, Icons.dashboard, 'Control'),
    (Routes.library, Icons.grid_view_outlined, Icons.grid_view, 'Scenarios'),
    (Routes.growth, Icons.insights_outlined, Icons.insights, 'Growth'),
    (Routes.mentor, Icons.auto_awesome_outlined, Icons.auto_awesome, 'Atlas'),
  ];

  int _indexFor(String loc) {
    final i = _tabs.indexWhere((t) => loc.startsWith(t.$1));
    return i < 0 ? 0 : i;
  }

  @override
  Widget build(BuildContext context) {
    final loc = GoRouterState.of(context).uri.path;
    final current = _indexFor(loc);

    return Scaffold(
      extendBody: true,
      body: child,
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: AppColors.obsidian,
          border: Border(top: BorderSide(color: AppColors.steel, width: 1)),
        ),
        child: SafeArea(
          top: false,
          child: SizedBox(
            height: 64,
            child: Row(
              children: [
                for (int i = 0; i < _tabs.length; i++)
                  Expanded(
                    child: _NavItem(
                      icon: current == i ? _tabs[i].$3 : _tabs[i].$2,
                      label: _tabs[i].$4,
                      active: current == i,
                      onTap: () => context.go(_tabs[i].$1),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool active;
  final VoidCallback onTap;

  const _NavItem({
    required this.icon,
    required this.label,
    required this.active,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final color = active ? AppColors.electric : AppColors.textFaint;
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color, size: 22),
          const SizedBox(height: 4),
          Text(label,
              style: AppType.body(10,
                  weight: active ? FontWeight.w700 : FontWeight.w500,
                  color: color)),
        ],
      ),
    );
  }
}
