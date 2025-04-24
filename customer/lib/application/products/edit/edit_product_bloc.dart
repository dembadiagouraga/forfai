

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:quick/domain/di/dependency_manager.dart';
import 'package:quick/domain/model/models.dart';
import 'package:quick/domain/model/request/selected_request.dart';
import 'package:quick/infrastructure/service/services.dart';

part 'edit_product_event.dart';

part 'edit_product_state.dart';

part 'edit_product_bloc.freezed.dart';

class EditProductBloc extends Bloc<EditProductEvent, EditProductState> {
  EditProductBloc() : super(const EditProductState()) {
    on<SetCountry>(setCountry);
    on<SetCity>(setCity);
    on<SetArea>(setArea);
    on<SetImageFile>(setImageFile);
    on<SetVideo>(setVideo);
    on<DeleteImage>(deleteImage);
    on<DeleteVideo>(deleteVideo);
    on<EditProduct>(editProduct);
    on<FetchProduct>(fetchProduct);
    on<SelectAttribute>(selectAttribute);
  }

  selectAttribute(SelectAttribute event, emit) {
    final i = state.attributes
        .indexWhere((e) => e.attributeId == event.attribute.attributeId);
    List<SelectedAttribute> attributes = List.from(state.attributes);
    if (i != -1) {
      if (event.attribute.type == 'checkbox') {
        List<int> list = List.from(state.attributes[i].values ?? []);
        if (list.contains(event.attribute.values?.first)) {
          list.remove(event.attribute.values?.first ?? -1);
        } else {
          list.addAll(event.attribute.values ?? []);
        }
        attributes[i] = state.attributes[i].copyWith(values: list);
      } else {
        if (attributes[i].valueId != event.attribute.valueId ||
            attributes[i].value != event.attribute.value) {
          attributes[i] = event.attribute;
        } else {
          attributes.removeAt(i);
        }
      }
    } else {
      attributes.add(event.attribute);
    }
    emit(state.copyWith(attributes: attributes));
  }

  setCountry(event, emit) {
    emit(
      state.copyWith(countryId: event.countryId, cityId: null, areaId: null),
    );
  }

  setCity(event, emit) {
    emit(state.copyWith(
      cityId: event.cityId,
      areaId: event.cityId == state.cityId ? state.cityId : null,
    ));
  }

  setArea(event, emit) {
    emit(state.copyWith(areaId: event.areaId));
  }

  setImageFile(event, emit) {
    List<String> list = List.from(state.images);
    list.add(event.file);
    emit(state.copyWith(images: list));
  }

  deleteImage(event, emit) {
    List<String> list = List.from(state.images);
    list.remove(event.value);
    List<Galleries> urls = List.from(state.listOfUrls);
    urls.removeWhere((e) => e.path == event.value);
    emit(state.copyWith(images: list, listOfUrls: urls));
  }

  setVideo(event, emit) {
    emit(state.copyWith(video: event.gallery));
  }

  deleteVideo(event, emit) {
    emit(state.copyWith(video: null));
  }

  fetchProduct(FetchProduct event, emit) async {
    final urls = event.product.galleries ?? [];
    final Galleries? gallery = urls.isNotEmpty ? urls.first : null;
    final Galleries? video = gallery?.preview != null ? gallery : null;
    emit(
      state.copyWith(
          product: event.product,
          isLoading: true,
          listOfUrls: urls.sublist(video != null ? 1 : 0),
          video: video
          // countryId: event.product.,
          ),
    );
    final res = await productsRepository
        .getUserProductDetails(event.product.slug ?? '');
    res.fold((l) {
      emit(state.copyWith(
          product: l.data,
          countryId: l.data?.country?.id,
          cityId: l.data?.city?.id,
          areaId: l.data?.area?.id,
          regionId: l.data?.country?.regionId,
          isLoading: false,
          attributes: AppHelpers.attributeHelper(l.data?.attributes)));
    }, (r) {
      emit(state.copyWith(isLoading: false));
    });
  }

  editProduct(EditProduct event, emit) async {
    emit(state.copyWith(isLoading: true));

    List<String> imageUrl = await uploadImages(event, emit);
    List<String> previews = [];
    if (state.video != null) {
      imageUrl.insert(0, state.video?.path ?? '');
      previews = [state.video?.preview ?? ''];
    }
    final res = await productsRepository.updateProduct(
      productRequest: event.productRequest.copyWith(
        previews: previews,
        images: imageUrl,
        regionId: event.productRequest.regionId ?? state.regionId,
        countryId: state.countryId,
        cityId: state.cityId,
        areaId: state.areaId,
        attributes: state.attributes,
      ),
      slug: state.product?.slug ?? '',
    );
    res.fold(
      (l) {
        emit(state.copyWith(isLoading: false));
        event.updated?.call();
      },
      (failure) {
        debugPrint('===> update product fail $failure');
        emit(state.copyWith(isLoading: false));
        AppHelpers.errorSnackBar(context: event.context, message: failure);
        event.onError?.call();
      },
    );
  }

  uploadImages(event, emit) async {
    List<String> imageUrl = List.from(state.listOfUrls.map((e) => e.path));

    if (state.images.isNotEmpty) {
      final imageResponse = await galleryRepository.uploadMultipleImage(
        state.images,
        UploadType.products,
      );
      imageResponse.fold(
        (data) {
          imageUrl.addAll(data.data?.title ?? []);
        },
        (failure) {
          debugPrint('==> upload product image fail: $failure');
          AppHelpers.errorSnackBar(context: event.context, message: failure);
        },
      );
    }

    return imageUrl;
  }
}
