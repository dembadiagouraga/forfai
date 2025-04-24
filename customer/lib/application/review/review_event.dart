part of 'review_bloc.dart';

@freezed
abstract class ReviewEvent with _$ReviewEvent {
  const factory ReviewEvent.setReview({required double review}) = SetReview;

  const factory ReviewEvent.sendReview(
      {required BuildContext context,
      required String comment,
      int? userId,
      String? productSlug,
      int? blogId,
        int? orderId,
      required VoidCallback onSuccess}) = SendReview;

  const factory ReviewEvent.fetchReview(
      {required BuildContext context,
      int? userId,
      int? blogId,
      int? driverId,
      int? productId}) = FetchReview;

  const factory ReviewEvent.setImage({required String imagePath}) = SetImage;

  const factory ReviewEvent.fetchReviewList(
      {required BuildContext context,
      int? userId,
      int? blogId,
      int? driverId,
      String? productSlug,
      bool? isRefresh,
      RefreshController? controller}) = FetchReviewList;
}
