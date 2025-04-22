import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/config/theme/app_theme.dart';
import 'package:restaurant_app/data/api/restaurant_api_service.dart';
import 'package:restaurant_app/providers/navigation_provider.dart';
import 'package:restaurant_app/providers/restaurant_list_provider.dart';
import 'package:restaurant_app/providers/restaurant_search_provider.dart';
import 'package:restaurant_app/providers/theme_provider.dart';
import 'package:restaurant_app/ui/screens/main_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (context) => RestaurantApiService()),
        ChangeNotifierProvider(create: (_) => NavigationProvider()),
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
        ChangeNotifierProvider(
          create:
              (context) =>
                  RestaurantListProvider(context.read<RestaurantApiService>()),
        ),
        ChangeNotifierProvider(
          create:
              (context) => RestaurantSearchProvider(
                context.read<RestaurantApiService>(),
              ),
        ),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, _) {
          return MaterialApp(
            title: 'Restaurant App',
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: themeProvider.themeMode,
            home: const MainScreen(),
          );
        },
      ),
    );
  }
}
