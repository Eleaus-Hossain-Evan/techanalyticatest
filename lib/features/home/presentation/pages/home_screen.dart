import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/core.dart';
import '../../../auth/presentation/providers/auth_state_provider.dart';
import '../providers/trip_providers.dart';
import '../widgets/trip_search_bar.dart';
import '../widgets/trip_status_tab_bar.dart';
import '../widgets/trips_list.dart';

/// Main Dashboard (CCC - Booking Management) screen
///
/// Displays trip booking management with three activity states:
/// - Upcoming trips
/// - Past (completed) trips
/// - Cancelled trips
///
/// Features:
/// - Tab navigation between trip statuses
/// - Search booking functionality
/// - Trip cards with map thumbnails
/// - Trip details navigation
/// - Call driver functionality
class HomeScreen extends HookConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUser = ref.watch(currentUserProvider).value;
    final selectedTab = ref.watch(selectedTripTabProvider);
    final searchQuery = ref.watch(searchQueryProvider);
    final searchController = useTextEditingController();

    // Trip tabs configuration
    final tripTabs = ['Upcoming', 'Past', 'Cancelled'];

    // Map tab index to trip status
    final statusMapping = [
      TripStatus.upcoming,
      TripStatus.completed,
      TripStatus.cancelled,
    ];

    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: HomeAppBar(),
      body: Column(
        children: [
          // Trip status tabs
          if (searchQuery.isEmpty) ...[
            Padding(
              padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 0),
              child: TripStatusTabBar(
                tabs: tripTabs,
                selectedIndex: statusMapping.indexOf(selectedTab),
                onTabSelected: (index) {
                  final status = statusMapping[index];
                  ref.read(selectedTripTabProvider.notifier).selectTab(status);
                },
              ),
            ),
          ],
          16.verticalSpace,
          // Search bar
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: TripSearchBar(
              controller: searchController,
              onChanged: (query) {
                ref.read(searchQueryProvider.notifier).updateQuery(query);
              },
              onClear: () {
                searchController.clear();
                ref.read(searchQueryProvider.notifier).clearQuery();
              },
            ),
          ),
          20.verticalSpace,
          // Trips list
          Expanded(child: TripsList()),
        ],
      ),
      bottomNavigationBar: HomeNavigation(),
    );
  }
}

class HomeAppBar extends HookConsumerWidget implements PreferredSizeWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsetsGeometry.symmetric(horizontal: 16.w, vertical: 16.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                AppText('Logo', fontSize: 16.sp, fontWeight: FontWeight.w600),
                Spacer(),
                IconButton(
                  onPressed: () {
                    _showLogoutDialog(context, ref);
                  },
                  padding: EdgeInsets.zero,
                  visualDensity: VisualDensity.compact,
                  icon: Badge(
                    backgroundColor: AppColors.error,
                    child: Icon(Icons.notifications_none_rounded, size: 20.sp),
                  ),
                ),
              ],
            ),
            // 8.verticalSpace,
            Row(
              children: [
                Icon(Icons.pin_drop_rounded, size: 12),
                6.horizontalSpace,
                AppText(
                  'Gulshan1,Dhaka,Bangladesh',
                  fontSize: 10.sp,
                  color: AppColors.textGray,
                ),
                Spacer(),
                Icon(Icons.arrow_forward_ios_rounded, size: 10),
                12.horizontalSpace,
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(64 + 16.h + 13);

  /// Show logout confirmation dialog
  void _showLogoutDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Logout'),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.of(context).pop();

              try {
                final authNotifier = ref.read(authNotifierProvider.notifier);
                await authNotifier.logout();
                ref.invalidate(isAuthenticatedProvider);
              } catch (e) {
                debugPrint('Logout error: $e');
              }
            },
            child: const Text('Logout'),
          ),
        ],
      ),
    );
  }
}

class HomeNavigation extends StatelessWidget {
  const HomeNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: 2,
      backgroundColor: AppColors.primary,
      type: BottomNavigationBarType.fixed,
      selectedLabelStyle: TextStyle(
        fontSize: 12.sp,
        fontWeight: FontWeight.w400,
        color: Colors.white,
      ),
      selectedItemColor: AppColors.white,
      unselectedItemColor: Color(0xff8C8F9A),
      items: [
        BottomNavigationBarItem(
          icon: Image.asset(Images.iconHome, height: 24, width: 24),
          label: 'AAA',
        ),
        BottomNavigationBarItem(
          icon: Image.asset(Images.iconBbb, height: 24, width: 24),
          label: 'BBB',
        ),
        BottomNavigationBarItem(
          icon: Image.asset(Images.iconCcc, height: 24, width: 24),
          label: 'CCC',
        ),
        BottomNavigationBarItem(
          icon: Image.asset(Images.iconDdd, height: 24, width: 24),
          label: 'DDD',
        ),
      ],
    );
  }
}
