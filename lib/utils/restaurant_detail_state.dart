import 'package:restaurant_app/data/models/restaurant_detail.dart';

sealed class RestaurantDetailResultState {
  const RestaurantDetailResultState();
}

class RestaurantDetailLoadingState extends RestaurantDetailResultState {
  const RestaurantDetailLoadingState();
}

class RestaurantDetailNoneState extends RestaurantDetailResultState {
  final String? message;

  const RestaurantDetailNoneState({this.message});
}

class RestaurantDetailErrorState extends RestaurantDetailResultState {
  final String error;

  const RestaurantDetailErrorState(this.error);
}

class RestaurantDetailLoadedState extends RestaurantDetailResultState {
  final RestaurantDetail data;

  RestaurantDetailLoadedState(this.data);
}
