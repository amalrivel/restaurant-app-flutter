import 'package:flutter/material.dart';

class ReviewFormProvider extends ChangeNotifier {
  bool _isSubmitting = false;
  bool get isSubmitting => _isSubmitting;

  void setSubmitting(bool value) {
    _isSubmitting = value;
    notifyListeners();
  }
}
