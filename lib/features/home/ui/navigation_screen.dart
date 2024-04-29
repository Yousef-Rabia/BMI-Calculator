import 'package:bmi/features/Entries/ui/entries_screen.dart';
import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../theme/app_assets.dart';
import '../../../theme/app_colors.dart';
import '../../settings/settings_screen.dart';
import '../data/providers/home_provider.dart';
import 'home_screen.dart';



class NavigationScreen extends StatefulHookConsumerWidget {
  const NavigationScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends ConsumerState<NavigationScreen>
    with AutomaticKeepAliveClientMixin {
  final List<Widget> _children = [
    const EntriesScreen(),
    HomeScreen(),
    const SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    super.build(context);

    final homeProvider = ref.watch(homeNotifierProvider);


    return Scaffold(
      extendBody: true,
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: DotNavigationBar(
          backgroundColor: AppColors.primaryColor,
          itemPadding: const EdgeInsets.only(top: 5, bottom: 8, left: 16, right: 16),
          marginR: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
          margin: const EdgeInsets.only(left: 5, right: 5),
          currentIndex: homeProvider.screenIndex,
          dotIndicatorColor: Colors.white,
          unselectedItemColor: Colors.grey[300],
          splashBorderRadius: 50,
          splashColor: AppColors.black,
          borderRadius: 20,
          enablePaddingAnimation: false,
          boxShadow: const [
            BoxShadow(
                color: Colors.black38,
                spreadRadius: 1,
                blurRadius: 3,
                offset: Offset(1, 1))
          ],
          onTap: onTabTapped,
          items: [
            DotNavigationBarItem(
              icon: const Icon(Icons.add_chart_outlined),
              selectedColor: AppColors.white,
            ),

            DotNavigationBarItem(
              icon: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(15)),
                child: Image.asset(
                  AppAssets.logo,
                  height: 23,
                  width: 23,

                ),
              ),
              selectedColor: AppColors.white,
            ),

            DotNavigationBarItem(
              icon: const Icon(Icons.settings),
              selectedColor: AppColors.white,
            ),
          ],
        ),
      ),
      body: _children[homeProvider.screenIndex],
    );
  }

  void onTabTapped(int index) {
    ref.read(homeNotifierProvider.notifier).changePageIndex(index);
  }

  @override
  bool get wantKeepAlive => true;
}
