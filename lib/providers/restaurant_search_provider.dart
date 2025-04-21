import 'package:flutter/foundation.dart';
import 'package:restaurant_app/data/api/restaurant_api_service.dart';
import 'package:restaurant_app/utils/restaurant_search_state.dart';

class RestaurantSearchProvider with ChangeNotifier {
  final RestaurantApiService _restaurantApiService;
  String _query = '';

  RestaurantSearchResultState _state = const RestaurantSearchNoneState();

  RestaurantSearchProvider(this._restaurantApiService);

  RestaurantSearchResultState get state => _state;
  String get query => _query;

  void setQuery(String query) {
    _query = query;
    notifyListeners();
  }

  Future<void> searchRestaurants([String? searchQuery]) async {
    final query = searchQuery ?? _query;

    if (query.isEmpty) {
      _state = const RestaurantSearchNoneState(
        message: 'Enter a keyword to search',
      );
      notifyListeners();
      return;
    }

    try {
      _state = const RestaurantSearchLoadingState();
      notifyListeners();

      final result = await _restaurantApiService.searchRestaurants(query);
      if (result.restaurants.isEmpty) {
        _state = RestaurantSearchNoneState(
          message: 'No restaurants found for "$query"',
        );
      } else {
        _state = RestaurantSearchLoadedState(result.restaurants);
      }
    } on Exception catch (e) {
      _state = RestaurantSearchErrorState(e.toString());
    } finally {
      notifyListeners();
    }
  }

  void resetSearch() {
    _query = '';
    _state = const RestaurantSearchNoneState();
    notifyListeners();
  }
}
