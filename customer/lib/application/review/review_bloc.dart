

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:bloc/bloc.dart';
import 'package:quick/domain/di/dependency_manager.dart';
import 'package:quick/domain/model/models.dart';
import 'package:quick/infrastructure/service/services.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

part 'review_event.dart';

part 'review_state.dart';

part 'review_bloc.freezed.dart';

class ReviewBloc extends Bloc<ReviewEvent, ReviewState> {
  int page = 0;

  ReviewBloc() : super(const ReviewState()) {

    on<SetReview>(setReview);

    on<SetImage>(setImage);

    on<SendReview>(sendReview);

    on<FetchReviewList>(fetchReviewList);

    on<FetchReview>(fetchReview);
  }

  setReview(event, emit) {
    emit(state.copyWith(review: event.review));
  }

  setImage(event, emit) {
    List<String> list = List.from(state.listOfImage);
    list.add(event.imagePath);
    emit(state.copyWith(listOfImage: list));
  }

  sendReview(event, emit) async {
    emit(state.copyWith(isButtonLoading: true));
    final List listOfImage = [];
    if (state.listOfImage.isNotEmpty) {
      final res = await galleryRepository.uploadMultipleImage(
          state.listOfImage, UploadType.reviews);
      res.fold((l) {
        listOfImage.addAll(l.data?.title ?? []);
      },
              (r) => AppHelpers.errorSnackBar(
              context: event.context, message: r.toString()));
    }
    final Either<bool, dynamic> res;
    if (event.userId != null) {
      res = await reviewRepository.sendReviewShop(
          list: listOfImage,
          userId: event.userId,
          title: event.comment,
          rate: state.review);
    } else if (event.productSlug != null) {
      res = await reviewRepository.sendReviewProduct(
          list: listOfImage,
          productUuid: event.productSlug,
          title: event.comment,
          rate: state.review);
    } else if (event.orderId != null) {
      res = await reviewRepository.sendReviewOrder(
          list: listOfImage,
          orderId: event.orderId,
          title: event.comment,
          rate: state.review);
    } else {
      res = await reviewRepository.sendReviewBlog(
          list: listOfImage,
          blogId: event.blogId,
          title: event.comment,
          rate: state.review);
    }

    res.fold((l) {
      emit(state.copyWith(isButtonLoading: false, isAddButton: false));
      event.onSuccess();
    }, (r) {
      emit(state.copyWith(isButtonLoading: false));
      AppHelpers.errorSnackBar(
          context: event.context, message: r,);
    });
  }

  fetchReviewList(event, emit) async {
    if (event.isRefresh ?? false) {
      event.controller?.resetNoData();
      page = 0;
      emit(state.copyWith(list: [], isLoading: true));
    }
    final res = await reviewRepository.fetchReviewList(
        requestModel: ReviewRequestModel(
            page: ++page,
            userId: event.userId,
            productSlug: event.productSlug,
            driverId: event.driverId,
            blogId: event.blogId));
    res.fold((l) {
      List<ReviewModel> list = List.from(state.list);
      list.addAll(l.data ?? []);
      emit(state.copyWith(
        isLoading: false,
        list: list,
      ));
      if (event.isRefresh ?? false) {
        event.controller?.refreshCompleted();
        return;
      } else if (l.data?.isEmpty ?? true) {
        event.controller?.loadNoData();
        return;
      }
      event.controller?.loadComplete();
      return;
    }, (r) {
      emit(state.copyWith(isLoading: false));
      if (event.isRefresh ?? false) {
        event.controller?.refreshFailed();
      }
      event.controller?.loadFailed();
      AppHelpers.errorSnackBar(
        context: event.context,
        message: r,
      );
    });
  }

  fetchReview(event, emit) async {
    if (event.blogId != null) {
      emit(state.copyWith(isAddButton: true));
      return;
    }
    final res = await reviewRepository.fetchReview(
      userId: event.userId,
      productId: event.productId,
      driverId: event.driverId,
    );

    res.fold((l) {
      emit(state.copyWith(reviewCount: l));
    }, (r) {
      AppHelpers.errorSnackBar(
          context: event.context, message: r,);
    });
    if (event.driverId == null) {
      final response = await reviewRepository.checkReview(
          productId: event.productId, userId: event.userId);
      response.fold((l) {
        emit(
          state.copyWith(
            isAddButton: ((l.data?.ordered ?? false)),
          ),
        );
      }, (r) {});
    } else {
      emit(state.copyWith(isAddButton: true));
    }
  }
}
