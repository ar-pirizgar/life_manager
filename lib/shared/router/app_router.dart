import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../modules/home/screens/home_screen.dart';
import '../../modules/tasks/screens/tasks_screen.dart';
import 'placeholder_screen.dart';

/// روتر اصلی اپ با ناوبری پایین.
///
/// برای اضافه کردن ماژول جدید:
/// ۱. یک branch جدید به StatefulShellRoute اضافه کنید
/// ۲. یک آیتم به _destinations اضافه کنید
final appRouter = GoRouter(
  initialLocation: '/home',
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return _ScaffoldWithNavBar(navigationShell: navigationShell);
      },
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/home',
              builder: (_, __) => const HomeScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/tasks',
              builder: (_, __) => const TasksScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/goals',
              builder: (_, __) => const PlaceholderScreen(
                title: 'اهداف',
                icon: Icons.flag_outlined,
                phase: 'فاز ۲',
              ),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/dashboard',
              builder: (_, __) => const PlaceholderScreen(
                title: 'داشبورد',
                icon: Icons.dashboard_outlined,
                phase: 'فاز ۴',
              ),
            ),
          ],
        ),
      ],
    ),
  ],
);

/// آیتم‌های ناوبری پایین
const _destinations = [
  NavigationDestination(
    icon: Icon(Icons.home_outlined),
    selectedIcon: Icon(Icons.home),
    label: 'خانه',
  ),
  NavigationDestination(
    icon: Icon(Icons.check_circle_outline),
    selectedIcon: Icon(Icons.check_circle),
    label: 'تسک‌ها',
  ),
  NavigationDestination(
    icon: Icon(Icons.flag_outlined),
    selectedIcon: Icon(Icons.flag),
    label: 'اهداف',
  ),
  NavigationDestination(
    icon: Icon(Icons.dashboard_outlined),
    selectedIcon: Icon(Icons.dashboard),
    label: 'داشبورد',
  ),
];

class _ScaffoldWithNavBar extends StatelessWidget {
  const _ScaffoldWithNavBar({required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: NavigationBar(
        selectedIndex: navigationShell.currentIndex,
        onDestinationSelected: (index) {
          navigationShell.goBranch(
            index,
            initialLocation: index == navigationShell.currentIndex,
          );
        },
        destinations: _destinations,
      ),
    );
  }
}
