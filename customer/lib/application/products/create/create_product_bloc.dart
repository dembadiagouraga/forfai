

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:quick/domain/di/dependency_manager.dart';
import 'package:quick/domain/model/models.dart';
import 'package:quick/domain/model/request/selected_request.dart';
import 'package:quick/infrastructure/service/services.dart';

part 'create_product_event.dart';

part 'create_product_state.dart';

part 'create_product_bloc.freezed.dart';

class CreateProductBloc extends Bloc<CreateProductEvent, CreateProductState> {
  CreateProductBloc() : super(const CreateProductState()) {
    on<SetCountry>(setCountry);
    on<SetCity>(setCity);
    on<SetImageFile>(setImageFile);
    on<SetVideo>(setVideo);
    on<DeleteImage>(deleteImage);
    on<DeleteVideo>(deleteVideo);
    on<CreateProduct>(createProduct);
    on<SelectAttribute>(selectAttribute);
  }

  setCountry(event, emit) {
    emit(state.copyWith(countryId: event.countryId));
  }

  setCity(event, emit) {
    emit(state.copyWith(cityId: event.cityId));
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

  setImageFile(event, emit) {
    List<String> list = List.from(state.images);
    list.add(event.file);
    emit(state.copyWith(images: list));
  }

  deleteImage(event, emit) {
    List<String> list = List.from(state.images);
    list.remove(event.value);
    emit(state.copyWith(images: list));
  }

  setVideo(event, emit) {
    emit(state.copyWith(video: event.gallery));
  }

  deleteVideo(event, emit) {
    emit(state.copyWith(video: null));
  }

  createProduct(CreateProduct event, emit) async {
    if (state.images.isEmpty) {
      AppHelpers.errorSnackBar(
          context: event.context,
          message: AppHelpers.getTranslation(TrKeys.pleaseSelectImage));
      return;
    }
    emit(state.copyWith(isLoading: true));
    List<String> imageUrl = List.from(state.listOfUrls.map((e) => e.path));
    if (state.images.isNotEmpty) {
      final imageResponse = await galleryRepository.uploadMultipleImage(
        state.images,
        UploadType.products,
      );
      imageResponse.fold(
        (data) {
          imageUrl = data.data?.title ?? [];
        },
        (failure) {
          debugPrint('==> upload product image fail: $failure');
          AppHelpers.errorSnackBar(context: event.context, message: failure);
        },
      );
    }
    List<String> previews = [];
    if (state.video != null) {
      imageUrl.insert(0, state.video?.path ?? '');
      previews = [state.video?.preview ?? ''];
    }

    final res = await productsRepository.createProduct(
      productRequest: event.productRequest.copyWith(
        previews: previews,
        images: imageUrl,
        attributes: state.attributes,
      ),
    );
    res.fold(
      (l) {
        emit(state.copyWith(isLoading: false));
        event.created?.call(l.data);
      },
      (failure) {
        debugPrint('===> create product fail $failure');
        emit(state.copyWith(isLoading: false));
        AppHelpers.errorSnackBar(context: event.context, message: failure);
        event.onError?.call();
        // clearAll();
      },
    );
  }
}
