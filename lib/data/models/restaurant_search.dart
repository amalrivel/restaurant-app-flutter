import 'package:restaurant_app/data/models/restaurant.dart';

class RestaurantSearchResponse {
  final bool error;
  final int founded;
  final List<Restaurant> restaurants;

  RestaurantSearchResponse({
    required this.error,
    required this.founded,
    required this.restaurants,
  });

  factory RestaurantSearchResponse.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        "error": bool error,
        "founded": int founded,
        "restaurants": List restaurantJson,
      } =>
        RestaurantSearchResponse(
          error: error,
          founded: founded,
          restaurants:
              restaurantJson
                  .map((restaurant) => Restaurant.fromJson(restaurant))
                  .toList(),
        ),
      _ =>
        throw const FormatException('Failed to load restaurant search data.'),
    };
  }
}
