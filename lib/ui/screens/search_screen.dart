import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/providers/restaurant_search_provider.dart';
import 'package:restaurant_app/ui/screens/detail_screen.dart';
import 'package:restaurant_app/ui/widgets/restaurant_list_card.dart';
import 'package:restaurant_app/utils/restaurant_search_state.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  Timer? _debounce;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<RestaurantSearchProvider>().resetSearch();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  void _onSearchChanged(String query) {
    final provider = context.read<RestaurantSearchProvider>();
    provider.setQuery(query);

    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      provider.searchRestaurants();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Restaurants'),
        elevation: 2,
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search restaurants, categories, or menu...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    _searchController.clear();
                    context.read<RestaurantSearchProvider>().resetSearch();
                  },
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                contentPadding: const EdgeInsets.symmetric(vertical: 12),
              ),
              onChanged: _onSearchChanged,
              textInputAction: TextInputAction.search,
              onSubmitted: (value) {
                context.read<RestaurantSearchProvider>().searchRestaurants();
              },
            ),
          ),

          Expanded(
            child: Consumer<RestaurantSearchProvider>(
              builder: (context, provider, _) {
                return switch (provider.state) {
                  RestaurantSearchNoneState state => Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.search,
                          size: 80,
                          color: Colors.grey.shade300,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          state.message ?? 'Search for restaurants',
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(color: Colors.grey.shade600),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),

                  RestaurantSearchLoadingState _ => const Center(
                    child: CircularProgressIndicator(),
                  ),

                  RestaurantSearchLoadedState state => ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: state.data.length,
                    itemBuilder: (context, index) {
                      final restaurant = state.data[index];
                      return RestaurantListCard(
                        restaurant: restaurant,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (context) =>
                                      DetailScreen(restaurantId: restaurant.id),
                            ),
                          );
                        },
                      );
                    },
                  ),

                  RestaurantSearchErrorState state => Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.error_outline,
                          size: 80,
                          color: Colors.red.shade300,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Error: ${state.error}',
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(color: Colors.red.shade700),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 24),
                        ElevatedButton(
                          onPressed: () {
                            provider.searchRestaurants();
                          },
                          child: const Text('Try Again'),
                        ),
                      ],
                    ),
                  ),
                };
              },
            ),
          ),
        ],
      ),
    );
  }
}
