class RestaurantImageUrl {
  static const String _baseUrl = 'https://restaurant-api.dicoding.dev/images';

  static String small(String pictureId) => '$_baseUrl/small/$pictureId';

  static String medium(String pictureId) => '$_baseUrl/medium/$pictureId';

  static String large(String pictureId) => '$_baseUrl/large/$pictureId';
}
