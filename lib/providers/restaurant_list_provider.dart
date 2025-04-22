import 'package:flutter/widgets.dart';
import 'package:restaurant_app/data/api/restaurant_api_service.dart';
import 'package:restaurant_app/utils/restaurant_list_result_state.dart';

class RestaurantListProvider extends ChangeNotifier {
  final RestaurantApiService _restaurantApiService;

  RestaurantListResultState _resultState = const RestaurantListLoadingState();

  RestaurantListProvider(this._restaurantApiService) {
    fetchRestaurantList();
  }

  RestaurantListResultState get resultState => _resultState;

  Future<void> fetchRestaurantList() async {
    try {
      _resultState = RestaurantListLoadingState();
      notifyListeners();

      final result = await _restaurantApiService.getRestaurants();

      if (result.error) {
        _resultState = RestaurantListErrorState(result.message);
        notifyListeners();
      } else {
        _resultState = RestaurantListLoadedState(result.restaurants);
        notifyListeners();
      }
    } on Exception catch (e) {
      _resultState = RestaurantListErrorState("Failed to load data");
      notifyListeners();
    }
  }

  Future<void> refreshRestaurants() async {
    fetchRestaurantList();
  }
}
