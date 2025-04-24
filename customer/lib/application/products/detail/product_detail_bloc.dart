

import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:quick/domain/di/dependency_manager.dart';
import 'package:quick/domain/model/models.dart';
import 'package:quick/infrastructure/service/services.dart';
import 'package:quick/infrastructure/local_storage/local_storage.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:url_launcher/url_launcher.dart';

part 'product_detail_event.dart';

part 'product_detail_state.dart';

part 'product_detail_bloc.freezed.dart';

class ProductDetailBloc extends Bloc<ProductDetailEvent, ProductDetailState> {
  int related = 0;
  int viewed = 0;
  int buyWith = 0;

  ProductDetailBloc() : super(const ProductDetailState()) {
    on<FetchViewedProducts>(fetchViewedProducts);

    on<FetchRelatedProduct>(fetchRelatedProduct);

    on<FetchProductById>(fetchProductById);

    on<SetSelectedIndexes>(setSelectedIndexes);

    on<UpdateSelectedIndexes>(updateSelectedIndexes);

    on<UpdateState>(updateState);

    on<SelectImage>(selectImage);

    on<ShowPhone>(showPhone);
  }

  showPhone(event, emit) async {
    emit(state.copyWith(isLoadingPhone: true));

    final res = await productsRepository.getPhone(
      slug: state.product?.slug ?? '',
    );
    res.fold((l) {
      try {
        final Uri smsLaunchUri =
            Uri(scheme: 'tel', path: "+${l.replaceAll('+', '')}");
        launchUrl(smsLaunchUri);
        emit(state.copyWith(isLoadingPhone: false));
      } catch (e) {
        emit(state.copyWith(isLoadingPhone: false));
        AppHelpers.openDialog(context: event.context, title: e.toString());
      }
    }, (r) {
      emit(state.copyWith(isLoadingPhone: false));
      AppHelpers.openDialog(
          context: event.context,
          title: AppHelpers.getTranslation(TrKeys.thisUserDontEnterContact));
    });
  }

  fetchViewedProducts(event, emit) async {
    emit(state.copyWith(viewedProduct: []));
    viewed = 1;
    List<int> list = LocalStorage.getViewedProductsList();
    list.remove(event.productId);
    if (list.isEmpty && LocalStorage.getToken().isEmpty) {
      return;
    }
    final Either<ProductsPaginateResponse, dynamic> res;
    if (LocalStorage.getToken().isEmpty) {
      res = await productsRepository.getProductsByIds(list);
    } else {
      res = await productsRepository.getProductsViewed(
          page: viewed, productId: event.productId ?? 0);
    }

    res.fold((l) {
      emit(state.copyWith(
        viewedProduct: l.data ?? [],
      ));
      if (l.data?.isEmpty ?? true) {
        event.controller?.loadNoData();
        return;
      }
      event.controller?.loadComplete();
      return;
    }, (r) {
      event.controller?.loadFailed();
      AppHelpers.errorSnackBar(
        context: event.context,
        message: r,
      );
    });
  }

  fetchRelatedProduct(event, emit) async {
    if (event.isRefresh ?? false) {
      event.controller?.resetNoData();
      related = 0;
      emit(state.copyWith(relatedProduct: []));
    }
    final res = await productsRepository.getRelatedProducts(
        page: ++related, productSlug: event.slug);
    res.fold((l) {
      List<ProductData> list = List.from(state.relatedProduct);
      list.addAll(l.data ?? []);
      emit(state.copyWith(
        relatedProduct: list,
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

  fetchProductById(event, emit) async {
    LocalStorage.setViewedProductsList(event.product?.id ?? 0);

    emit(state.copyWith(
        product: event.product,
        isLoading: true,
        galleries: [Galleries(path: event.product?.img)],
        selectImage: (event.product?.galleries?.isNotEmpty ?? false)
            ? event.product?.galleries?.first
            : Galleries(path: event.product?.img)));
    final res =
        await productsRepository.getProductDetails(event.product?.slug ?? "");

    res.fold((l) {
      final List<Galleries> galleries = l.data?.galleries ?? [];

      emit(state.copyWith(
          product: l.data,
          galleries: galleries,
          isLoading: false,
          selectImage: (l.data?.galleries?.isNotEmpty ?? false)
              ? l.data?.galleries?.first
              : null));
      event.controller?.refreshCompleted();
      return;
    }, (r) {
      emit(state.copyWith(isLoading: false));
      AppHelpers.errorSnackBar(
        context: event.context,
        message: r,
      );
    });
  }

  setSelectedIndexes(event, emit) {
    emit(state.copyWith(selectedIndexes: event.indexes));
    event.context
        .read<ProductDetailBloc>()
        .add(const ProductDetailEvent.updateExtras());
  }

  updateSelectedIndexes(event, emit) {
    final newList = state.selectedIndexes.sublist(0, event.id);
    newList.add(event.value);
    final postList =
        List.filled(state.selectedIndexes.length - newList.length, 0);
    newList.addAll(postList);
    add(ProductDetailEvent.setSelectedIndexes(
        indexes: newList, context: event.context));
  }

  updateState(event, emit) {
    emit(state.copyWith(isLoadingNew: !state.isLoadingNew));
    emit(state.copyWith(isLoadingNew: !state.isLoadingNew));
  }

  selectImage(event, emit) {
    //Do not touch this place, it is necessary for animation when scrolling the image
    emit(state.copyWith(
        selectImage: event.image,
        jumpTo: (event.jumpTo ?? false),
        nextImageTo: (event.nextImageTo ?? false)));
  }
}
