import '../../domain/repositories/review_repository.dart';
import '../models/review_model.dart';

class ReviewRepositoryImpl implements ReviewRepository {
  @override
  Future<bool> submitReview(ReviewModel review) async {
    // Simulate brief network request
    await Future.delayed(const Duration(milliseconds: 300));
    return true;
  }
}
