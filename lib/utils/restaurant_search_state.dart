import 'package:restaurant_app/data/models/restaurant.dart';

sealed class RestaurantSearchResultState {
  const RestaurantSearchResultState();
}

class RestaurantSearchLoadingState extends RestaurantSearchResultState {
  const RestaurantSearchLoadingState();
}

class RestaurantSearchNoneState extends RestaurantSearchResultState {
  final String? message;

  const RestaurantSearchNoneState({this.message});
}

class RestaurantSearchErrorState extends RestaurantSearchResultState {
  final String error;

  const RestaurantSearchErrorState(this.error);
}

class RestaurantSearchLoadedState extends RestaurantSearchResultState {
  final List<Restaurant> data;

  RestaurantSearchLoadedState(this.data);
}
