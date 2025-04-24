// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'edit_product_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$EditProductEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int? countryId) setCountry,
    required TResult Function(int? cityId) setCity,
    required TResult Function(int? cityId) setArea,
    required TResult Function(String file) setImageFile,
    required TResult Function(Galleries gallery) setVideo,
    required TResult Function(String value) deleteImage,
    required TResult Function() deleteVideo,
    required TResult Function(ProductData product) fetchProduct,
    required TResult Function(SelectedAttribute attribute) selectAttribute,
    required TResult Function(
            BuildContext context,
            ProductRequest productRequest,
            VoidCallback? updated,
            VoidCallback? onError)
        editProduct,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int? countryId)? setCountry,
    TResult? Function(int? cityId)? setCity,
    TResult? Function(int? cityId)? setArea,
    TResult? Function(String file)? setImageFile,
    TResult? Function(Galleries gallery)? setVideo,
    TResult? Function(String value)? deleteImage,
    TResult? Function()? deleteVideo,
    TResult? Function(ProductData product)? fetchProduct,
    TResult? Function(SelectedAttribute attribute)? selectAttribute,
    TResult? Function(BuildContext context, ProductRequest productRequest,
            VoidCallback? updated, VoidCallback? onError)?
        editProduct,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int? countryId)? setCountry,
    TResult Function(int? cityId)? setCity,
    TResult Function(int? cityId)? setArea,
    TResult Function(String file)? setImageFile,
    TResult Function(Galleries gallery)? setVideo,
    TResult Function(String value)? deleteImage,
    TResult Function()? deleteVideo,
    TResult Function(ProductData product)? fetchProduct,
    TResult Function(SelectedAttribute attribute)? selectAttribute,
    TResult Function(BuildContext context, ProductRequest productRequest,
            VoidCallback? updated, VoidCallback? onError)?
        editProduct,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SetCountry value) setCountry,
    required TResult Function(SetCity value) setCity,
    required TResult Function(SetArea value) setArea,
    required TResult Function(SetImageFile value) setImageFile,
    required TResult Function(SetVideo value) setVideo,
    required TResult Function(DeleteImage value) deleteImage,
    required TResult Function(DeleteVideo value) deleteVideo,
    required TResult Function(FetchProduct value) fetchProduct,
    required TResult Function(SelectAttribute value) selectAttribute,
    required TResult Function(EditProduct value) editProduct,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SetCountry value)? setCountry,
    TResult? Function(SetCity value)? setCity,
    TResult? Function(SetArea value)? setArea,
    TResult? Function(SetImageFile value)? setImageFile,
    TResult? Function(SetVideo value)? setVideo,
    TResult? Function(DeleteImage value)? deleteImage,
    TResult? Function(DeleteVideo value)? deleteVideo,
    TResult? Function(FetchProduct value)? fetchProduct,
    TResult? Function(SelectAttribute value)? selectAttribute,
    TResult? Function(EditProduct value)? editProduct,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SetCountry value)? setCountry,
    TResult Function(SetCity value)? setCity,
    TResult Function(SetArea value)? setArea,
    TResult Function(SetImageFile value)? setImageFile,
    TResult Function(SetVideo value)? setVideo,
    TResult Function(DeleteImage value)? deleteImage,
    TResult Function(DeleteVideo value)? deleteVideo,
    TResult Function(FetchProduct value)? fetchProduct,
    TResult Function(SelectAttribute value)? selectAttribute,
    TResult Function(EditProduct value)? editProduct,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EditProductEventCopyWith<$Res> {
  factory $EditProductEventCopyWith(
          EditProductEvent value, $Res Function(EditProductEvent) then) =
      _$EditProductEventCopyWithImpl<$Res, EditProductEvent>;
}

/// @nodoc
class _$EditProductEventCopyWithImpl<$Res, $Val extends EditProductEvent>
    implements $EditProductEventCopyWith<$Res> {
  _$EditProductEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of EditProductEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$SetCountryImplCopyWith<$Res> {
  factory _$$SetCountryImplCopyWith(
          _$SetCountryImpl value, $Res Function(_$SetCountryImpl) then) =
      __$$SetCountryImplCopyWithImpl<$Res>;
  @useResult
  $Res call({int? countryId});
}

/// @nodoc
class __$$SetCountryImplCopyWithImpl<$Res>
    extends _$EditProductEventCopyWithImpl<$Res, _$SetCountryImpl>
    implements _$$SetCountryImplCopyWith<$Res> {
  __$$SetCountryImplCopyWithImpl(
      _$SetCountryImpl _value, $Res Function(_$SetCountryImpl) _then)
      : super(_value, _then);

  /// Create a copy of EditProductEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? countryId = freezed,
  }) {
    return _then(_$SetCountryImpl(
      countryId: freezed == countryId
          ? _value.countryId
          : countryId // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc

class _$SetCountryImpl implements SetCountry {
  const _$SetCountryImpl({this.countryId});

  @override
  final int? countryId;

  @override
  String toString() {
    return 'EditProductEvent.setCountry(countryId: $countryId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SetCountryImpl &&
            (identical(other.countryId, countryId) ||
                other.countryId == countryId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, countryId);

  /// Create a copy of EditProductEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SetCountryImplCopyWith<_$SetCountryImpl> get copyWith =>
      __$$SetCountryImplCopyWithImpl<_$SetCountryImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int? countryId) setCountry,
    required TResult Function(int? cityId) setCity,
    required TResult Function(int? cityId) setArea,
    required TResult Function(String file) setImageFile,
    required TResult Function(Galleries gallery) setVideo,
    required TResult Function(String value) deleteImage,
    required TResult Function() deleteVideo,
    required TResult Function(ProductData product) fetchProduct,
    required TResult Function(SelectedAttribute attribute) selectAttribute,
    required TResult Function(
            BuildContext context,
            ProductRequest productRequest,
            VoidCallback? updated,
            VoidCallback? onError)
        editProduct,
  }) {
    return setCountry(countryId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int? countryId)? setCountry,
    TResult? Function(int? cityId)? setCity,
    TResult? Function(int? cityId)? setArea,
    TResult? Function(String file)? setImageFile,
    TResult? Function(Galleries gallery)? setVideo,
    TResult? Function(String value)? deleteImage,
    TResult? Function()? deleteVideo,
    TResult? Function(ProductData product)? fetchProduct,
    TResult? Function(SelectedAttribute attribute)? selectAttribute,
    TResult? Function(BuildContext context, ProductRequest productRequest,
            VoidCallback? updated, VoidCallback? onError)?
        editProduct,
  }) {
    return setCountry?.call(countryId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int? countryId)? setCountry,
    TResult Function(int? cityId)? setCity,
    TResult Function(int? cityId)? setArea,
    TResult Function(String file)? setImageFile,
    TResult Function(Galleries gallery)? setVideo,
    TResult Function(String value)? deleteImage,
    TResult Function()? deleteVideo,
    TResult Function(ProductData product)? fetchProduct,
    TResult Function(SelectedAttribute attribute)? selectAttribute,
    TResult Function(BuildContext context, ProductRequest productRequest,
            VoidCallback? updated, VoidCallback? onError)?
        editProduct,
    required TResult orElse(),
  }) {
    if (setCountry != null) {
      return setCountry(countryId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SetCountry value) setCountry,
    required TResult Function(SetCity value) setCity,
    required TResult Function(SetArea value) setArea,
    required TResult Function(SetImageFile value) setImageFile,
    required TResult Function(SetVideo value) setVideo,
    required TResult Function(DeleteImage value) deleteImage,
    required TResult Function(DeleteVideo value) deleteVideo,
    required TResult Function(FetchProduct value) fetchProduct,
    required TResult Function(SelectAttribute value) selectAttribute,
    required TResult Function(EditProduct value) editProduct,
  }) {
    return setCountry(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SetCountry value)? setCountry,
    TResult? Function(SetCity value)? setCity,
    TResult? Function(SetArea value)? setArea,
    TResult? Function(SetImageFile value)? setImageFile,
    TResult? Function(SetVideo value)? setVideo,
    TResult? Function(DeleteImage value)? deleteImage,
    TResult? Function(DeleteVideo value)? deleteVideo,
    TResult? Function(FetchProduct value)? fetchProduct,
    TResult? Function(SelectAttribute value)? selectAttribute,
    TResult? Function(EditProduct value)? editProduct,
  }) {
    return setCountry?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SetCountry value)? setCountry,
    TResult Function(SetCity value)? setCity,
    TResult Function(SetArea value)? setArea,
    TResult Function(SetImageFile value)? setImageFile,
    TResult Function(SetVideo value)? setVideo,
    TResult Function(DeleteImage value)? deleteImage,
    TResult Function(DeleteVideo value)? deleteVideo,
    TResult Function(FetchProduct value)? fetchProduct,
    TResult Function(SelectAttribute value)? selectAttribute,
    TResult Function(EditProduct value)? editProduct,
    required TResult orElse(),
  }) {
    if (setCountry != null) {
      return setCountry(this);
    }
    return orElse();
  }
}

abstract class SetCountry implements EditProductEvent {
  const factory SetCountry({final int? countryId}) = _$SetCountryImpl;

  int? get countryId;

  /// Create a copy of EditProductEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SetCountryImplCopyWith<_$SetCountryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SetCityImplCopyWith<$Res> {
  factory _$$SetCityImplCopyWith(
          _$SetCityImpl value, $Res Function(_$SetCityImpl) then) =
      __$$SetCityImplCopyWithImpl<$Res>;
  @useResult
  $Res call({int? cityId});
}

/// @nodoc
class __$$SetCityImplCopyWithImpl<$Res>
    extends _$EditProductEventCopyWithImpl<$Res, _$SetCityImpl>
    implements _$$SetCityImplCopyWith<$Res> {
  __$$SetCityImplCopyWithImpl(
      _$SetCityImpl _value, $Res Function(_$SetCityImpl) _then)
      : super(_value, _then);

  /// Create a copy of EditProductEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? cityId = freezed,
  }) {
    return _then(_$SetCityImpl(
      cityId: freezed == cityId
          ? _value.cityId
          : cityId // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc

class _$SetCityImpl implements SetCity {
  const _$SetCityImpl({this.cityId});

  @override
  final int? cityId;

  @override
  String toString() {
    return 'EditProductEvent.setCity(cityId: $cityId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SetCityImpl &&
            (identical(other.cityId, cityId) || other.cityId == cityId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, cityId);

  /// Create a copy of EditProductEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SetCityImplCopyWith<_$SetCityImpl> get copyWith =>
      __$$SetCityImplCopyWithImpl<_$SetCityImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int? countryId) setCountry,
    required TResult Function(int? cityId) setCity,
    required TResult Function(int? cityId) setArea,
    required TResult Function(String file) setImageFile,
    required TResult Function(Galleries gallery) setVideo,
    required TResult Function(String value) deleteImage,
    required TResult Function() deleteVideo,
    required TResult Function(ProductData product) fetchProduct,
    required TResult Function(SelectedAttribute attribute) selectAttribute,
    required TResult Function(
            BuildContext context,
            ProductRequest productRequest,
            VoidCallback? updated,
            VoidCallback? onError)
        editProduct,
  }) {
    return setCity(cityId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int? countryId)? setCountry,
    TResult? Function(int? cityId)? setCity,
    TResult? Function(int? cityId)? setArea,
    TResult? Function(String file)? setImageFile,
    TResult? Function(Galleries gallery)? setVideo,
    TResult? Function(String value)? deleteImage,
    TResult? Function()? deleteVideo,
    TResult? Function(ProductData product)? fetchProduct,
    TResult? Function(SelectedAttribute attribute)? selectAttribute,
    TResult? Function(BuildContext context, ProductRequest productRequest,
            VoidCallback? updated, VoidCallback? onError)?
        editProduct,
  }) {
    return setCity?.call(cityId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int? countryId)? setCountry,
    TResult Function(int? cityId)? setCity,
    TResult Function(int? cityId)? setArea,
    TResult Function(String file)? setImageFile,
    TResult Function(Galleries gallery)? setVideo,
    TResult Function(String value)? deleteImage,
    TResult Function()? deleteVideo,
    TResult Function(ProductData product)? fetchProduct,
    TResult Function(SelectedAttribute attribute)? selectAttribute,
    TResult Function(BuildContext context, ProductRequest productRequest,
            VoidCallback? updated, VoidCallback? onError)?
        editProduct,
    required TResult orElse(),
  }) {
    if (setCity != null) {
      return setCity(cityId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SetCountry value) setCountry,
    required TResult Function(SetCity value) setCity,
    required TResult Function(SetArea value) setArea,
    required TResult Function(SetImageFile value) setImageFile,
    required TResult Function(SetVideo value) setVideo,
    required TResult Function(DeleteImage value) deleteImage,
    required TResult Function(DeleteVideo value) deleteVideo,
    required TResult Function(FetchProduct value) fetchProduct,
    required TResult Function(SelectAttribute value) selectAttribute,
    required TResult Function(EditProduct value) editProduct,
  }) {
    return setCity(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SetCountry value)? setCountry,
    TResult? Function(SetCity value)? setCity,
    TResult? Function(SetArea value)? setArea,
    TResult? Function(SetImageFile value)? setImageFile,
    TResult? Function(SetVideo value)? setVideo,
    TResult? Function(DeleteImage value)? deleteImage,
    TResult? Function(DeleteVideo value)? deleteVideo,
    TResult? Function(FetchProduct value)? fetchProduct,
    TResult? Function(SelectAttribute value)? selectAttribute,
    TResult? Function(EditProduct value)? editProduct,
  }) {
    return setCity?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SetCountry value)? setCountry,
    TResult Function(SetCity value)? setCity,
    TResult Function(SetArea value)? setArea,
    TResult Function(SetImageFile value)? setImageFile,
    TResult Function(SetVideo value)? setVideo,
    TResult Function(DeleteImage value)? deleteImage,
    TResult Function(DeleteVideo value)? deleteVideo,
    TResult Function(FetchProduct value)? fetchProduct,
    TResult Function(SelectAttribute value)? selectAttribute,
    TResult Function(EditProduct value)? editProduct,
    required TResult orElse(),
  }) {
    if (setCity != null) {
      return setCity(this);
    }
    return orElse();
  }
}

abstract class SetCity implements EditProductEvent {
  const factory SetCity({final int? cityId}) = _$SetCityImpl;

  int? get cityId;

  /// Create a copy of EditProductEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SetCityImplCopyWith<_$SetCityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SetAreaImplCopyWith<$Res> {
  factory _$$SetAreaImplCopyWith(
          _$SetAreaImpl value, $Res Function(_$SetAreaImpl) then) =
      __$$SetAreaImplCopyWithImpl<$Res>;
  @useResult
  $Res call({int? cityId});
}

/// @nodoc
class __$$SetAreaImplCopyWithImpl<$Res>
    extends _$EditProductEventCopyWithImpl<$Res, _$SetAreaImpl>
    implements _$$SetAreaImplCopyWith<$Res> {
  __$$SetAreaImplCopyWithImpl(
      _$SetAreaImpl _value, $Res Function(_$SetAreaImpl) _then)
      : super(_value, _then);

  /// Create a copy of EditProductEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? cityId = freezed,
  }) {
    return _then(_$SetAreaImpl(
      cityId: freezed == cityId
          ? _value.cityId
          : cityId // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc

class _$SetAreaImpl implements SetArea {
  const _$SetAreaImpl({this.cityId});

  @override
  final int? cityId;

  @override
  String toString() {
    return 'EditProductEvent.setArea(cityId: $cityId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SetAreaImpl &&
            (identical(other.cityId, cityId) || other.cityId == cityId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, cityId);

  /// Create a copy of EditProductEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SetAreaImplCopyWith<_$SetAreaImpl> get copyWith =>
      __$$SetAreaImplCopyWithImpl<_$SetAreaImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int? countryId) setCountry,
    required TResult Function(int? cityId) setCity,
    required TResult Function(int? cityId) setArea,
    required TResult Function(String file) setImageFile,
    required TResult Function(Galleries gallery) setVideo,
    required TResult Function(String value) deleteImage,
    required TResult Function() deleteVideo,
    required TResult Function(ProductData product) fetchProduct,
    required TResult Function(SelectedAttribute attribute) selectAttribute,
    required TResult Function(
            BuildContext context,
            ProductRequest productRequest,
            VoidCallback? updated,
            VoidCallback? onError)
        editProduct,
  }) {
    return setArea(cityId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int? countryId)? setCountry,
    TResult? Function(int? cityId)? setCity,
    TResult? Function(int? cityId)? setArea,
    TResult? Function(String file)? setImageFile,
    TResult? Function(Galleries gallery)? setVideo,
    TResult? Function(String value)? deleteImage,
    TResult? Function()? deleteVideo,
    TResult? Function(ProductData product)? fetchProduct,
    TResult? Function(SelectedAttribute attribute)? selectAttribute,
    TResult? Function(BuildContext context, ProductRequest productRequest,
            VoidCallback? updated, VoidCallback? onError)?
        editProduct,
  }) {
    return setArea?.call(cityId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int? countryId)? setCountry,
    TResult Function(int? cityId)? setCity,
    TResult Function(int? cityId)? setArea,
    TResult Function(String file)? setImageFile,
    TResult Function(Galleries gallery)? setVideo,
    TResult Function(String value)? deleteImage,
    TResult Function()? deleteVideo,
    TResult Function(ProductData product)? fetchProduct,
    TResult Function(SelectedAttribute attribute)? selectAttribute,
    TResult Function(BuildContext context, ProductRequest productRequest,
            VoidCallback? updated, VoidCallback? onError)?
        editProduct,
    required TResult orElse(),
  }) {
    if (setArea != null) {
      return setArea(cityId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SetCountry value) setCountry,
    required TResult Function(SetCity value) setCity,
    required TResult Function(SetArea value) setArea,
    required TResult Function(SetImageFile value) setImageFile,
    required TResult Function(SetVideo value) setVideo,
    required TResult Function(DeleteImage value) deleteImage,
    required TResult Function(DeleteVideo value) deleteVideo,
    required TResult Function(FetchProduct value) fetchProduct,
    required TResult Function(SelectAttribute value) selectAttribute,
    required TResult Function(EditProduct value) editProduct,
  }) {
    return setArea(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SetCountry value)? setCountry,
    TResult? Function(SetCity value)? setCity,
    TResult? Function(SetArea value)? setArea,
    TResult? Function(SetImageFile value)? setImageFile,
    TResult? Function(SetVideo value)? setVideo,
    TResult? Function(DeleteImage value)? deleteImage,
    TResult? Function(DeleteVideo value)? deleteVideo,
    TResult? Function(FetchProduct value)? fetchProduct,
    TResult? Function(SelectAttribute value)? selectAttribute,
    TResult? Function(EditProduct value)? editProduct,
  }) {
    return setArea?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SetCountry value)? setCountry,
    TResult Function(SetCity value)? setCity,
    TResult Function(SetArea value)? setArea,
    TResult Function(SetImageFile value)? setImageFile,
    TResult Function(SetVideo value)? setVideo,
    TResult Function(DeleteImage value)? deleteImage,
    TResult Function(DeleteVideo value)? deleteVideo,
    TResult Function(FetchProduct value)? fetchProduct,
    TResult Function(SelectAttribute value)? selectAttribute,
    TResult Function(EditProduct value)? editProduct,
    required TResult orElse(),
  }) {
    if (setArea != null) {
      return setArea(this);
    }
    return orElse();
  }
}

abstract class SetArea implements EditProductEvent {
  const factory SetArea({final int? cityId}) = _$SetAreaImpl;

  int? get cityId;

  /// Create a copy of EditProductEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SetAreaImplCopyWith<_$SetAreaImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SetImageFileImplCopyWith<$Res> {
  factory _$$SetImageFileImplCopyWith(
          _$SetImageFileImpl value, $Res Function(_$SetImageFileImpl) then) =
      __$$SetImageFileImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String file});
}

/// @nodoc
class __$$SetImageFileImplCopyWithImpl<$Res>
    extends _$EditProductEventCopyWithImpl<$Res, _$SetImageFileImpl>
    implements _$$SetImageFileImplCopyWith<$Res> {
  __$$SetImageFileImplCopyWithImpl(
      _$SetImageFileImpl _value, $Res Function(_$SetImageFileImpl) _then)
      : super(_value, _then);

  /// Create a copy of EditProductEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? file = null,
  }) {
    return _then(_$SetImageFileImpl(
      file: null == file
          ? _value.file
          : file // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$SetImageFileImpl implements SetImageFile {
  const _$SetImageFileImpl({required this.file});

  @override
  final String file;

  @override
  String toString() {
    return 'EditProductEvent.setImageFile(file: $file)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SetImageFileImpl &&
            (identical(other.file, file) || other.file == file));
  }

  @override
  int get hashCode => Object.hash(runtimeType, file);

  /// Create a copy of EditProductEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SetImageFileImplCopyWith<_$SetImageFileImpl> get copyWith =>
      __$$SetImageFileImplCopyWithImpl<_$SetImageFileImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int? countryId) setCountry,
    required TResult Function(int? cityId) setCity,
    required TResult Function(int? cityId) setArea,
    required TResult Function(String file) setImageFile,
    required TResult Function(Galleries gallery) setVideo,
    required TResult Function(String value) deleteImage,
    required TResult Function() deleteVideo,
    required TResult Function(ProductData product) fetchProduct,
    required TResult Function(SelectedAttribute attribute) selectAttribute,
    required TResult Function(
            BuildContext context,
            ProductRequest productRequest,
            VoidCallback? updated,
            VoidCallback? onError)
        editProduct,
  }) {
    return setImageFile(file);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int? countryId)? setCountry,
    TResult? Function(int? cityId)? setCity,
    TResult? Function(int? cityId)? setArea,
    TResult? Function(String file)? setImageFile,
    TResult? Function(Galleries gallery)? setVideo,
    TResult? Function(String value)? deleteImage,
    TResult? Function()? deleteVideo,
    TResult? Function(ProductData product)? fetchProduct,
    TResult? Function(SelectedAttribute attribute)? selectAttribute,
    TResult? Function(BuildContext context, ProductRequest productRequest,
            VoidCallback? updated, VoidCallback? onError)?
        editProduct,
  }) {
    return setImageFile?.call(file);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int? countryId)? setCountry,
    TResult Function(int? cityId)? setCity,
    TResult Function(int? cityId)? setArea,
    TResult Function(String file)? setImageFile,
    TResult Function(Galleries gallery)? setVideo,
    TResult Function(String value)? deleteImage,
    TResult Function()? deleteVideo,
    TResult Function(ProductData product)? fetchProduct,
    TResult Function(SelectedAttribute attribute)? selectAttribute,
    TResult Function(BuildContext context, ProductRequest productRequest,
            VoidCallback? updated, VoidCallback? onError)?
        editProduct,
    required TResult orElse(),
  }) {
    if (setImageFile != null) {
      return setImageFile(file);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SetCountry value) setCountry,
    required TResult Function(SetCity value) setCity,
    required TResult Function(SetArea value) setArea,
    required TResult Function(SetImageFile value) setImageFile,
    required TResult Function(SetVideo value) setVideo,
    required TResult Function(DeleteImage value) deleteImage,
    required TResult Function(DeleteVideo value) deleteVideo,
    required TResult Function(FetchProduct value) fetchProduct,
    required TResult Function(SelectAttribute value) selectAttribute,
    required TResult Function(EditProduct value) editProduct,
  }) {
    return setImageFile(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SetCountry value)? setCountry,
    TResult? Function(SetCity value)? setCity,
    TResult? Function(SetArea value)? setArea,
    TResult? Function(SetImageFile value)? setImageFile,
    TResult? Function(SetVideo value)? setVideo,
    TResult? Function(DeleteImage value)? deleteImage,
    TResult? Function(DeleteVideo value)? deleteVideo,
    TResult? Function(FetchProduct value)? fetchProduct,
    TResult? Function(SelectAttribute value)? selectAttribute,
    TResult? Function(EditProduct value)? editProduct,
  }) {
    return setImageFile?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SetCountry value)? setCountry,
    TResult Function(SetCity value)? setCity,
    TResult Function(SetArea value)? setArea,
    TResult Function(SetImageFile value)? setImageFile,
    TResult Function(SetVideo value)? setVideo,
    TResult Function(DeleteImage value)? deleteImage,
    TResult Function(DeleteVideo value)? deleteVideo,
    TResult Function(FetchProduct value)? fetchProduct,
    TResult Function(SelectAttribute value)? selectAttribute,
    TResult Function(EditProduct value)? editProduct,
    required TResult orElse(),
  }) {
    if (setImageFile != null) {
      return setImageFile(this);
    }
    return orElse();
  }
}

abstract class SetImageFile implements EditProductEvent {
  const factory SetImageFile({required final String file}) = _$SetImageFileImpl;

  String get file;

  /// Create a copy of EditProductEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SetImageFileImplCopyWith<_$SetImageFileImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SetVideoImplCopyWith<$Res> {
  factory _$$SetVideoImplCopyWith(
          _$SetVideoImpl value, $Res Function(_$SetVideoImpl) then) =
      __$$SetVideoImplCopyWithImpl<$Res>;
  @useResult
  $Res call({Galleries gallery});
}

/// @nodoc
class __$$SetVideoImplCopyWithImpl<$Res>
    extends _$EditProductEventCopyWithImpl<$Res, _$SetVideoImpl>
    implements _$$SetVideoImplCopyWith<$Res> {
  __$$SetVideoImplCopyWithImpl(
      _$SetVideoImpl _value, $Res Function(_$SetVideoImpl) _then)
      : super(_value, _then);

  /// Create a copy of EditProductEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? gallery = null,
  }) {
    return _then(_$SetVideoImpl(
      gallery: null == gallery
          ? _value.gallery
          : gallery // ignore: cast_nullable_to_non_nullable
              as Galleries,
    ));
  }
}

/// @nodoc

class _$SetVideoImpl implements SetVideo {
  const _$SetVideoImpl({required this.gallery});

  @override
  final Galleries gallery;

  @override
  String toString() {
    return 'EditProductEvent.setVideo(gallery: $gallery)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SetVideoImpl &&
            (identical(other.gallery, gallery) || other.gallery == gallery));
  }

  @override
  int get hashCode => Object.hash(runtimeType, gallery);

  /// Create a copy of EditProductEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SetVideoImplCopyWith<_$SetVideoImpl> get copyWith =>
      __$$SetVideoImplCopyWithImpl<_$SetVideoImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int? countryId) setCountry,
    required TResult Function(int? cityId) setCity,
    required TResult Function(int? cityId) setArea,
    required TResult Function(String file) setImageFile,
    required TResult Function(Galleries gallery) setVideo,
    required TResult Function(String value) deleteImage,
    required TResult Function() deleteVideo,
    required TResult Function(ProductData product) fetchProduct,
    required TResult Function(SelectedAttribute attribute) selectAttribute,
    required TResult Function(
            BuildContext context,
            ProductRequest productRequest,
            VoidCallback? updated,
            VoidCallback? onError)
        editProduct,
  }) {
    return setVideo(gallery);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int? countryId)? setCountry,
    TResult? Function(int? cityId)? setCity,
    TResult? Function(int? cityId)? setArea,
    TResult? Function(String file)? setImageFile,
    TResult? Function(Galleries gallery)? setVideo,
    TResult? Function(String value)? deleteImage,
    TResult? Function()? deleteVideo,
    TResult? Function(ProductData product)? fetchProduct,
    TResult? Function(SelectedAttribute attribute)? selectAttribute,
    TResult? Function(BuildContext context, ProductRequest productRequest,
            VoidCallback? updated, VoidCallback? onError)?
        editProduct,
  }) {
    return setVideo?.call(gallery);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int? countryId)? setCountry,
    TResult Function(int? cityId)? setCity,
    TResult Function(int? cityId)? setArea,
    TResult Function(String file)? setImageFile,
    TResult Function(Galleries gallery)? setVideo,
    TResult Function(String value)? deleteImage,
    TResult Function()? deleteVideo,
    TResult Function(ProductData product)? fetchProduct,
    TResult Function(SelectedAttribute attribute)? selectAttribute,
    TResult Function(BuildContext context, ProductRequest productRequest,
            VoidCallback? updated, VoidCallback? onError)?
        editProduct,
    required TResult orElse(),
  }) {
    if (setVideo != null) {
      return setVideo(gallery);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SetCountry value) setCountry,
    required TResult Function(SetCity value) setCity,
    required TResult Function(SetArea value) setArea,
    required TResult Function(SetImageFile value) setImageFile,
    required TResult Function(SetVideo value) setVideo,
    required TResult Function(DeleteImage value) deleteImage,
    required TResult Function(DeleteVideo value) deleteVideo,
    required TResult Function(FetchProduct value) fetchProduct,
    required TResult Function(SelectAttribute value) selectAttribute,
    required TResult Function(EditProduct value) editProduct,
  }) {
    return setVideo(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SetCountry value)? setCountry,
    TResult? Function(SetCity value)? setCity,
    TResult? Function(SetArea value)? setArea,
    TResult? Function(SetImageFile value)? setImageFile,
    TResult? Function(SetVideo value)? setVideo,
    TResult? Function(DeleteImage value)? deleteImage,
    TResult? Function(DeleteVideo value)? deleteVideo,
    TResult? Function(FetchProduct value)? fetchProduct,
    TResult? Function(SelectAttribute value)? selectAttribute,
    TResult? Function(EditProduct value)? editProduct,
  }) {
    return setVideo?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SetCountry value)? setCountry,
    TResult Function(SetCity value)? setCity,
    TResult Function(SetArea value)? setArea,
    TResult Function(SetImageFile value)? setImageFile,
    TResult Function(SetVideo value)? setVideo,
    TResult Function(DeleteImage value)? deleteImage,
    TResult Function(DeleteVideo value)? deleteVideo,
    TResult Function(FetchProduct value)? fetchProduct,
    TResult Function(SelectAttribute value)? selectAttribute,
    TResult Function(EditProduct value)? editProduct,
    required TResult orElse(),
  }) {
    if (setVideo != null) {
      return setVideo(this);
    }
    return orElse();
  }
}

abstract class SetVideo implements EditProductEvent {
  const factory SetVideo({required final Galleries gallery}) = _$SetVideoImpl;

  Galleries get gallery;

  /// Create a copy of EditProductEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SetVideoImplCopyWith<_$SetVideoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$DeleteImageImplCopyWith<$Res> {
  factory _$$DeleteImageImplCopyWith(
          _$DeleteImageImpl value, $Res Function(_$DeleteImageImpl) then) =
      __$$DeleteImageImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String value});
}

/// @nodoc
class __$$DeleteImageImplCopyWithImpl<$Res>
    extends _$EditProductEventCopyWithImpl<$Res, _$DeleteImageImpl>
    implements _$$DeleteImageImplCopyWith<$Res> {
  __$$DeleteImageImplCopyWithImpl(
      _$DeleteImageImpl _value, $Res Function(_$DeleteImageImpl) _then)
      : super(_value, _then);

  /// Create a copy of EditProductEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = null,
  }) {
    return _then(_$DeleteImageImpl(
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$DeleteImageImpl implements DeleteImage {
  const _$DeleteImageImpl({required this.value});

  @override
  final String value;

  @override
  String toString() {
    return 'EditProductEvent.deleteImage(value: $value)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DeleteImageImpl &&
            (identical(other.value, value) || other.value == value));
  }

  @override
  int get hashCode => Object.hash(runtimeType, value);

  /// Create a copy of EditProductEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DeleteImageImplCopyWith<_$DeleteImageImpl> get copyWith =>
      __$$DeleteImageImplCopyWithImpl<_$DeleteImageImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int? countryId) setCountry,
    required TResult Function(int? cityId) setCity,
    required TResult Function(int? cityId) setArea,
    required TResult Function(String file) setImageFile,
    required TResult Function(Galleries gallery) setVideo,
    required TResult Function(String value) deleteImage,
    required TResult Function() deleteVideo,
    required TResult Function(ProductData product) fetchProduct,
    required TResult Function(SelectedAttribute attribute) selectAttribute,
    required TResult Function(
            BuildContext context,
            ProductRequest productRequest,
            VoidCallback? updated,
            VoidCallback? onError)
        editProduct,
  }) {
    return deleteImage(value);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int? countryId)? setCountry,
    TResult? Function(int? cityId)? setCity,
    TResult? Function(int? cityId)? setArea,
    TResult? Function(String file)? setImageFile,
    TResult? Function(Galleries gallery)? setVideo,
    TResult? Function(String value)? deleteImage,
    TResult? Function()? deleteVideo,
    TResult? Function(ProductData product)? fetchProduct,
    TResult? Function(SelectedAttribute attribute)? selectAttribute,
    TResult? Function(BuildContext context, ProductRequest productRequest,
            VoidCallback? updated, VoidCallback? onError)?
        editProduct,
  }) {
    return deleteImage?.call(value);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int? countryId)? setCountry,
    TResult Function(int? cityId)? setCity,
    TResult Function(int? cityId)? setArea,
    TResult Function(String file)? setImageFile,
    TResult Function(Galleries gallery)? setVideo,
    TResult Function(String value)? deleteImage,
    TResult Function()? deleteVideo,
    TResult Function(ProductData product)? fetchProduct,
    TResult Function(SelectedAttribute attribute)? selectAttribute,
    TResult Function(BuildContext context, ProductRequest productRequest,
            VoidCallback? updated, VoidCallback? onError)?
        editProduct,
    required TResult orElse(),
  }) {
    if (deleteImage != null) {
      return deleteImage(value);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SetCountry value) setCountry,
    required TResult Function(SetCity value) setCity,
    required TResult Function(SetArea value) setArea,
    required TResult Function(SetImageFile value) setImageFile,
    required TResult Function(SetVideo value) setVideo,
    required TResult Function(DeleteImage value) deleteImage,
    required TResult Function(DeleteVideo value) deleteVideo,
    required TResult Function(FetchProduct value) fetchProduct,
    required TResult Function(SelectAttribute value) selectAttribute,
    required TResult Function(EditProduct value) editProduct,
  }) {
    return deleteImage(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SetCountry value)? setCountry,
    TResult? Function(SetCity value)? setCity,
    TResult? Function(SetArea value)? setArea,
    TResult? Function(SetImageFile value)? setImageFile,
    TResult? Function(SetVideo value)? setVideo,
    TResult? Function(DeleteImage value)? deleteImage,
    TResult? Function(DeleteVideo value)? deleteVideo,
    TResult? Function(FetchProduct value)? fetchProduct,
    TResult? Function(SelectAttribute value)? selectAttribute,
    TResult? Function(EditProduct value)? editProduct,
  }) {
    return deleteImage?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SetCountry value)? setCountry,
    TResult Function(SetCity value)? setCity,
    TResult Function(SetArea value)? setArea,
    TResult Function(SetImageFile value)? setImageFile,
    TResult Function(SetVideo value)? setVideo,
    TResult Function(DeleteImage value)? deleteImage,
    TResult Function(DeleteVideo value)? deleteVideo,
    TResult Function(FetchProduct value)? fetchProduct,
    TResult Function(SelectAttribute value)? selectAttribute,
    TResult Function(EditProduct value)? editProduct,
    required TResult orElse(),
  }) {
    if (deleteImage != null) {
      return deleteImage(this);
    }
    return orElse();
  }
}

abstract class DeleteImage implements EditProductEvent {
  const factory DeleteImage({required final String value}) = _$DeleteImageImpl;

  String get value;

  /// Create a copy of EditProductEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DeleteImageImplCopyWith<_$DeleteImageImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$DeleteVideoImplCopyWith<$Res> {
  factory _$$DeleteVideoImplCopyWith(
          _$DeleteVideoImpl value, $Res Function(_$DeleteVideoImpl) then) =
      __$$DeleteVideoImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$DeleteVideoImplCopyWithImpl<$Res>
    extends _$EditProductEventCopyWithImpl<$Res, _$DeleteVideoImpl>
    implements _$$DeleteVideoImplCopyWith<$Res> {
  __$$DeleteVideoImplCopyWithImpl(
      _$DeleteVideoImpl _value, $Res Function(_$DeleteVideoImpl) _then)
      : super(_value, _then);

  /// Create a copy of EditProductEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$DeleteVideoImpl implements DeleteVideo {
  const _$DeleteVideoImpl();

  @override
  String toString() {
    return 'EditProductEvent.deleteVideo()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$DeleteVideoImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int? countryId) setCountry,
    required TResult Function(int? cityId) setCity,
    required TResult Function(int? cityId) setArea,
    required TResult Function(String file) setImageFile,
    required TResult Function(Galleries gallery) setVideo,
    required TResult Function(String value) deleteImage,
    required TResult Function() deleteVideo,
    required TResult Function(ProductData product) fetchProduct,
    required TResult Function(SelectedAttribute attribute) selectAttribute,
    required TResult Function(
            BuildContext context,
            ProductRequest productRequest,
            VoidCallback? updated,
            VoidCallback? onError)
        editProduct,
  }) {
    return deleteVideo();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int? countryId)? setCountry,
    TResult? Function(int? cityId)? setCity,
    TResult? Function(int? cityId)? setArea,
    TResult? Function(String file)? setImageFile,
    TResult? Function(Galleries gallery)? setVideo,
    TResult? Function(String value)? deleteImage,
    TResult? Function()? deleteVideo,
    TResult? Function(ProductData product)? fetchProduct,
    TResult? Function(SelectedAttribute attribute)? selectAttribute,
    TResult? Function(BuildContext context, ProductRequest productRequest,
            VoidCallback? updated, VoidCallback? onError)?
        editProduct,
  }) {
    return deleteVideo?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int? countryId)? setCountry,
    TResult Function(int? cityId)? setCity,
    TResult Function(int? cityId)? setArea,
    TResult Function(String file)? setImageFile,
    TResult Function(Galleries gallery)? setVideo,
    TResult Function(String value)? deleteImage,
    TResult Function()? deleteVideo,
    TResult Function(ProductData product)? fetchProduct,
    TResult Function(SelectedAttribute attribute)? selectAttribute,
    TResult Function(BuildContext context, ProductRequest productRequest,
            VoidCallback? updated, VoidCallback? onError)?
        editProduct,
    required TResult orElse(),
  }) {
    if (deleteVideo != null) {
      return deleteVideo();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SetCountry value) setCountry,
    required TResult Function(SetCity value) setCity,
    required TResult Function(SetArea value) setArea,
    required TResult Function(SetImageFile value) setImageFile,
    required TResult Function(SetVideo value) setVideo,
    required TResult Function(DeleteImage value) deleteImage,
    required TResult Function(DeleteVideo value) deleteVideo,
    required TResult Function(FetchProduct value) fetchProduct,
    required TResult Function(SelectAttribute value) selectAttribute,
    required TResult Function(EditProduct value) editProduct,
  }) {
    return deleteVideo(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SetCountry value)? setCountry,
    TResult? Function(SetCity value)? setCity,
    TResult? Function(SetArea value)? setArea,
    TResult? Function(SetImageFile value)? setImageFile,
    TResult? Function(SetVideo value)? setVideo,
    TResult? Function(DeleteImage value)? deleteImage,
    TResult? Function(DeleteVideo value)? deleteVideo,
    TResult? Function(FetchProduct value)? fetchProduct,
    TResult? Function(SelectAttribute value)? selectAttribute,
    TResult? Function(EditProduct value)? editProduct,
  }) {
    return deleteVideo?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SetCountry value)? setCountry,
    TResult Function(SetCity value)? setCity,
    TResult Function(SetArea value)? setArea,
    TResult Function(SetImageFile value)? setImageFile,
    TResult Function(SetVideo value)? setVideo,
    TResult Function(DeleteImage value)? deleteImage,
    TResult Function(DeleteVideo value)? deleteVideo,
    TResult Function(FetchProduct value)? fetchProduct,
    TResult Function(SelectAttribute value)? selectAttribute,
    TResult Function(EditProduct value)? editProduct,
    required TResult orElse(),
  }) {
    if (deleteVideo != null) {
      return deleteVideo(this);
    }
    return orElse();
  }
}

abstract class DeleteVideo implements EditProductEvent {
  const factory DeleteVideo() = _$DeleteVideoImpl;
}

/// @nodoc
abstract class _$$FetchProductImplCopyWith<$Res> {
  factory _$$FetchProductImplCopyWith(
          _$FetchProductImpl value, $Res Function(_$FetchProductImpl) then) =
      __$$FetchProductImplCopyWithImpl<$Res>;
  @useResult
  $Res call({ProductData product});
}

/// @nodoc
class __$$FetchProductImplCopyWithImpl<$Res>
    extends _$EditProductEventCopyWithImpl<$Res, _$FetchProductImpl>
    implements _$$FetchProductImplCopyWith<$Res> {
  __$$FetchProductImplCopyWithImpl(
      _$FetchProductImpl _value, $Res Function(_$FetchProductImpl) _then)
      : super(_value, _then);

  /// Create a copy of EditProductEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? product = null,
  }) {
    return _then(_$FetchProductImpl(
      product: null == product
          ? _value.product
          : product // ignore: cast_nullable_to_non_nullable
              as ProductData,
    ));
  }
}

/// @nodoc

class _$FetchProductImpl implements FetchProduct {
  const _$FetchProductImpl({required this.product});

  @override
  final ProductData product;

  @override
  String toString() {
    return 'EditProductEvent.fetchProduct(product: $product)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FetchProductImpl &&
            (identical(other.product, product) || other.product == product));
  }

  @override
  int get hashCode => Object.hash(runtimeType, product);

  /// Create a copy of EditProductEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FetchProductImplCopyWith<_$FetchProductImpl> get copyWith =>
      __$$FetchProductImplCopyWithImpl<_$FetchProductImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int? countryId) setCountry,
    required TResult Function(int? cityId) setCity,
    required TResult Function(int? cityId) setArea,
    required TResult Function(String file) setImageFile,
    required TResult Function(Galleries gallery) setVideo,
    required TResult Function(String value) deleteImage,
    required TResult Function() deleteVideo,
    required TResult Function(ProductData product) fetchProduct,
    required TResult Function(SelectedAttribute attribute) selectAttribute,
    required TResult Function(
            BuildContext context,
            ProductRequest productRequest,
            VoidCallback? updated,
            VoidCallback? onError)
        editProduct,
  }) {
    return fetchProduct(product);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int? countryId)? setCountry,
    TResult? Function(int? cityId)? setCity,
    TResult? Function(int? cityId)? setArea,
    TResult? Function(String file)? setImageFile,
    TResult? Function(Galleries gallery)? setVideo,
    TResult? Function(String value)? deleteImage,
    TResult? Function()? deleteVideo,
    TResult? Function(ProductData product)? fetchProduct,
    TResult? Function(SelectedAttribute attribute)? selectAttribute,
    TResult? Function(BuildContext context, ProductRequest productRequest,
            VoidCallback? updated, VoidCallback? onError)?
        editProduct,
  }) {
    return fetchProduct?.call(product);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int? countryId)? setCountry,
    TResult Function(int? cityId)? setCity,
    TResult Function(int? cityId)? setArea,
    TResult Function(String file)? setImageFile,
    TResult Function(Galleries gallery)? setVideo,
    TResult Function(String value)? deleteImage,
    TResult Function()? deleteVideo,
    TResult Function(ProductData product)? fetchProduct,
    TResult Function(SelectedAttribute attribute)? selectAttribute,
    TResult Function(BuildContext context, ProductRequest productRequest,
            VoidCallback? updated, VoidCallback? onError)?
        editProduct,
    required TResult orElse(),
  }) {
    if (fetchProduct != null) {
      return fetchProduct(product);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SetCountry value) setCountry,
    required TResult Function(SetCity value) setCity,
    required TResult Function(SetArea value) setArea,
    required TResult Function(SetImageFile value) setImageFile,
    required TResult Function(SetVideo value) setVideo,
    required TResult Function(DeleteImage value) deleteImage,
    required TResult Function(DeleteVideo value) deleteVideo,
    required TResult Function(FetchProduct value) fetchProduct,
    required TResult Function(SelectAttribute value) selectAttribute,
    required TResult Function(EditProduct value) editProduct,
  }) {
    return fetchProduct(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SetCountry value)? setCountry,
    TResult? Function(SetCity value)? setCity,
    TResult? Function(SetArea value)? setArea,
    TResult? Function(SetImageFile value)? setImageFile,
    TResult? Function(SetVideo value)? setVideo,
    TResult? Function(DeleteImage value)? deleteImage,
    TResult? Function(DeleteVideo value)? deleteVideo,
    TResult? Function(FetchProduct value)? fetchProduct,
    TResult? Function(SelectAttribute value)? selectAttribute,
    TResult? Function(EditProduct value)? editProduct,
  }) {
    return fetchProduct?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SetCountry value)? setCountry,
    TResult Function(SetCity value)? setCity,
    TResult Function(SetArea value)? setArea,
    TResult Function(SetImageFile value)? setImageFile,
    TResult Function(SetVideo value)? setVideo,
    TResult Function(DeleteImage value)? deleteImage,
    TResult Function(DeleteVideo value)? deleteVideo,
    TResult Function(FetchProduct value)? fetchProduct,
    TResult Function(SelectAttribute value)? selectAttribute,
    TResult Function(EditProduct value)? editProduct,
    required TResult orElse(),
  }) {
    if (fetchProduct != null) {
      return fetchProduct(this);
    }
    return orElse();
  }
}

abstract class FetchProduct implements EditProductEvent {
  const factory FetchProduct({required final ProductData product}) =
      _$FetchProductImpl;

  ProductData get product;

  /// Create a copy of EditProductEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FetchProductImplCopyWith<_$FetchProductImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SelectAttributeImplCopyWith<$Res> {
  factory _$$SelectAttributeImplCopyWith(_$SelectAttributeImpl value,
          $Res Function(_$SelectAttributeImpl) then) =
      __$$SelectAttributeImplCopyWithImpl<$Res>;
  @useResult
  $Res call({SelectedAttribute attribute});
}

/// @nodoc
class __$$SelectAttributeImplCopyWithImpl<$Res>
    extends _$EditProductEventCopyWithImpl<$Res, _$SelectAttributeImpl>
    implements _$$SelectAttributeImplCopyWith<$Res> {
  __$$SelectAttributeImplCopyWithImpl(
      _$SelectAttributeImpl _value, $Res Function(_$SelectAttributeImpl) _then)
      : super(_value, _then);

  /// Create a copy of EditProductEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? attribute = null,
  }) {
    return _then(_$SelectAttributeImpl(
      attribute: null == attribute
          ? _value.attribute
          : attribute // ignore: cast_nullable_to_non_nullable
              as SelectedAttribute,
    ));
  }
}

/// @nodoc

class _$SelectAttributeImpl implements SelectAttribute {
  const _$SelectAttributeImpl({required this.attribute});

  @override
  final SelectedAttribute attribute;

  @override
  String toString() {
    return 'EditProductEvent.selectAttribute(attribute: $attribute)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SelectAttributeImpl &&
            (identical(other.attribute, attribute) ||
                other.attribute == attribute));
  }

  @override
  int get hashCode => Object.hash(runtimeType, attribute);

  /// Create a copy of EditProductEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SelectAttributeImplCopyWith<_$SelectAttributeImpl> get copyWith =>
      __$$SelectAttributeImplCopyWithImpl<_$SelectAttributeImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int? countryId) setCountry,
    required TResult Function(int? cityId) setCity,
    required TResult Function(int? cityId) setArea,
    required TResult Function(String file) setImageFile,
    required TResult Function(Galleries gallery) setVideo,
    required TResult Function(String value) deleteImage,
    required TResult Function() deleteVideo,
    required TResult Function(ProductData product) fetchProduct,
    required TResult Function(SelectedAttribute attribute) selectAttribute,
    required TResult Function(
            BuildContext context,
            ProductRequest productRequest,
            VoidCallback? updated,
            VoidCallback? onError)
        editProduct,
  }) {
    return selectAttribute(attribute);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int? countryId)? setCountry,
    TResult? Function(int? cityId)? setCity,
    TResult? Function(int? cityId)? setArea,
    TResult? Function(String file)? setImageFile,
    TResult? Function(Galleries gallery)? setVideo,
    TResult? Function(String value)? deleteImage,
    TResult? Function()? deleteVideo,
    TResult? Function(ProductData product)? fetchProduct,
    TResult? Function(SelectedAttribute attribute)? selectAttribute,
    TResult? Function(BuildContext context, ProductRequest productRequest,
            VoidCallback? updated, VoidCallback? onError)?
        editProduct,
  }) {
    return selectAttribute?.call(attribute);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int? countryId)? setCountry,
    TResult Function(int? cityId)? setCity,
    TResult Function(int? cityId)? setArea,
    TResult Function(String file)? setImageFile,
    TResult Function(Galleries gallery)? setVideo,
    TResult Function(String value)? deleteImage,
    TResult Function()? deleteVideo,
    TResult Function(ProductData product)? fetchProduct,
    TResult Function(SelectedAttribute attribute)? selectAttribute,
    TResult Function(BuildContext context, ProductRequest productRequest,
            VoidCallback? updated, VoidCallback? onError)?
        editProduct,
    required TResult orElse(),
  }) {
    if (selectAttribute != null) {
      return selectAttribute(attribute);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SetCountry value) setCountry,
    required TResult Function(SetCity value) setCity,
    required TResult Function(SetArea value) setArea,
    required TResult Function(SetImageFile value) setImageFile,
    required TResult Function(SetVideo value) setVideo,
    required TResult Function(DeleteImage value) deleteImage,
    required TResult Function(DeleteVideo value) deleteVideo,
    required TResult Function(FetchProduct value) fetchProduct,
    required TResult Function(SelectAttribute value) selectAttribute,
    required TResult Function(EditProduct value) editProduct,
  }) {
    return selectAttribute(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SetCountry value)? setCountry,
    TResult? Function(SetCity value)? setCity,
    TResult? Function(SetArea value)? setArea,
    TResult? Function(SetImageFile value)? setImageFile,
    TResult? Function(SetVideo value)? setVideo,
    TResult? Function(DeleteImage value)? deleteImage,
    TResult? Function(DeleteVideo value)? deleteVideo,
    TResult? Function(FetchProduct value)? fetchProduct,
    TResult? Function(SelectAttribute value)? selectAttribute,
    TResult? Function(EditProduct value)? editProduct,
  }) {
    return selectAttribute?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SetCountry value)? setCountry,
    TResult Function(SetCity value)? setCity,
    TResult Function(SetArea value)? setArea,
    TResult Function(SetImageFile value)? setImageFile,
    TResult Function(SetVideo value)? setVideo,
    TResult Function(DeleteImage value)? deleteImage,
    TResult Function(DeleteVideo value)? deleteVideo,
    TResult Function(FetchProduct value)? fetchProduct,
    TResult Function(SelectAttribute value)? selectAttribute,
    TResult Function(EditProduct value)? editProduct,
    required TResult orElse(),
  }) {
    if (selectAttribute != null) {
      return selectAttribute(this);
    }
    return orElse();
  }
}

abstract class SelectAttribute implements EditProductEvent {
  const factory SelectAttribute({required final SelectedAttribute attribute}) =
      _$SelectAttributeImpl;

  SelectedAttribute get attribute;

  /// Create a copy of EditProductEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SelectAttributeImplCopyWith<_$SelectAttributeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$EditProductImplCopyWith<$Res> {
  factory _$$EditProductImplCopyWith(
          _$EditProductImpl value, $Res Function(_$EditProductImpl) then) =
      __$$EditProductImplCopyWithImpl<$Res>;
  @useResult
  $Res call(
      {BuildContext context,
      ProductRequest productRequest,
      VoidCallback? updated,
      VoidCallback? onError});
}

/// @nodoc
class __$$EditProductImplCopyWithImpl<$Res>
    extends _$EditProductEventCopyWithImpl<$Res, _$EditProductImpl>
    implements _$$EditProductImplCopyWith<$Res> {
  __$$EditProductImplCopyWithImpl(
      _$EditProductImpl _value, $Res Function(_$EditProductImpl) _then)
      : super(_value, _then);

  /// Create a copy of EditProductEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? context = null,
    Object? productRequest = null,
    Object? updated = freezed,
    Object? onError = freezed,
  }) {
    return _then(_$EditProductImpl(
      context: null == context
          ? _value.context
          : context // ignore: cast_nullable_to_non_nullable
              as BuildContext,
      productRequest: null == productRequest
          ? _value.productRequest
          : productRequest // ignore: cast_nullable_to_non_nullable
              as ProductRequest,
      updated: freezed == updated
          ? _value.updated
          : updated // ignore: cast_nullable_to_non_nullable
              as VoidCallback?,
      onError: freezed == onError
          ? _value.onError
          : onError // ignore: cast_nullable_to_non_nullable
              as VoidCallback?,
    ));
  }
}

/// @nodoc

class _$EditProductImpl implements EditProduct {
  const _$EditProductImpl(
      {required this.context,
      required this.productRequest,
      this.updated,
      this.onError});

  @override
  final BuildContext context;
  @override
  final ProductRequest productRequest;
  @override
  final VoidCallback? updated;
  @override
  final VoidCallback? onError;

  @override
  String toString() {
    return 'EditProductEvent.editProduct(context: $context, productRequest: $productRequest, updated: $updated, onError: $onError)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EditProductImpl &&
            (identical(other.context, context) || other.context == context) &&
            (identical(other.productRequest, productRequest) ||
                other.productRequest == productRequest) &&
            (identical(other.updated, updated) || other.updated == updated) &&
            (identical(other.onError, onError) || other.onError == onError));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, context, productRequest, updated, onError);

  /// Create a copy of EditProductEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EditProductImplCopyWith<_$EditProductImpl> get copyWith =>
      __$$EditProductImplCopyWithImpl<_$EditProductImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int? countryId) setCountry,
    required TResult Function(int? cityId) setCity,
    required TResult Function(int? cityId) setArea,
    required TResult Function(String file) setImageFile,
    required TResult Function(Galleries gallery) setVideo,
    required TResult Function(String value) deleteImage,
    required TResult Function() deleteVideo,
    required TResult Function(ProductData product) fetchProduct,
    required TResult Function(SelectedAttribute attribute) selectAttribute,
    required TResult Function(
            BuildContext context,
            ProductRequest productRequest,
            VoidCallback? updated,
            VoidCallback? onError)
        editProduct,
  }) {
    return editProduct(context, productRequest, updated, onError);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int? countryId)? setCountry,
    TResult? Function(int? cityId)? setCity,
    TResult? Function(int? cityId)? setArea,
    TResult? Function(String file)? setImageFile,
    TResult? Function(Galleries gallery)? setVideo,
    TResult? Function(String value)? deleteImage,
    TResult? Function()? deleteVideo,
    TResult? Function(ProductData product)? fetchProduct,
    TResult? Function(SelectedAttribute attribute)? selectAttribute,
    TResult? Function(BuildContext context, ProductRequest productRequest,
            VoidCallback? updated, VoidCallback? onError)?
        editProduct,
  }) {
    return editProduct?.call(context, productRequest, updated, onError);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int? countryId)? setCountry,
    TResult Function(int? cityId)? setCity,
    TResult Function(int? cityId)? setArea,
    TResult Function(String file)? setImageFile,
    TResult Function(Galleries gallery)? setVideo,
    TResult Function(String value)? deleteImage,
    TResult Function()? deleteVideo,
    TResult Function(ProductData product)? fetchProduct,
    TResult Function(SelectedAttribute attribute)? selectAttribute,
    TResult Function(BuildContext context, ProductRequest productRequest,
            VoidCallback? updated, VoidCallback? onError)?
        editProduct,
    required TResult orElse(),
  }) {
    if (editProduct != null) {
      return editProduct(context, productRequest, updated, onError);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SetCountry value) setCountry,
    required TResult Function(SetCity value) setCity,
    required TResult Function(SetArea value) setArea,
    required TResult Function(SetImageFile value) setImageFile,
    required TResult Function(SetVideo value) setVideo,
    required TResult Function(DeleteImage value) deleteImage,
    required TResult Function(DeleteVideo value) deleteVideo,
    required TResult Function(FetchProduct value) fetchProduct,
    required TResult Function(SelectAttribute value) selectAttribute,
    required TResult Function(EditProduct value) editProduct,
  }) {
    return editProduct(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SetCountry value)? setCountry,
    TResult? Function(SetCity value)? setCity,
    TResult? Function(SetArea value)? setArea,
    TResult? Function(SetImageFile value)? setImageFile,
    TResult? Function(SetVideo value)? setVideo,
    TResult? Function(DeleteImage value)? deleteImage,
    TResult? Function(DeleteVideo value)? deleteVideo,
    TResult? Function(FetchProduct value)? fetchProduct,
    TResult? Function(SelectAttribute value)? selectAttribute,
    TResult? Function(EditProduct value)? editProduct,
  }) {
    return editProduct?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SetCountry value)? setCountry,
    TResult Function(SetCity value)? setCity,
    TResult Function(SetArea value)? setArea,
    TResult Function(SetImageFile value)? setImageFile,
    TResult Function(SetVideo value)? setVideo,
    TResult Function(DeleteImage value)? deleteImage,
    TResult Function(DeleteVideo value)? deleteVideo,
    TResult Function(FetchProduct value)? fetchProduct,
    TResult Function(SelectAttribute value)? selectAttribute,
    TResult Function(EditProduct value)? editProduct,
    required TResult orElse(),
  }) {
    if (editProduct != null) {
      return editProduct(this);
    }
    return orElse();
  }
}

abstract class EditProduct implements EditProductEvent {
  const factory EditProduct(
      {required final BuildContext context,
      required final ProductRequest productRequest,
      final VoidCallback? updated,
      final VoidCallback? onError}) = _$EditProductImpl;

  BuildContext get context;
  ProductRequest get productRequest;
  VoidCallback? get updated;
  VoidCallback? get onError;

  /// Create a copy of EditProductEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EditProductImplCopyWith<_$EditProductImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$EditProductState {
  int? get regionId => throw _privateConstructorUsedError;
  int? get countryId => throw _privateConstructorUsedError;
  int? get cityId => throw _privateConstructorUsedError;
  int? get areaId => throw _privateConstructorUsedError;
  bool get active => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;
  List<String> get images => throw _privateConstructorUsedError;
  List<Galleries> get listOfUrls => throw _privateConstructorUsedError;
  List<SelectedAttribute> get attributes => throw _privateConstructorUsedError;
  Galleries? get video => throw _privateConstructorUsedError;
  ProductData? get product => throw _privateConstructorUsedError;
  Map<String, List<String>> get translations =>
      throw _privateConstructorUsedError;

  /// Create a copy of EditProductState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $EditProductStateCopyWith<EditProductState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EditProductStateCopyWith<$Res> {
  factory $EditProductStateCopyWith(
          EditProductState value, $Res Function(EditProductState) then) =
      _$EditProductStateCopyWithImpl<$Res, EditProductState>;
  @useResult
  $Res call(
      {int? regionId,
      int? countryId,
      int? cityId,
      int? areaId,
      bool active,
      bool isLoading,
      List<String> images,
      List<Galleries> listOfUrls,
      List<SelectedAttribute> attributes,
      Galleries? video,
      ProductData? product,
      Map<String, List<String>> translations});
}

/// @nodoc
class _$EditProductStateCopyWithImpl<$Res, $Val extends EditProductState>
    implements $EditProductStateCopyWith<$Res> {
  _$EditProductStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of EditProductState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? regionId = freezed,
    Object? countryId = freezed,
    Object? cityId = freezed,
    Object? areaId = freezed,
    Object? active = null,
    Object? isLoading = null,
    Object? images = null,
    Object? listOfUrls = null,
    Object? attributes = null,
    Object? video = freezed,
    Object? product = freezed,
    Object? translations = null,
  }) {
    return _then(_value.copyWith(
      regionId: freezed == regionId
          ? _value.regionId
          : regionId // ignore: cast_nullable_to_non_nullable
              as int?,
      countryId: freezed == countryId
          ? _value.countryId
          : countryId // ignore: cast_nullable_to_non_nullable
              as int?,
      cityId: freezed == cityId
          ? _value.cityId
          : cityId // ignore: cast_nullable_to_non_nullable
              as int?,
      areaId: freezed == areaId
          ? _value.areaId
          : areaId // ignore: cast_nullable_to_non_nullable
              as int?,
      active: null == active
          ? _value.active
          : active // ignore: cast_nullable_to_non_nullable
              as bool,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      images: null == images
          ? _value.images
          : images // ignore: cast_nullable_to_non_nullable
              as List<String>,
      listOfUrls: null == listOfUrls
          ? _value.listOfUrls
          : listOfUrls // ignore: cast_nullable_to_non_nullable
              as List<Galleries>,
      attributes: null == attributes
          ? _value.attributes
          : attributes // ignore: cast_nullable_to_non_nullable
              as List<SelectedAttribute>,
      video: freezed == video
          ? _value.video
          : video // ignore: cast_nullable_to_non_nullable
              as Galleries?,
      product: freezed == product
          ? _value.product
          : product // ignore: cast_nullable_to_non_nullable
              as ProductData?,
      translations: null == translations
          ? _value.translations
          : translations // ignore: cast_nullable_to_non_nullable
              as Map<String, List<String>>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$EditProductStateImplCopyWith<$Res>
    implements $EditProductStateCopyWith<$Res> {
  factory _$$EditProductStateImplCopyWith(_$EditProductStateImpl value,
          $Res Function(_$EditProductStateImpl) then) =
      __$$EditProductStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? regionId,
      int? countryId,
      int? cityId,
      int? areaId,
      bool active,
      bool isLoading,
      List<String> images,
      List<Galleries> listOfUrls,
      List<SelectedAttribute> attributes,
      Galleries? video,
      ProductData? product,
      Map<String, List<String>> translations});
}

/// @nodoc
class __$$EditProductStateImplCopyWithImpl<$Res>
    extends _$EditProductStateCopyWithImpl<$Res, _$EditProductStateImpl>
    implements _$$EditProductStateImplCopyWith<$Res> {
  __$$EditProductStateImplCopyWithImpl(_$EditProductStateImpl _value,
      $Res Function(_$EditProductStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of EditProductState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? regionId = freezed,
    Object? countryId = freezed,
    Object? cityId = freezed,
    Object? areaId = freezed,
    Object? active = null,
    Object? isLoading = null,
    Object? images = null,
    Object? listOfUrls = null,
    Object? attributes = null,
    Object? video = freezed,
    Object? product = freezed,
    Object? translations = null,
  }) {
    return _then(_$EditProductStateImpl(
      regionId: freezed == regionId
          ? _value.regionId
          : regionId // ignore: cast_nullable_to_non_nullable
              as int?,
      countryId: freezed == countryId
          ? _value.countryId
          : countryId // ignore: cast_nullable_to_non_nullable
              as int?,
      cityId: freezed == cityId
          ? _value.cityId
          : cityId // ignore: cast_nullable_to_non_nullable
              as int?,
      areaId: freezed == areaId
          ? _value.areaId
          : areaId // ignore: cast_nullable_to_non_nullable
              as int?,
      active: null == active
          ? _value.active
          : active // ignore: cast_nullable_to_non_nullable
              as bool,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      images: null == images
          ? _value._images
          : images // ignore: cast_nullable_to_non_nullable
              as List<String>,
      listOfUrls: null == listOfUrls
          ? _value._listOfUrls
          : listOfUrls // ignore: cast_nullable_to_non_nullable
              as List<Galleries>,
      attributes: null == attributes
          ? _value._attributes
          : attributes // ignore: cast_nullable_to_non_nullable
              as List<SelectedAttribute>,
      video: freezed == video
          ? _value.video
          : video // ignore: cast_nullable_to_non_nullable
              as Galleries?,
      product: freezed == product
          ? _value.product
          : product // ignore: cast_nullable_to_non_nullable
              as ProductData?,
      translations: null == translations
          ? _value._translations
          : translations // ignore: cast_nullable_to_non_nullable
              as Map<String, List<String>>,
    ));
  }
}

/// @nodoc

class _$EditProductStateImpl extends _EditProductState {
  const _$EditProductStateImpl(
      {this.regionId = null,
      this.countryId = null,
      this.cityId = null,
      this.areaId = null,
      this.active = true,
      this.isLoading = false,
      final List<String> images = const [],
      final List<Galleries> listOfUrls = const [],
      final List<SelectedAttribute> attributes = const [],
      this.video = null,
      this.product = null,
      final Map<String, List<String>> translations = const {}})
      : _images = images,
        _listOfUrls = listOfUrls,
        _attributes = attributes,
        _translations = translations,
        super._();

  @override
  @JsonKey()
  final int? regionId;
  @override
  @JsonKey()
  final int? countryId;
  @override
  @JsonKey()
  final int? cityId;
  @override
  @JsonKey()
  final int? areaId;
  @override
  @JsonKey()
  final bool active;
  @override
  @JsonKey()
  final bool isLoading;
  final List<String> _images;
  @override
  @JsonKey()
  List<String> get images {
    if (_images is EqualUnmodifiableListView) return _images;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_images);
  }

  final List<Galleries> _listOfUrls;
  @override
  @JsonKey()
  List<Galleries> get listOfUrls {
    if (_listOfUrls is EqualUnmodifiableListView) return _listOfUrls;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_listOfUrls);
  }

  final List<SelectedAttribute> _attributes;
  @override
  @JsonKey()
  List<SelectedAttribute> get attributes {
    if (_attributes is EqualUnmodifiableListView) return _attributes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_attributes);
  }

  @override
  @JsonKey()
  final Galleries? video;
  @override
  @JsonKey()
  final ProductData? product;
  final Map<String, List<String>> _translations;
  @override
  @JsonKey()
  Map<String, List<String>> get translations {
    if (_translations is EqualUnmodifiableMapView) return _translations;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_translations);
  }

  @override
  String toString() {
    return 'EditProductState(regionId: $regionId, countryId: $countryId, cityId: $cityId, areaId: $areaId, active: $active, isLoading: $isLoading, images: $images, listOfUrls: $listOfUrls, attributes: $attributes, video: $video, product: $product, translations: $translations)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EditProductStateImpl &&
            (identical(other.regionId, regionId) ||
                other.regionId == regionId) &&
            (identical(other.countryId, countryId) ||
                other.countryId == countryId) &&
            (identical(other.cityId, cityId) || other.cityId == cityId) &&
            (identical(other.areaId, areaId) || other.areaId == areaId) &&
            (identical(other.active, active) || other.active == active) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            const DeepCollectionEquality().equals(other._images, _images) &&
            const DeepCollectionEquality()
                .equals(other._listOfUrls, _listOfUrls) &&
            const DeepCollectionEquality()
                .equals(other._attributes, _attributes) &&
            (identical(other.video, video) || other.video == video) &&
            (identical(other.product, product) || other.product == product) &&
            const DeepCollectionEquality()
                .equals(other._translations, _translations));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      regionId,
      countryId,
      cityId,
      areaId,
      active,
      isLoading,
      const DeepCollectionEquality().hash(_images),
      const DeepCollectionEquality().hash(_listOfUrls),
      const DeepCollectionEquality().hash(_attributes),
      video,
      product,
      const DeepCollectionEquality().hash(_translations));

  /// Create a copy of EditProductState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EditProductStateImplCopyWith<_$EditProductStateImpl> get copyWith =>
      __$$EditProductStateImplCopyWithImpl<_$EditProductStateImpl>(
          this, _$identity);
}

abstract class _EditProductState extends EditProductState {
  const factory _EditProductState(
      {final int? regionId,
      final int? countryId,
      final int? cityId,
      final int? areaId,
      final bool active,
      final bool isLoading,
      final List<String> images,
      final List<Galleries> listOfUrls,
      final List<SelectedAttribute> attributes,
      final Galleries? video,
      final ProductData? product,
      final Map<String, List<String>> translations}) = _$EditProductStateImpl;
  const _EditProductState._() : super._();

  @override
  int? get regionId;
  @override
  int? get countryId;
  @override
  int? get cityId;
  @override
  int? get areaId;
  @override
  bool get active;
  @override
  bool get isLoading;
  @override
  List<String> get images;
  @override
  List<Galleries> get listOfUrls;
  @override
  List<SelectedAttribute> get attributes;
  @override
  Galleries? get video;
  @override
  ProductData? get product;
  @override
  Map<String, List<String>> get translations;

  /// Create a copy of EditProductState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EditProductStateImplCopyWith<_$EditProductStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
