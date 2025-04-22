import 'package:flutter/foundation.dart';
import 'package:restaurant_app/data/api/restaurant_api_service.dart';
import 'package:restaurant_app/data/models/restaurant_detail.dart';
import 'package:restaurant_app/utils/restaurant_detail_state.dart';

class RestaurantDetailProvider extends ChangeNotifier {
  final RestaurantApiService _restaurantApiService;
  String? _restaurantId;

  RestaurantDetailResultState _state = RestaurantDetailLoadingState();

  RestaurantDetailProvider(this._restaurantApiService);

  RestaurantDetailResultState get state => _state;

  String? get restaurantId => _restaurantId;

  void setRestaurantId(String id) {
    _restaurantId = id;
    fetchRestaurantDetail();
  }

  Future<void> fetchRestaurantDetail() async {
    if (_restaurantId == null) {
      _state = const RestaurantDetailErrorState("Restaurant ID is not set");
      notifyListeners();
      return;
    }

    try {
      _state = const RestaurantDetailLoadingState();
      notifyListeners();

      final detailResult = await _restaurantApiService.getRestaurantDetail(
        _restaurantId!,
      );

      if (detailResult.error) {
        _state = RestaurantDetailErrorState(detailResult.message);
        notifyListeners();
      } else {
        _state = RestaurantDetailLoadedState(detailResult.restaurant);
        notifyListeners();
      }
    } on Exception catch (e) {
      _state = RestaurantDetailErrorState("Failed to load data");
      notifyListeners();
    }
  }

  Future<void> addReview(String id, String name, String review) async {
    try {
      if (kDebugMode) {
        print('Adding review for restaurant $id by $name');
      }

      final result = await _restaurantApiService.addReview(
        id: id,
        name: name,
        review: review,
      );

      if (result.error) {
        throw Exception(result.message);
      }

      if (_state is RestaurantDetailLoadedState) {
        final currentState = _state as RestaurantDetailLoadedState;
        final currentRestaurant = currentState.data;

        final updatedRestaurant = RestaurantDetail(
          id: currentRestaurant.id,
          name: currentRestaurant.name,
          description: currentRestaurant.description,
          city: currentRestaurant.city,
          address: currentRestaurant.address,
          pictureId: currentRestaurant.pictureId,
          categories: currentRestaurant.categories,
          menus: currentRestaurant.menus,
          rating: currentRestaurant.rating,
          customerReviews: result.customerReviews,
        );

        _state = RestaurantDetailLoadedState(updatedRestaurant);
        notifyListeners();

        if (kDebugMode) {
          print(
            'Review added successfully, updated reviews count: ${result.customerReviews.length}',
          );
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error adding review: $e');
      }
      rethrow;
    }
  }

  Future<void> refreshRestaurantsDetail() async {
    fetchRestaurantDetail();
  }
}
