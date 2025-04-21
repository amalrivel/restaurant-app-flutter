import 'dart:convert';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:restaurant_app/data/models/customer_review.dart';
import 'package:restaurant_app/data/models/restaurant.dart';
import 'package:http/http.dart' as http;
import 'package:restaurant_app/data/models/restaurant_detail.dart';
import 'package:restaurant_app/data/models/restaurant_search.dart';

class RestaurantApiService {
  static const String _baseUrl = 'https://restaurant-api.dicoding.dev/';

  Future<RestaurantResponse> getRestaurants() async {
    if (kDebugMode) {
      print("Fetching restaurants from API...");
    }

    try {
      final response = await http.get(Uri.parse('${_baseUrl}list'));

      if (kDebugMode) {
        print("Response status code: ${response.statusCode}");
        print(
          "Response body preview: ${response.body.substring(0, min(100, response.body.length))}...",
        );
      }

      if (response.statusCode == 200) {
        try {
          final RestaurantResponse restaurantResponse =
              RestaurantResponse.fromJson(jsonDecode(response.body));

          if (kDebugMode) {
            print(
              "Successfully parsed JSON, found ${restaurantResponse.restaurants.length} restaurants",
            );
          }

          return restaurantResponse;
        } catch (e) {
          if (kDebugMode) {
            print("JSON parsing error: $e");
            print("Raw response: ${response.body}");
          }
          throw FormatException('Failed to parse API response: $e');
        }
      } else {
        throw Exception(
          'Failed to load restaurants list: ${response.statusCode}',
        );
      }
    } catch (e) {
      if (kDebugMode) {
        print("Network or parsing error: $e");
      }
      rethrow;
    }
  }

  Future<RestaurantDetailResponse> getRestaurantDetail(String id) async {
    final response = await http.get(Uri.parse('$_baseUrl/detail/$id'));

    if (response.statusCode == 200) {
      final RestaurantDetailResponse detailResponse =
          RestaurantDetailResponse.fromJson(jsonDecode(response.body));
      return detailResponse;
    } else {
      throw Exception('Failed to load restaurant detail');
    }
  }

  Future<RestaurantSearchResponse> searchRestaurants(String query) async {
    final response = await http.get(
      Uri.parse('$_baseUrl/search?q=${Uri.encodeComponent(query)}'),
    );

    if (response.statusCode == 200) {
      final RestaurantSearchResponse restaurantSearch =
          RestaurantSearchResponse.fromJson(jsonDecode(response.body));
      return restaurantSearch;
    } else {
      throw Exception('Failed to search restaurants: ${response.statusCode}');
    }
  }

  Future<CustomerReviewResponse> addReview({
    required String id,
    required String name,
    required String review,
  }) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/review'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'id': id, 'name': name, 'review': review}),
    );

    if (response.statusCode == 201) {
      final CustomerReviewResponse reviewResponse =
          CustomerReviewResponse.fromJson(jsonDecode(response.body));
      return reviewResponse;
    } else {
      throw Exception('Failed to add review');
    }
  }
}
