import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/providers/navigation_provider.dart';
import 'package:restaurant_app/ui/screens/home_screen.dart';
import 'package:restaurant_app/ui/screens/settings_screen.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  static const List<Widget> _screens = [
    HomeScreen(),
    SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<NavigationProvider>(
      builder: (context, navigationProvider, _) {
        return Scaffold(
          body: SafeArea(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: _screens[navigationProvider.selectedIndex],
            ),
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: navigationProvider.selectedIndex,
            onTap: (index) => navigationProvider.setIndex(index),
            elevation: 8,
            type: BottomNavigationBarType.fixed,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.restaurant),
                label: 'Restaurants',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: 'Settings',
              ),
            ],
          ),
        );
      },
    );
  }
}