// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'create_product_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$CreateProductEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int? countryId) setCountry,
    required TResult Function(int? cityId) setCity,
    required TResult Function(String file) setImageFile,
    required TResult Function(Galleries gallery) setVideo,
    required TResult Function(String value) deleteImage,
    required TResult Function(SelectedAttribute attribute) selectAttribute,
    required TResult Function() deleteVideo,
    required TResult Function(
            BuildContext context,
            ProductRequest productRequest,
            ValueChanged<ProductData?>? created,
            VoidCallback? onError)
        createProduct,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int? countryId)? setCountry,
    TResult? Function(int? cityId)? setCity,
    TResult? Function(String file)? setImageFile,
    TResult? Function(Galleries gallery)? setVideo,
    TResult? Function(String value)? deleteImage,
    TResult? Function(SelectedAttribute attribute)? selectAttribute,
    TResult? Function()? deleteVideo,
    TResult? Function(BuildContext context, ProductRequest productRequest,
            ValueChanged<ProductData?>? created, VoidCallback? onError)?
        createProduct,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int? countryId)? setCountry,
    TResult Function(int? cityId)? setCity,
    TResult Function(String file)? setImageFile,
    TResult Function(Galleries gallery)? setVideo,
    TResult Function(String value)? deleteImage,
    TResult Function(SelectedAttribute attribute)? selectAttribute,
    TResult Function()? deleteVideo,
    TResult Function(BuildContext context, ProductRequest productRequest,
            ValueChanged<ProductData?>? created, VoidCallback? onError)?
        createProduct,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SetCountry value) setCountry,
    required TResult Function(SetCity value) setCity,
    required TResult Function(SetImageFile value) setImageFile,
    required TResult Function(SetVideo value) setVideo,
    required TResult Function(DeleteImage value) deleteImage,
    required TResult Function(SelectAttribute value) selectAttribute,
    required TResult Function(DeleteVideo value) deleteVideo,
    required TResult Function(CreateProduct value) createProduct,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SetCountry value)? setCountry,
    TResult? Function(SetCity value)? setCity,
    TResult? Function(SetImageFile value)? setImageFile,
    TResult? Function(SetVideo value)? setVideo,
    TResult? Function(DeleteImage value)? deleteImage,
    TResult? Function(SelectAttribute value)? selectAttribute,
    TResult? Function(DeleteVideo value)? deleteVideo,
    TResult? Function(CreateProduct value)? createProduct,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SetCountry value)? setCountry,
    TResult Function(SetCity value)? setCity,
    TResult Function(SetImageFile value)? setImageFile,
    TResult Function(SetVideo value)? setVideo,
    TResult Function(DeleteImage value)? deleteImage,
    TResult Function(SelectAttribute value)? selectAttribute,
    TResult Function(DeleteVideo value)? deleteVideo,
    TResult Function(CreateProduct value)? createProduct,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CreateProductEventCopyWith<$Res> {
  factory $CreateProductEventCopyWith(
          CreateProductEvent value, $Res Function(CreateProductEvent) then) =
      _$CreateProductEventCopyWithImpl<$Res, CreateProductEvent>;
}

/// @nodoc
class _$CreateProductEventCopyWithImpl<$Res, $Val extends CreateProductEvent>
    implements $CreateProductEventCopyWith<$Res> {
  _$CreateProductEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CreateProductEvent
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
    extends _$CreateProductEventCopyWithImpl<$Res, _$SetCountryImpl>
    implements _$$SetCountryImplCopyWith<$Res> {
  __$$SetCountryImplCopyWithImpl(
      _$SetCountryImpl _value, $Res Function(_$SetCountryImpl) _then)
      : super(_value, _then);

  /// Create a copy of CreateProductEvent
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
    return 'CreateProductEvent.setCountry(countryId: $countryId)';
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

  /// Create a copy of CreateProductEvent
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
    required TResult Function(String file) setImageFile,
    required TResult Function(Galleries gallery) setVideo,
    required TResult Function(String value) deleteImage,
    required TResult Function(SelectedAttribute attribute) selectAttribute,
    required TResult Function() deleteVideo,
    required TResult Function(
            BuildContext context,
            ProductRequest productRequest,
            ValueChanged<ProductData?>? created,
            VoidCallback? onError)
        createProduct,
  }) {
    return setCountry(countryId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int? countryId)? setCountry,
    TResult? Function(int? cityId)? setCity,
    TResult? Function(String file)? setImageFile,
    TResult? Function(Galleries gallery)? setVideo,
    TResult? Function(String value)? deleteImage,
    TResult? Function(SelectedAttribute attribute)? selectAttribute,
    TResult? Function()? deleteVideo,
    TResult? Function(BuildContext context, ProductRequest productRequest,
            ValueChanged<ProductData?>? created, VoidCallback? onError)?
        createProduct,
  }) {
    return setCountry?.call(countryId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int? countryId)? setCountry,
    TResult Function(int? cityId)? setCity,
    TResult Function(String file)? setImageFile,
    TResult Function(Galleries gallery)? setVideo,
    TResult Function(String value)? deleteImage,
    TResult Function(SelectedAttribute attribute)? selectAttribute,
    TResult Function()? deleteVideo,
    TResult Function(BuildContext context, ProductRequest productRequest,
            ValueChanged<ProductData?>? created, VoidCallback? onError)?
        createProduct,
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
    required TResult Function(SetImageFile value) setImageFile,
    required TResult Function(SetVideo value) setVideo,
    required TResult Function(DeleteImage value) deleteImage,
    required TResult Function(SelectAttribute value) selectAttribute,
    required TResult Function(DeleteVideo value) deleteVideo,
    required TResult Function(CreateProduct value) createProduct,
  }) {
    return setCountry(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SetCountry value)? setCountry,
    TResult? Function(SetCity value)? setCity,
    TResult? Function(SetImageFile value)? setImageFile,
    TResult? Function(SetVideo value)? setVideo,
    TResult? Function(DeleteImage value)? deleteImage,
    TResult? Function(SelectAttribute value)? selectAttribute,
    TResult? Function(DeleteVideo value)? deleteVideo,
    TResult? Function(CreateProduct value)? createProduct,
  }) {
    return setCountry?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SetCountry value)? setCountry,
    TResult Function(SetCity value)? setCity,
    TResult Function(SetImageFile value)? setImageFile,
    TResult Function(SetVideo value)? setVideo,
    TResult Function(DeleteImage value)? deleteImage,
    TResult Function(SelectAttribute value)? selectAttribute,
    TResult Function(DeleteVideo value)? deleteVideo,
    TResult Function(CreateProduct value)? createProduct,
    required TResult orElse(),
  }) {
    if (setCountry != null) {
      return setCountry(this);
    }
    return orElse();
  }
}

abstract class SetCountry implements CreateProductEvent {
  const factory SetCountry({final int? countryId}) = _$SetCountryImpl;

  int? get countryId;

  /// Create a copy of CreateProductEvent
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
    extends _$CreateProductEventCopyWithImpl<$Res, _$SetCityImpl>
    implements _$$SetCityImplCopyWith<$Res> {
  __$$SetCityImplCopyWithImpl(
      _$SetCityImpl _value, $Res Function(_$SetCityImpl) _then)
      : super(_value, _then);

  /// Create a copy of CreateProductEvent
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
    return 'CreateProductEvent.setCity(cityId: $cityId)';
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

  /// Create a copy of CreateProductEvent
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
    required TResult Function(String file) setImageFile,
    required TResult Function(Galleries gallery) setVideo,
    required TResult Function(String value) deleteImage,
    required TResult Function(SelectedAttribute attribute) selectAttribute,
    required TResult Function() deleteVideo,
    required TResult Function(
            BuildContext context,
            ProductRequest productRequest,
            ValueChanged<ProductData?>? created,
            VoidCallback? onError)
        createProduct,
  }) {
    return setCity(cityId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int? countryId)? setCountry,
    TResult? Function(int? cityId)? setCity,
    TResult? Function(String file)? setImageFile,
    TResult? Function(Galleries gallery)? setVideo,
    TResult? Function(String value)? deleteImage,
    TResult? Function(SelectedAttribute attribute)? selectAttribute,
    TResult? Function()? deleteVideo,
    TResult? Function(BuildContext context, ProductRequest productRequest,
            ValueChanged<ProductData?>? created, VoidCallback? onError)?
        createProduct,
  }) {
    return setCity?.call(cityId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int? countryId)? setCountry,
    TResult Function(int? cityId)? setCity,
    TResult Function(String file)? setImageFile,
    TResult Function(Galleries gallery)? setVideo,
    TResult Function(String value)? deleteImage,
    TResult Function(SelectedAttribute attribute)? selectAttribute,
    TResult Function()? deleteVideo,
    TResult Function(BuildContext context, ProductRequest productRequest,
            ValueChanged<ProductData?>? created, VoidCallback? onError)?
        createProduct,
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
    required TResult Function(SetImageFile value) setImageFile,
    required TResult Function(SetVideo value) setVideo,
    required TResult Function(DeleteImage value) deleteImage,
    required TResult Function(SelectAttribute value) selectAttribute,
    required TResult Function(DeleteVideo value) deleteVideo,
    required TResult Function(CreateProduct value) createProduct,
  }) {
    return setCity(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SetCountry value)? setCountry,
    TResult? Function(SetCity value)? setCity,
    TResult? Function(SetImageFile value)? setImageFile,
    TResult? Function(SetVideo value)? setVideo,
    TResult? Function(DeleteImage value)? deleteImage,
    TResult? Function(SelectAttribute value)? selectAttribute,
    TResult? Function(DeleteVideo value)? deleteVideo,
    TResult? Function(CreateProduct value)? createProduct,
  }) {
    return setCity?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SetCountry value)? setCountry,
    TResult Function(SetCity value)? setCity,
    TResult Function(SetImageFile value)? setImageFile,
    TResult Function(SetVideo value)? setVideo,
    TResult Function(DeleteImage value)? deleteImage,
    TResult Function(SelectAttribute value)? selectAttribute,
    TResult Function(DeleteVideo value)? deleteVideo,
    TResult Function(CreateProduct value)? createProduct,
    required TResult orElse(),
  }) {
    if (setCity != null) {
      return setCity(this);
    }
    return orElse();
  }
}

abstract class SetCity implements CreateProductEvent {
  const factory SetCity({final int? cityId}) = _$SetCityImpl;

  int? get cityId;

  /// Create a copy of CreateProductEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SetCityImplCopyWith<_$SetCityImpl> get copyWith =>
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
    extends _$CreateProductEventCopyWithImpl<$Res, _$SetImageFileImpl>
    implements _$$SetImageFileImplCopyWith<$Res> {
  __$$SetImageFileImplCopyWithImpl(
      _$SetImageFileImpl _value, $Res Function(_$SetImageFileImpl) _then)
      : super(_value, _then);

  /// Create a copy of CreateProductEvent
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
    return 'CreateProductEvent.setImageFile(file: $file)';
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

  /// Create a copy of CreateProductEvent
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
    required TResult Function(String file) setImageFile,
    required TResult Function(Galleries gallery) setVideo,
    required TResult Function(String value) deleteImage,
    required TResult Function(SelectedAttribute attribute) selectAttribute,
    required TResult Function() deleteVideo,
    required TResult Function(
            BuildContext context,
            ProductRequest productRequest,
            ValueChanged<ProductData?>? created,
            VoidCallback? onError)
        createProduct,
  }) {
    return setImageFile(file);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int? countryId)? setCountry,
    TResult? Function(int? cityId)? setCity,
    TResult? Function(String file)? setImageFile,
    TResult? Function(Galleries gallery)? setVideo,
    TResult? Function(String value)? deleteImage,
    TResult? Function(SelectedAttribute attribute)? selectAttribute,
    TResult? Function()? deleteVideo,
    TResult? Function(BuildContext context, ProductRequest productRequest,
            ValueChanged<ProductData?>? created, VoidCallback? onError)?
        createProduct,
  }) {
    return setImageFile?.call(file);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int? countryId)? setCountry,
    TResult Function(int? cityId)? setCity,
    TResult Function(String file)? setImageFile,
    TResult Function(Galleries gallery)? setVideo,
    TResult Function(String value)? deleteImage,
    TResult Function(SelectedAttribute attribute)? selectAttribute,
    TResult Function()? deleteVideo,
    TResult Function(BuildContext context, ProductRequest productRequest,
            ValueChanged<ProductData?>? created, VoidCallback? onError)?
        createProduct,
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
    required TResult Function(SetImageFile value) setImageFile,
    required TResult Function(SetVideo value) setVideo,
    required TResult Function(DeleteImage value) deleteImage,
    required TResult Function(SelectAttribute value) selectAttribute,
    required TResult Function(DeleteVideo value) deleteVideo,
    required TResult Function(CreateProduct value) createProduct,
  }) {
    return setImageFile(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SetCountry value)? setCountry,
    TResult? Function(SetCity value)? setCity,
    TResult? Function(SetImageFile value)? setImageFile,
    TResult? Function(SetVideo value)? setVideo,
    TResult? Function(DeleteImage value)? deleteImage,
    TResult? Function(SelectAttribute value)? selectAttribute,
    TResult? Function(DeleteVideo value)? deleteVideo,
    TResult? Function(CreateProduct value)? createProduct,
  }) {
    return setImageFile?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SetCountry value)? setCountry,
    TResult Function(SetCity value)? setCity,
    TResult Function(SetImageFile value)? setImageFile,
    TResult Function(SetVideo value)? setVideo,
    TResult Function(DeleteImage value)? deleteImage,
    TResult Function(SelectAttribute value)? selectAttribute,
    TResult Function(DeleteVideo value)? deleteVideo,
    TResult Function(CreateProduct value)? createProduct,
    required TResult orElse(),
  }) {
    if (setImageFile != null) {
      return setImageFile(this);
    }
    return orElse();
  }
}

abstract class SetImageFile implements CreateProductEvent {
  const factory SetImageFile({required final String file}) = _$SetImageFileImpl;

  String get file;

  /// Create a copy of CreateProductEvent
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
    extends _$CreateProductEventCopyWithImpl<$Res, _$SetVideoImpl>
    implements _$$SetVideoImplCopyWith<$Res> {
  __$$SetVideoImplCopyWithImpl(
      _$SetVideoImpl _value, $Res Function(_$SetVideoImpl) _then)
      : super(_value, _then);

  /// Create a copy of CreateProductEvent
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
    return 'CreateProductEvent.setVideo(gallery: $gallery)';
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

  /// Create a copy of CreateProductEvent
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
    required TResult Function(String file) setImageFile,
    required TResult Function(Galleries gallery) setVideo,
    required TResult Function(String value) deleteImage,
    required TResult Function(SelectedAttribute attribute) selectAttribute,
    required TResult Function() deleteVideo,
    required TResult Function(
            BuildContext context,
            ProductRequest productRequest,
            ValueChanged<ProductData?>? created,
            VoidCallback? onError)
        createProduct,
  }) {
    return setVideo(gallery);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int? countryId)? setCountry,
    TResult? Function(int? cityId)? setCity,
    TResult? Function(String file)? setImageFile,
    TResult? Function(Galleries gallery)? setVideo,
    TResult? Function(String value)? deleteImage,
    TResult? Function(SelectedAttribute attribute)? selectAttribute,
    TResult? Function()? deleteVideo,
    TResult? Function(BuildContext context, ProductRequest productRequest,
            ValueChanged<ProductData?>? created, VoidCallback? onError)?
        createProduct,
  }) {
    return setVideo?.call(gallery);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int? countryId)? setCountry,
    TResult Function(int? cityId)? setCity,
    TResult Function(String file)? setImageFile,
    TResult Function(Galleries gallery)? setVideo,
    TResult Function(String value)? deleteImage,
    TResult Function(SelectedAttribute attribute)? selectAttribute,
    TResult Function()? deleteVideo,
    TResult Function(BuildContext context, ProductRequest productRequest,
            ValueChanged<ProductData?>? created, VoidCallback? onError)?
        createProduct,
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
    required TResult Function(SetImageFile value) setImageFile,
    required TResult Function(SetVideo value) setVideo,
    required TResult Function(DeleteImage value) deleteImage,
    required TResult Function(SelectAttribute value) selectAttribute,
    required TResult Function(DeleteVideo value) deleteVideo,
    required TResult Function(CreateProduct value) createProduct,
  }) {
    return setVideo(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SetCountry value)? setCountry,
    TResult? Function(SetCity value)? setCity,
    TResult? Function(SetImageFile value)? setImageFile,
    TResult? Function(SetVideo value)? setVideo,
    TResult? Function(DeleteImage value)? deleteImage,
    TResult? Function(SelectAttribute value)? selectAttribute,
    TResult? Function(DeleteVideo value)? deleteVideo,
    TResult? Function(CreateProduct value)? createProduct,
  }) {
    return setVideo?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SetCountry value)? setCountry,
    TResult Function(SetCity value)? setCity,
    TResult Function(SetImageFile value)? setImageFile,
    TResult Function(SetVideo value)? setVideo,
    TResult Function(DeleteImage value)? deleteImage,
    TResult Function(SelectAttribute value)? selectAttribute,
    TResult Function(DeleteVideo value)? deleteVideo,
    TResult Function(CreateProduct value)? createProduct,
    required TResult orElse(),
  }) {
    if (setVideo != null) {
      return setVideo(this);
    }
    return orElse();
  }
}

abstract class SetVideo implements CreateProductEvent {
  const factory SetVideo({required final Galleries gallery}) = _$SetVideoImpl;

  Galleries get gallery;

  /// Create a copy of CreateProductEvent
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
    extends _$CreateProductEventCopyWithImpl<$Res, _$DeleteImageImpl>
    implements _$$DeleteImageImplCopyWith<$Res> {
  __$$DeleteImageImplCopyWithImpl(
      _$DeleteImageImpl _value, $Res Function(_$DeleteImageImpl) _then)
      : super(_value, _then);

  /// Create a copy of CreateProductEvent
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
    return 'CreateProductEvent.deleteImage(value: $value)';
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

  /// Create a copy of CreateProductEvent
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
    required TResult Function(String file) setImageFile,
    required TResult Function(Galleries gallery) setVideo,
    required TResult Function(String value) deleteImage,
    required TResult Function(SelectedAttribute attribute) selectAttribute,
    required TResult Function() deleteVideo,
    required TResult Function(
            BuildContext context,
            ProductRequest productRequest,
            ValueChanged<ProductData?>? created,
            VoidCallback? onError)
        createProduct,
  }) {
    return deleteImage(value);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int? countryId)? setCountry,
    TResult? Function(int? cityId)? setCity,
    TResult? Function(String file)? setImageFile,
    TResult? Function(Galleries gallery)? setVideo,
    TResult? Function(String value)? deleteImage,
    TResult? Function(SelectedAttribute attribute)? selectAttribute,
    TResult? Function()? deleteVideo,
    TResult? Function(BuildContext context, ProductRequest productRequest,
            ValueChanged<ProductData?>? created, VoidCallback? onError)?
        createProduct,
  }) {
    return deleteImage?.call(value);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int? countryId)? setCountry,
    TResult Function(int? cityId)? setCity,
    TResult Function(String file)? setImageFile,
    TResult Function(Galleries gallery)? setVideo,
    TResult Function(String value)? deleteImage,
    TResult Function(SelectedAttribute attribute)? selectAttribute,
    TResult Function()? deleteVideo,
    TResult Function(BuildContext context, ProductRequest productRequest,
            ValueChanged<ProductData?>? created, VoidCallback? onError)?
        createProduct,
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
    required TResult Function(SetImageFile value) setImageFile,
    required TResult Function(SetVideo value) setVideo,
    required TResult Function(DeleteImage value) deleteImage,
    required TResult Function(SelectAttribute value) selectAttribute,
    required TResult Function(DeleteVideo value) deleteVideo,
    required TResult Function(CreateProduct value) createProduct,
  }) {
    return deleteImage(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SetCountry value)? setCountry,
    TResult? Function(SetCity value)? setCity,
    TResult? Function(SetImageFile value)? setImageFile,
    TResult? Function(SetVideo value)? setVideo,
    TResult? Function(DeleteImage value)? deleteImage,
    TResult? Function(SelectAttribute value)? selectAttribute,
    TResult? Function(DeleteVideo value)? deleteVideo,
    TResult? Function(CreateProduct value)? createProduct,
  }) {
    return deleteImage?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SetCountry value)? setCountry,
    TResult Function(SetCity value)? setCity,
    TResult Function(SetImageFile value)? setImageFile,
    TResult Function(SetVideo value)? setVideo,
    TResult Function(DeleteImage value)? deleteImage,
    TResult Function(SelectAttribute value)? selectAttribute,
    TResult Function(DeleteVideo value)? deleteVideo,
    TResult Function(CreateProduct value)? createProduct,
    required TResult orElse(),
  }) {
    if (deleteImage != null) {
      return deleteImage(this);
    }
    return orElse();
  }
}

abstract class DeleteImage implements CreateProductEvent {
  const factory DeleteImage({required final String value}) = _$DeleteImageImpl;

  String get value;

  /// Create a copy of CreateProductEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DeleteImageImplCopyWith<_$DeleteImageImpl> get copyWith =>
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
    extends _$CreateProductEventCopyWithImpl<$Res, _$SelectAttributeImpl>
    implements _$$SelectAttributeImplCopyWith<$Res> {
  __$$SelectAttributeImplCopyWithImpl(
      _$SelectAttributeImpl _value, $Res Function(_$SelectAttributeImpl) _then)
      : super(_value, _then);

  /// Create a copy of CreateProductEvent
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
    return 'CreateProductEvent.selectAttribute(attribute: $attribute)';
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

  /// Create a copy of CreateProductEvent
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
    required TResult Function(String file) setImageFile,
    required TResult Function(Galleries gallery) setVideo,
    required TResult Function(String value) deleteImage,
    required TResult Function(SelectedAttribute attribute) selectAttribute,
    required TResult Function() deleteVideo,
    required TResult Function(
            BuildContext context,
            ProductRequest productRequest,
            ValueChanged<ProductData?>? created,
            VoidCallback? onError)
        createProduct,
  }) {
    return selectAttribute(attribute);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int? countryId)? setCountry,
    TResult? Function(int? cityId)? setCity,
    TResult? Function(String file)? setImageFile,
    TResult? Function(Galleries gallery)? setVideo,
    TResult? Function(String value)? deleteImage,
    TResult? Function(SelectedAttribute attribute)? selectAttribute,
    TResult? Function()? deleteVideo,
    TResult? Function(BuildContext context, ProductRequest productRequest,
            ValueChanged<ProductData?>? created, VoidCallback? onError)?
        createProduct,
  }) {
    return selectAttribute?.call(attribute);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int? countryId)? setCountry,
    TResult Function(int? cityId)? setCity,
    TResult Function(String file)? setImageFile,
    TResult Function(Galleries gallery)? setVideo,
    TResult Function(String value)? deleteImage,
    TResult Function(SelectedAttribute attribute)? selectAttribute,
    TResult Function()? deleteVideo,
    TResult Function(BuildContext context, ProductRequest productRequest,
            ValueChanged<ProductData?>? created, VoidCallback? onError)?
        createProduct,
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
    required TResult Function(SetImageFile value) setImageFile,
    required TResult Function(SetVideo value) setVideo,
    required TResult Function(DeleteImage value) deleteImage,
    required TResult Function(SelectAttribute value) selectAttribute,
    required TResult Function(DeleteVideo value) deleteVideo,
    required TResult Function(CreateProduct value) createProduct,
  }) {
    return selectAttribute(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SetCountry value)? setCountry,
    TResult? Function(SetCity value)? setCity,
    TResult? Function(SetImageFile value)? setImageFile,
    TResult? Function(SetVideo value)? setVideo,
    TResult? Function(DeleteImage value)? deleteImage,
    TResult? Function(SelectAttribute value)? selectAttribute,
    TResult? Function(DeleteVideo value)? deleteVideo,
    TResult? Function(CreateProduct value)? createProduct,
  }) {
    return selectAttribute?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SetCountry value)? setCountry,
    TResult Function(SetCity value)? setCity,
    TResult Function(SetImageFile value)? setImageFile,
    TResult Function(SetVideo value)? setVideo,
    TResult Function(DeleteImage value)? deleteImage,
    TResult Function(SelectAttribute value)? selectAttribute,
    TResult Function(DeleteVideo value)? deleteVideo,
    TResult Function(CreateProduct value)? createProduct,
    required TResult orElse(),
  }) {
    if (selectAttribute != null) {
      return selectAttribute(this);
    }
    return orElse();
  }
}

abstract class SelectAttribute implements CreateProductEvent {
  const factory SelectAttribute({required final SelectedAttribute attribute}) =
      _$SelectAttributeImpl;

  SelectedAttribute get attribute;

  /// Create a copy of CreateProductEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SelectAttributeImplCopyWith<_$SelectAttributeImpl> get copyWith =>
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
    extends _$CreateProductEventCopyWithImpl<$Res, _$DeleteVideoImpl>
    implements _$$DeleteVideoImplCopyWith<$Res> {
  __$$DeleteVideoImplCopyWithImpl(
      _$DeleteVideoImpl _value, $Res Function(_$DeleteVideoImpl) _then)
      : super(_value, _then);

  /// Create a copy of CreateProductEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$DeleteVideoImpl implements DeleteVideo {
  const _$DeleteVideoImpl();

  @override
  String toString() {
    return 'CreateProductEvent.deleteVideo()';
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
    required TResult Function(String file) setImageFile,
    required TResult Function(Galleries gallery) setVideo,
    required TResult Function(String value) deleteImage,
    required TResult Function(SelectedAttribute attribute) selectAttribute,
    required TResult Function() deleteVideo,
    required TResult Function(
            BuildContext context,
            ProductRequest productRequest,
            ValueChanged<ProductData?>? created,
            VoidCallback? onError)
        createProduct,
  }) {
    return deleteVideo();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int? countryId)? setCountry,
    TResult? Function(int? cityId)? setCity,
    TResult? Function(String file)? setImageFile,
    TResult? Function(Galleries gallery)? setVideo,
    TResult? Function(String value)? deleteImage,
    TResult? Function(SelectedAttribute attribute)? selectAttribute,
    TResult? Function()? deleteVideo,
    TResult? Function(BuildContext context, ProductRequest productRequest,
            ValueChanged<ProductData?>? created, VoidCallback? onError)?
        createProduct,
  }) {
    return deleteVideo?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int? countryId)? setCountry,
    TResult Function(int? cityId)? setCity,
    TResult Function(String file)? setImageFile,
    TResult Function(Galleries gallery)? setVideo,
    TResult Function(String value)? deleteImage,
    TResult Function(SelectedAttribute attribute)? selectAttribute,
    TResult Function()? deleteVideo,
    TResult Function(BuildContext context, ProductRequest productRequest,
            ValueChanged<ProductData?>? created, VoidCallback? onError)?
        createProduct,
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
    required TResult Function(SetImageFile value) setImageFile,
    required TResult Function(SetVideo value) setVideo,
    required TResult Function(DeleteImage value) deleteImage,
    required TResult Function(SelectAttribute value) selectAttribute,
    required TResult Function(DeleteVideo value) deleteVideo,
    required TResult Function(CreateProduct value) createProduct,
  }) {
    return deleteVideo(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SetCountry value)? setCountry,
    TResult? Function(SetCity value)? setCity,
    TResult? Function(SetImageFile value)? setImageFile,
    TResult? Function(SetVideo value)? setVideo,
    TResult? Function(DeleteImage value)? deleteImage,
    TResult? Function(SelectAttribute value)? selectAttribute,
    TResult? Function(DeleteVideo value)? deleteVideo,
    TResult? Function(CreateProduct value)? createProduct,
  }) {
    return deleteVideo?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SetCountry value)? setCountry,
    TResult Function(SetCity value)? setCity,
    TResult Function(SetImageFile value)? setImageFile,
    TResult Function(SetVideo value)? setVideo,
    TResult Function(DeleteImage value)? deleteImage,
    TResult Function(SelectAttribute value)? selectAttribute,
    TResult Function(DeleteVideo value)? deleteVideo,
    TResult Function(CreateProduct value)? createProduct,
    required TResult orElse(),
  }) {
    if (deleteVideo != null) {
      return deleteVideo(this);
    }
    return orElse();
  }
}

abstract class DeleteVideo implements CreateProductEvent {
  const factory DeleteVideo() = _$DeleteVideoImpl;
}

/// @nodoc
abstract class _$$CreateProductImplCopyWith<$Res> {
  factory _$$CreateProductImplCopyWith(
          _$CreateProductImpl value, $Res Function(_$CreateProductImpl) then) =
      __$$CreateProductImplCopyWithImpl<$Res>;
  @useResult
  $Res call(
      {BuildContext context,
      ProductRequest productRequest,
      ValueChanged<ProductData?>? created,
      VoidCallback? onError});
}

/// @nodoc
class __$$CreateProductImplCopyWithImpl<$Res>
    extends _$CreateProductEventCopyWithImpl<$Res, _$CreateProductImpl>
    implements _$$CreateProductImplCopyWith<$Res> {
  __$$CreateProductImplCopyWithImpl(
      _$CreateProductImpl _value, $Res Function(_$CreateProductImpl) _then)
      : super(_value, _then);

  /// Create a copy of CreateProductEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? context = null,
    Object? productRequest = null,
    Object? created = freezed,
    Object? onError = freezed,
  }) {
    return _then(_$CreateProductImpl(
      context: null == context
          ? _value.context
          : context // ignore: cast_nullable_to_non_nullable
              as BuildContext,
      productRequest: null == productRequest
          ? _value.productRequest
          : productRequest // ignore: cast_nullable_to_non_nullable
              as ProductRequest,
      created: freezed == created
          ? _value.created
          : created // ignore: cast_nullable_to_non_nullable
              as ValueChanged<ProductData?>?,
      onError: freezed == onError
          ? _value.onError
          : onError // ignore: cast_nullable_to_non_nullable
              as VoidCallback?,
    ));
  }
}

/// @nodoc

class _$CreateProductImpl implements CreateProduct {
  const _$CreateProductImpl(
      {required this.context,
      required this.productRequest,
      this.created,
      this.onError});

  @override
  final BuildContext context;
  @override
  final ProductRequest productRequest;
  @override
  final ValueChanged<ProductData?>? created;
  @override
  final VoidCallback? onError;

  @override
  String toString() {
    return 'CreateProductEvent.createProduct(context: $context, productRequest: $productRequest, created: $created, onError: $onError)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CreateProductImpl &&
            (identical(other.context, context) || other.context == context) &&
            (identical(other.productRequest, productRequest) ||
                other.productRequest == productRequest) &&
            (identical(other.created, created) || other.created == created) &&
            (identical(other.onError, onError) || other.onError == onError));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, context, productRequest, created, onError);

  /// Create a copy of CreateProductEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CreateProductImplCopyWith<_$CreateProductImpl> get copyWith =>
      __$$CreateProductImplCopyWithImpl<_$CreateProductImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int? countryId) setCountry,
    required TResult Function(int? cityId) setCity,
    required TResult Function(String file) setImageFile,
    required TResult Function(Galleries gallery) setVideo,
    required TResult Function(String value) deleteImage,
    required TResult Function(SelectedAttribute attribute) selectAttribute,
    required TResult Function() deleteVideo,
    required TResult Function(
            BuildContext context,
            ProductRequest productRequest,
            ValueChanged<ProductData?>? created,
            VoidCallback? onError)
        createProduct,
  }) {
    return createProduct(context, productRequest, created, onError);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int? countryId)? setCountry,
    TResult? Function(int? cityId)? setCity,
    TResult? Function(String file)? setImageFile,
    TResult? Function(Galleries gallery)? setVideo,
    TResult? Function(String value)? deleteImage,
    TResult? Function(SelectedAttribute attribute)? selectAttribute,
    TResult? Function()? deleteVideo,
    TResult? Function(BuildContext context, ProductRequest productRequest,
            ValueChanged<ProductData?>? created, VoidCallback? onError)?
        createProduct,
  }) {
    return createProduct?.call(context, productRequest, created, onError);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int? countryId)? setCountry,
    TResult Function(int? cityId)? setCity,
    TResult Function(String file)? setImageFile,
    TResult Function(Galleries gallery)? setVideo,
    TResult Function(String value)? deleteImage,
    TResult Function(SelectedAttribute attribute)? selectAttribute,
    TResult Function()? deleteVideo,
    TResult Function(BuildContext context, ProductRequest productRequest,
            ValueChanged<ProductData?>? created, VoidCallback? onError)?
        createProduct,
    required TResult orElse(),
  }) {
    if (createProduct != null) {
      return createProduct(context, productRequest, created, onError);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SetCountry value) setCountry,
    required TResult Function(SetCity value) setCity,
    required TResult Function(SetImageFile value) setImageFile,
    required TResult Function(SetVideo value) setVideo,
    required TResult Function(DeleteImage value) deleteImage,
    required TResult Function(SelectAttribute value) selectAttribute,
    required TResult Function(DeleteVideo value) deleteVideo,
    required TResult Function(CreateProduct value) createProduct,
  }) {
    return createProduct(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SetCountry value)? setCountry,
    TResult? Function(SetCity value)? setCity,
    TResult? Function(SetImageFile value)? setImageFile,
    TResult? Function(SetVideo value)? setVideo,
    TResult? Function(DeleteImage value)? deleteImage,
    TResult? Function(SelectAttribute value)? selectAttribute,
    TResult? Function(DeleteVideo value)? deleteVideo,
    TResult? Function(CreateProduct value)? createProduct,
  }) {
    return createProduct?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SetCountry value)? setCountry,
    TResult Function(SetCity value)? setCity,
    TResult Function(SetImageFile value)? setImageFile,
    TResult Function(SetVideo value)? setVideo,
    TResult Function(DeleteImage value)? deleteImage,
    TResult Function(SelectAttribute value)? selectAttribute,
    TResult Function(DeleteVideo value)? deleteVideo,
    TResult Function(CreateProduct value)? createProduct,
    required TResult orElse(),
  }) {
    if (createProduct != null) {
      return createProduct(this);
    }
    return orElse();
  }
}

abstract class CreateProduct implements CreateProductEvent {
  const factory CreateProduct(
      {required final BuildContext context,
      required final ProductRequest productRequest,
      final ValueChanged<ProductData?>? created,
      final VoidCallback? onError}) = _$CreateProductImpl;

  BuildContext get context;
  ProductRequest get productRequest;
  ValueChanged<ProductData?>? get created;
  VoidCallback? get onError;

  /// Create a copy of CreateProductEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CreateProductImplCopyWith<_$CreateProductImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$CreateProductState {
  int? get countryId => throw _privateConstructorUsedError;
  int? get cityId => throw _privateConstructorUsedError;
  bool get active => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;
  List<String> get images => throw _privateConstructorUsedError;
  List<Galleries> get listOfUrls => throw _privateConstructorUsedError;
  Galleries? get video => throw _privateConstructorUsedError;
  Map<String, List<String>> get translations =>
      throw _privateConstructorUsedError;
  List<SelectedAttribute> get attributes => throw _privateConstructorUsedError;

  /// Create a copy of CreateProductState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CreateProductStateCopyWith<CreateProductState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CreateProductStateCopyWith<$Res> {
  factory $CreateProductStateCopyWith(
          CreateProductState value, $Res Function(CreateProductState) then) =
      _$CreateProductStateCopyWithImpl<$Res, CreateProductState>;
  @useResult
  $Res call(
      {int? countryId,
      int? cityId,
      bool active,
      bool isLoading,
      List<String> images,
      List<Galleries> listOfUrls,
      Galleries? video,
      Map<String, List<String>> translations,
      List<SelectedAttribute> attributes});
}

/// @nodoc
class _$CreateProductStateCopyWithImpl<$Res, $Val extends CreateProductState>
    implements $CreateProductStateCopyWith<$Res> {
  _$CreateProductStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CreateProductState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? countryId = freezed,
    Object? cityId = freezed,
    Object? active = null,
    Object? isLoading = null,
    Object? images = null,
    Object? listOfUrls = null,
    Object? video = freezed,
    Object? translations = null,
    Object? attributes = null,
  }) {
    return _then(_value.copyWith(
      countryId: freezed == countryId
          ? _value.countryId
          : countryId // ignore: cast_nullable_to_non_nullable
              as int?,
      cityId: freezed == cityId
          ? _value.cityId
          : cityId // ignore: cast_nullable_to_non_nullable
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
      video: freezed == video
          ? _value.video
          : video // ignore: cast_nullable_to_non_nullable
              as Galleries?,
      translations: null == translations
          ? _value.translations
          : translations // ignore: cast_nullable_to_non_nullable
              as Map<String, List<String>>,
      attributes: null == attributes
          ? _value.attributes
          : attributes // ignore: cast_nullable_to_non_nullable
              as List<SelectedAttribute>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CreateProductStateImplCopyWith<$Res>
    implements $CreateProductStateCopyWith<$Res> {
  factory _$$CreateProductStateImplCopyWith(_$CreateProductStateImpl value,
          $Res Function(_$CreateProductStateImpl) then) =
      __$$CreateProductStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? countryId,
      int? cityId,
      bool active,
      bool isLoading,
      List<String> images,
      List<Galleries> listOfUrls,
      Galleries? video,
      Map<String, List<String>> translations,
      List<SelectedAttribute> attributes});
}

/// @nodoc
class __$$CreateProductStateImplCopyWithImpl<$Res>
    extends _$CreateProductStateCopyWithImpl<$Res, _$CreateProductStateImpl>
    implements _$$CreateProductStateImplCopyWith<$Res> {
  __$$CreateProductStateImplCopyWithImpl(_$CreateProductStateImpl _value,
      $Res Function(_$CreateProductStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of CreateProductState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? countryId = freezed,
    Object? cityId = freezed,
    Object? active = null,
    Object? isLoading = null,
    Object? images = null,
    Object? listOfUrls = null,
    Object? video = freezed,
    Object? translations = null,
    Object? attributes = null,
  }) {
    return _then(_$CreateProductStateImpl(
      countryId: freezed == countryId
          ? _value.countryId
          : countryId // ignore: cast_nullable_to_non_nullable
              as int?,
      cityId: freezed == cityId
          ? _value.cityId
          : cityId // ignore: cast_nullable_to_non_nullable
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
      video: freezed == video
          ? _value.video
          : video // ignore: cast_nullable_to_non_nullable
              as Galleries?,
      translations: null == translations
          ? _value._translations
          : translations // ignore: cast_nullable_to_non_nullable
              as Map<String, List<String>>,
      attributes: null == attributes
          ? _value._attributes
          : attributes // ignore: cast_nullable_to_non_nullable
              as List<SelectedAttribute>,
    ));
  }
}

/// @nodoc

class _$CreateProductStateImpl extends _CreateProductState {
  const _$CreateProductStateImpl(
      {this.countryId = null,
      this.cityId = null,
      this.active = true,
      this.isLoading = false,
      final List<String> images = const [],
      final List<Galleries> listOfUrls = const [],
      this.video = null,
      final Map<String, List<String>> translations = const {},
      final List<SelectedAttribute> attributes = const []})
      : _images = images,
        _listOfUrls = listOfUrls,
        _translations = translations,
        _attributes = attributes,
        super._();

  @override
  @JsonKey()
  final int? countryId;
  @override
  @JsonKey()
  final int? cityId;
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

  @override
  @JsonKey()
  final Galleries? video;
  final Map<String, List<String>> _translations;
  @override
  @JsonKey()
  Map<String, List<String>> get translations {
    if (_translations is EqualUnmodifiableMapView) return _translations;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_translations);
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
  String toString() {
    return 'CreateProductState(countryId: $countryId, cityId: $cityId, active: $active, isLoading: $isLoading, images: $images, listOfUrls: $listOfUrls, video: $video, translations: $translations, attributes: $attributes)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CreateProductStateImpl &&
            (identical(other.countryId, countryId) ||
                other.countryId == countryId) &&
            (identical(other.cityId, cityId) || other.cityId == cityId) &&
            (identical(other.active, active) || other.active == active) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            const DeepCollectionEquality().equals(other._images, _images) &&
            const DeepCollectionEquality()
                .equals(other._listOfUrls, _listOfUrls) &&
            (identical(other.video, video) || other.video == video) &&
            const DeepCollectionEquality()
                .equals(other._translations, _translations) &&
            const DeepCollectionEquality()
                .equals(other._attributes, _attributes));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      countryId,
      cityId,
      active,
      isLoading,
      const DeepCollectionEquality().hash(_images),
      const DeepCollectionEquality().hash(_listOfUrls),
      video,
      const DeepCollectionEquality().hash(_translations),
      const DeepCollectionEquality().hash(_attributes));

  /// Create a copy of CreateProductState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CreateProductStateImplCopyWith<_$CreateProductStateImpl> get copyWith =>
      __$$CreateProductStateImplCopyWithImpl<_$CreateProductStateImpl>(
          this, _$identity);
}

abstract class _CreateProductState extends CreateProductState {
  const factory _CreateProductState(
      {final int? countryId,
      final int? cityId,
      final bool active,
      final bool isLoading,
      final List<String> images,
      final List<Galleries> listOfUrls,
      final Galleries? video,
      final Map<String, List<String>> translations,
      final List<SelectedAttribute> attributes}) = _$CreateProductStateImpl;
  const _CreateProductState._() : super._();

  @override
  int? get countryId;
  @override
  int? get cityId;
  @override
  bool get active;
  @override
  bool get isLoading;
  @override
  List<String> get images;
  @override
  List<Galleries> get listOfUrls;
  @override
  Galleries? get video;
  @override
  Map<String, List<String>> get translations;
  @override
  List<SelectedAttribute> get attributes;

  /// Create a copy of CreateProductState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CreateProductStateImplCopyWith<_$CreateProductStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
