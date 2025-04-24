class ReviewRequestModel {
  final int? userId;
  final int? blogId;
  final int? driverId;
  final String? productSlug;
  final int? page;

  ReviewRequestModel(
      {required this.userId,
      required this.blogId,
      required this.driverId,
      required this.productSlug,
      required this.page});

  factory ReviewRequestModel.fromJson({
    int? userId,
    int? blogId,
    int? driverId,
    String? productUuid,
    int? page,
  }) {
    return ReviewRequestModel(
        userId: userId,
        blogId: blogId,
        driverId: driverId,
        productSlug: productUuid,
        page: page);
  }
}
