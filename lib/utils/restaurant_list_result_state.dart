import 'package:restaurant_app/data/models/restaurant.dart';

sealed class RestaurantListResultState {
  const RestaurantListResultState();
}

class RestaurantListLoadingState extends RestaurantListResultState {
  const RestaurantListLoadingState();
}

class RestaurantListNoneState extends RestaurantListResultState {
  final String? message;

  const RestaurantListNoneState({this.message});
}

class RestaurantListErrorState extends RestaurantListResultState {
  final String error;

  const RestaurantListErrorState(this.error);
}

class RestaurantListLoadedState extends RestaurantListResultState {
  final List<Restaurant> data;

  RestaurantListLoadedState(this.data);
}
