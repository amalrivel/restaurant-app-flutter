class Restaurant {
  final String id;
  final String name;
  final String description;
  final String pictureId;
  final String city;
  final String rating;

  Restaurant({
    required this.id,
    required this.name,
    required this.description,
    required this.pictureId,
    required this.city,
    required this.rating,
  });

  factory Restaurant.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        "id": String id,
        "name": String name,
        "description": String description,
        "pictureId": String pictureId,
        "city": String city,
        "rating": dynamic rating,
      } =>
        Restaurant(
          id: id,
          name: name,
          description: description,
          pictureId: pictureId,
          city: city,
          rating: rating.toString(),
        ),
      _ => throw const FormatException('Failed to load restaurant data.'),
    };
  }
}

class RestaurantResponse {
  final bool error;
  final String message;
  final int count;
  final List<Restaurant> restaurants;

  RestaurantResponse({
    required this.error,
    required this.message,
    required this.count,
    required this.restaurants,
  });

  factory RestaurantResponse.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        "error": bool error,
        "message": String message,
        "count": int count,
        "restaurants": List restaurantJson,
      } =>
        RestaurantResponse(
          error: error,
          message: message,
          count: count,
          restaurants:
              restaurantJson
                  .map((restaurant) => Restaurant.fromJson(restaurant))
                  .toList(),
        ),
      _ => throw const FormatException('Failed to load restaurant response.'),
    };
  }
}
