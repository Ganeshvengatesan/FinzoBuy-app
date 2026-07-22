import 'package:flutter/foundation.dart';
import '../../data/models/review_model.dart';
import '../../domain/repositories/review_repository.dart';

class WriteReviewController extends ChangeNotifier {
  final ReviewRepository _repository;

  WriteReviewController(this._repository);

  bool _isSubmitting = false;
  String _comment = '';
  List<String> _mediaPaths = [];
  String? _errorMessage;

  bool get isSubmitting => _isSubmitting;
  String get comment => _comment;
  List<String> get mediaPaths => _mediaPaths;
  String? get errorMessage => _errorMessage;

  void setComment(String comment) {
    _comment = comment;
    notifyListeners();
  }

  void addMediaPath(String path) {
    _mediaPaths = [..._mediaPaths, path];
    notifyListeners();
  }

  void removeMediaPath(int index) {
    if (index >= 0 && index < _mediaPaths.length) {
      final updated = List<String>.from(_mediaPaths);
      updated.removeAt(index);
      _mediaPaths = updated;
      notifyListeners();
    }
  }

  Future<bool> submitReview({
    required String orderId,
    required String productId,
    required String productTitle,
    required String productImageUrl,
  }) async {
    _isSubmitting = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final review = ReviewModel(
        orderId: orderId,
        productId: productId,
        productTitle: productTitle,
        productImageUrl: productImageUrl,
        comment: _comment,
        mediaPaths: _mediaPaths,
      );

      final success = await _repository.submitReview(review);
      return success;
    } catch (e) {
      _errorMessage = 'Failed to submit review. Please try again.';
      return false;
    } finally {
      _isSubmitting = false;
      notifyListeners();
    }
  }
}
