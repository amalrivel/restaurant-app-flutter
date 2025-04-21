import 'package:restaurant_app/data/models/customer_review.dart';

class RestaurantDetail {
  final String id;
  final String name;
  final String description;
  final String city;
  final String address;
  final String pictureId;
  final List<Category> categories;
  final Menus menus;
  final String rating;
  final List<CustomerReview> customerReviews;

  RestaurantDetail({
    required this.id,
    required this.name,
    required this.description,
    required this.city,
    required this.address,
    required this.pictureId,
    required this.categories,
    required this.menus,
    required this.rating,
    required this.customerReviews,
  });

  factory RestaurantDetail.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        "id": String id,
        "name": String name,
        "description": String description,
        "city": String city,
        "address": String address,
        "pictureId": String pictureId,
        "categories": List categoriesJson,
        "menus": Map<String, dynamic> menusJson,
        "rating": dynamic rating,
        "customerReviews": List reviewsJson,
      } =>
        RestaurantDetail(
          id: id,
          name: name,
          description: description,
          city: city,
          address: address,
          pictureId: pictureId,
          categories:
              categoriesJson
                  .map((category) => Category.fromJson(category))
                  .toList(),
          menus: Menus.fromJson(menusJson),
          rating: rating.toString(),
          customerReviews:
              reviewsJson
                  .map((review) => CustomerReview.fromJson(review))
                  .toList(),
        ),
      _ => throw const FormatException('Failed to load restaurant detail.'),
    };
  }
}

class Category {
  final String name;

  Category({required this.name});

  factory Category.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {"name": String name} => Category(name: name),
      _ => throw const FormatException('Failed to load category.'),
    };
  }
}

class Menus {
  final List<MenuItem> foods;
  final List<MenuItem> drinks;

  Menus({required this.foods, required this.drinks});

  factory Menus.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {"foods": List foodsJson, "drinks": List drinksJson} => Menus(
        foods: foodsJson.map((food) => MenuItem.fromJson(food)).toList(),
        drinks: drinksJson.map((drink) => MenuItem.fromJson(drink)).toList(),
      ),
      _ => throw const FormatException('Failed to load menus.'),
    };
  }
}

class MenuItem {
  final String name;

  MenuItem({required this.name});

  factory MenuItem.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {"name": String name} => MenuItem(name: name),
      _ => throw const FormatException('Failed to load menu item.'),
    };
  }
}

class RestaurantDetailResponse {
  final bool error;
  final String message;
  final RestaurantDetail restaurant;

  RestaurantDetailResponse({
    required this.error,
    required this.message,
    required this.restaurant,
  });

  factory RestaurantDetailResponse.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        "error": bool error,
        "message": String message,
        "restaurant": Map<String, dynamic> restaurantJson,
      } =>
        RestaurantDetailResponse(
          error: error,
          message: message,
          restaurant: RestaurantDetail.fromJson(restaurantJson),
        ),
      _ =>
        throw const FormatException(
          'Failed to load restaurant detail response.',
        ),
    };
  }
}
