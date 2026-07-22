import '../../data/models/review_model.dart';

abstract class ReviewRepository {
  Future<bool> submitReview(ReviewModel review);
}
