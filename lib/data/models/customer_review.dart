class CustomerReview {
  final String name;
  final String review;
  final String date;

  CustomerReview({
    required this.name,
    required this.review,
    required this.date,
  });

  factory CustomerReview.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {"name": String name, "review": String review, "date": String date} =>
        CustomerReview(name: name, review: review, date: date),
      _ => throw const FormatException('Failed to load customer review.'),
    };
  }
}

class CustomerReviewResponse {
  final bool error;
  final String message;
  final List<CustomerReview> customerReviews;

  CustomerReviewResponse({
    required this.error,
    required this.message,
    required this.customerReviews,
  });

  factory CustomerReviewResponse.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        "error": bool error,
        "message": String message,
        "customerReviews": List reviewsJson,
      } =>
        CustomerReviewResponse(
          error: error,
          message: message,
          customerReviews:
              reviewsJson
                  .map((review) => CustomerReview.fromJson(review))
                  .toList(),
        ),
      _ => throw const FormatException('Failed to load review response.'),
    };
  }
}
