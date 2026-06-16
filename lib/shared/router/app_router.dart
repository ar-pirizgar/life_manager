import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../modules/calendar/screens/calendar_screen.dart';
import '../../modules/dashboard/screens/dashboard_screen.dart';
import '../../modules/dashboard/screens/kpi_list_screen.dart';
import '../../modules/finance/screens/finance_screen.dart';
import '../../modules/goals/screens/goal_detail_screen.dart';
import '../../modules/goals/screens/goals_screen.dart';
import '../../modules/habits/screens/habits_screen.dart';
import '../../modules/home/screens/home_screen.dart';
import '../../modules/more/screens/more_screen.dart';
import '../../modules/health/screens/health_screen.dart';
import '../../modules/reviews/screens/monthly_reflection_screen.dart';
import '../../modules/reviews/screens/reviews_hub_screen.dart';
import '../../modules/reviews/screens/weekly_review_screen.dart';
import '../../modules/tasks/screens/tasks_screen.dart';
import '../../modules/timer/screens/timer_screen.dart';

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
              builder: (_, __) => const GoalsScreen(),
              routes: [
                GoRoute(
                  path: ':goalId',
                  builder: (_, state) => GoalDetailScreen(
                    goalId: state.pathParameters['goalId']!,
                  ),
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/finance',
              builder: (_, __) => const FinanceScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/more',
              builder: (_, __) => const MoreScreen(),
              routes: [
                GoRoute(
                  path: 'calendar',
                  builder: (_, __) => const CalendarScreen(),
                ),
                GoRoute(
                  path: 'timer',
                  builder: (_, __) => const TimerScreen(),
                ),
                GoRoute(
                  path: 'habits',
                  builder: (_, __) => const HabitsScreen(),
                ),
                GoRoute(
                  path: 'health',
                  builder: (_, __) => const HealthScreen(),
                ),
                GoRoute(
                  path: 'dashboard',
                  builder: (_, __) => const DashboardScreen(),
                  routes: [
                    GoRoute(
                      path: 'kpis',
                      builder: (_, __) => const KpiListScreen(),
                    ),
                  ],
                ),
                GoRoute(
                  path: 'reviews',
                  builder: (_, __) => const ReviewsHubScreen(),
                  routes: [
                    GoRoute(
                      path: 'weekly',
                      builder: (_, __) => const WeeklyReviewScreen(),
                    ),
                    GoRoute(
                      path: 'monthly',
                      builder: (_, __) => const MonthlyReflectionScreen(),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  ],
);

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
    icon: Icon(Icons.account_balance_wallet_outlined),
    selectedIcon: Icon(Icons.account_balance_wallet),
    label: 'مالی',
  ),
  NavigationDestination(
    icon: Icon(Icons.more_horiz),
    selectedIcon: Icon(Icons.more_horiz),
    label: 'بیشتر',
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
