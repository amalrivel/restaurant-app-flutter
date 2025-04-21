import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/providers/restaurant_list_provider.dart';
import 'package:restaurant_app/ui/screens/detail_screen.dart';
import 'package:restaurant_app/ui/screens/search_screen.dart';
import 'package:restaurant_app/ui/widgets/error_view.dart';
import 'package:restaurant_app/ui/widgets/loading_view.dart';
import 'package:restaurant_app/ui/widgets/restaurant_list_card.dart';
import 'package:restaurant_app/utils/restaurant_list_result_state.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        AppBar(
          title: Text('Dicoding Restaurant'),
          backgroundColor: theme.colorScheme.primary,
          elevation: 2,
          actions: [
            IconButton(
              icon: const Icon(Icons.search),
              tooltip: 'Search Restaurants',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SearchScreen()),
                );
              },
            ),
          ],
        ),
        Expanded(
          child: Consumer<RestaurantListProvider>(
            builder: (context, provider, _) {
              return switch (provider.resultState) {
                RestaurantListLoadingState() => const LoadingView(
                  title: 'Loading Restaurants...',
                ),
                RestaurantListLoadedState(data: var restaurantList) =>
                  restaurantList.isEmpty
                      ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.restaurant_menu,
                              size: 60,
                              color: theme.colorScheme.onSurfaceVariant,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'No restaurants found',
                              style: theme.textTheme.titleMedium,
                            ),
                            const SizedBox(height: 8),
                            ElevatedButton(
                              onPressed: () => provider.refreshRestaurants(),
                              child: const Text('Refresh'),
                            ),
                          ],
                        ),
                      )
                      : RefreshIndicator(
                        color: theme.colorScheme.primary,
                        backgroundColor: theme.colorScheme.surface,
                        onRefresh: provider.refreshRestaurants,
                        child: ListView.builder(
                          padding: const EdgeInsets.only(top: 8, bottom: 16),
                          itemCount: restaurantList.length,
                          itemBuilder: (context, index) {
                            final restaurant = restaurantList[index];
                            return RestaurantListCard(
                              restaurant: restaurant,
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder:
                                        (context) => DetailScreen(
                                          restaurantId: restaurant.id,
                                        ),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ),
                RestaurantListNoneState(message: String? message) => ErrorView(
                  message: message ?? 'No restaurants available.',
                  onRetry: () => provider.refreshRestaurants(),
                ),
                RestaurantListErrorState(error: String error) => ErrorView(
                  message: error,
                  onRetry: () => provider.refreshRestaurants(),
                ),
              };
            },
          ),
        ),
      ],
    );
  }
}
