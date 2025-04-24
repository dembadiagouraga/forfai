// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'banner_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$BannerEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(BuildContext context, bool? isRefresh,
            RefreshController? controller)
        fetchBanner,
    required TResult Function(BuildContext context, int id) fetchProduct,
    required TResult Function() updateProduct,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(BuildContext context, bool? isRefresh,
            RefreshController? controller)?
        fetchBanner,
    TResult? Function(BuildContext context, int id)? fetchProduct,
    TResult? Function()? updateProduct,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(BuildContext context, bool? isRefresh,
            RefreshController? controller)?
        fetchBanner,
    TResult Function(BuildContext context, int id)? fetchProduct,
    TResult Function()? updateProduct,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(FetchBanner value) fetchBanner,
    required TResult Function(FetchProduct value) fetchProduct,
    required TResult Function(UpdateProduct value) updateProduct,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(FetchBanner value)? fetchBanner,
    TResult? Function(FetchProduct value)? fetchProduct,
    TResult? Function(UpdateProduct value)? updateProduct,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FetchBanner value)? fetchBanner,
    TResult Function(FetchProduct value)? fetchProduct,
    TResult Function(UpdateProduct value)? updateProduct,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BannerEventCopyWith<$Res> {
  factory $BannerEventCopyWith(
          BannerEvent value, $Res Function(BannerEvent) then) =
      _$BannerEventCopyWithImpl<$Res, BannerEvent>;
}

/// @nodoc
class _$BannerEventCopyWithImpl<$Res, $Val extends BannerEvent>
    implements $BannerEventCopyWith<$Res> {
  _$BannerEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BannerEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$FetchBannerImplCopyWith<$Res> {
  factory _$$FetchBannerImplCopyWith(
          _$FetchBannerImpl value, $Res Function(_$FetchBannerImpl) then) =
      __$$FetchBannerImplCopyWithImpl<$Res>;
  @useResult
  $Res call(
      {BuildContext context, bool? isRefresh, RefreshController? controller});
}

/// @nodoc
class __$$FetchBannerImplCopyWithImpl<$Res>
    extends _$BannerEventCopyWithImpl<$Res, _$FetchBannerImpl>
    implements _$$FetchBannerImplCopyWith<$Res> {
  __$$FetchBannerImplCopyWithImpl(
      _$FetchBannerImpl _value, $Res Function(_$FetchBannerImpl) _then)
      : super(_value, _then);

  /// Create a copy of BannerEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? context = null,
    Object? isRefresh = freezed,
    Object? controller = freezed,
  }) {
    return _then(_$FetchBannerImpl(
      context: null == context
          ? _value.context
          : context // ignore: cast_nullable_to_non_nullable
              as BuildContext,
      isRefresh: freezed == isRefresh
          ? _value.isRefresh
          : isRefresh // ignore: cast_nullable_to_non_nullable
              as bool?,
      controller: freezed == controller
          ? _value.controller
          : controller // ignore: cast_nullable_to_non_nullable
              as RefreshController?,
    ));
  }
}

/// @nodoc

class _$FetchBannerImpl implements FetchBanner {
  const _$FetchBannerImpl(
      {required this.context, this.isRefresh, this.controller});

  @override
  final BuildContext context;
  @override
  final bool? isRefresh;
  @override
  final RefreshController? controller;

  @override
  String toString() {
    return 'BannerEvent.fetchBanner(context: $context, isRefresh: $isRefresh, controller: $controller)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FetchBannerImpl &&
            (identical(other.context, context) || other.context == context) &&
            (identical(other.isRefresh, isRefresh) ||
                other.isRefresh == isRefresh) &&
            (identical(other.controller, controller) ||
                other.controller == controller));
  }

  @override
  int get hashCode => Object.hash(runtimeType, context, isRefresh, controller);

  /// Create a copy of BannerEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FetchBannerImplCopyWith<_$FetchBannerImpl> get copyWith =>
      __$$FetchBannerImplCopyWithImpl<_$FetchBannerImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(BuildContext context, bool? isRefresh,
            RefreshController? controller)
        fetchBanner,
    required TResult Function(BuildContext context, int id) fetchProduct,
    required TResult Function() updateProduct,
  }) {
    return fetchBanner(context, isRefresh, controller);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(BuildContext context, bool? isRefresh,
            RefreshController? controller)?
        fetchBanner,
    TResult? Function(BuildContext context, int id)? fetchProduct,
    TResult? Function()? updateProduct,
  }) {
    return fetchBanner?.call(context, isRefresh, controller);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(BuildContext context, bool? isRefresh,
            RefreshController? controller)?
        fetchBanner,
    TResult Function(BuildContext context, int id)? fetchProduct,
    TResult Function()? updateProduct,
    required TResult orElse(),
  }) {
    if (fetchBanner != null) {
      return fetchBanner(context, isRefresh, controller);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(FetchBanner value) fetchBanner,
    required TResult Function(FetchProduct value) fetchProduct,
    required TResult Function(UpdateProduct value) updateProduct,
  }) {
    return fetchBanner(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(FetchBanner value)? fetchBanner,
    TResult? Function(FetchProduct value)? fetchProduct,
    TResult? Function(UpdateProduct value)? updateProduct,
  }) {
    return fetchBanner?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FetchBanner value)? fetchBanner,
    TResult Function(FetchProduct value)? fetchProduct,
    TResult Function(UpdateProduct value)? updateProduct,
    required TResult orElse(),
  }) {
    if (fetchBanner != null) {
      return fetchBanner(this);
    }
    return orElse();
  }
}

abstract class FetchBanner implements BannerEvent {
  const factory FetchBanner(
      {required final BuildContext context,
      final bool? isRefresh,
      final RefreshController? controller}) = _$FetchBannerImpl;

  BuildContext get context;
  bool? get isRefresh;
  RefreshController? get controller;

  /// Create a copy of BannerEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FetchBannerImplCopyWith<_$FetchBannerImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$FetchProductImplCopyWith<$Res> {
  factory _$$FetchProductImplCopyWith(
          _$FetchProductImpl value, $Res Function(_$FetchProductImpl) then) =
      __$$FetchProductImplCopyWithImpl<$Res>;
  @useResult
  $Res call({BuildContext context, int id});
}

/// @nodoc
class __$$FetchProductImplCopyWithImpl<$Res>
    extends _$BannerEventCopyWithImpl<$Res, _$FetchProductImpl>
    implements _$$FetchProductImplCopyWith<$Res> {
  __$$FetchProductImplCopyWithImpl(
      _$FetchProductImpl _value, $Res Function(_$FetchProductImpl) _then)
      : super(_value, _then);

  /// Create a copy of BannerEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? context = null,
    Object? id = null,
  }) {
    return _then(_$FetchProductImpl(
      context: null == context
          ? _value.context
          : context // ignore: cast_nullable_to_non_nullable
              as BuildContext,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$FetchProductImpl implements FetchProduct {
  const _$FetchProductImpl({required this.context, required this.id});

  @override
  final BuildContext context;
  @override
  final int id;

  @override
  String toString() {
    return 'BannerEvent.fetchProduct(context: $context, id: $id)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FetchProductImpl &&
            (identical(other.context, context) || other.context == context) &&
            (identical(other.id, id) || other.id == id));
  }

  @override
  int get hashCode => Object.hash(runtimeType, context, id);

  /// Create a copy of BannerEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FetchProductImplCopyWith<_$FetchProductImpl> get copyWith =>
      __$$FetchProductImplCopyWithImpl<_$FetchProductImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(BuildContext context, bool? isRefresh,
            RefreshController? controller)
        fetchBanner,
    required TResult Function(BuildContext context, int id) fetchProduct,
    required TResult Function() updateProduct,
  }) {
    return fetchProduct(context, id);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(BuildContext context, bool? isRefresh,
            RefreshController? controller)?
        fetchBanner,
    TResult? Function(BuildContext context, int id)? fetchProduct,
    TResult? Function()? updateProduct,
  }) {
    return fetchProduct?.call(context, id);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(BuildContext context, bool? isRefresh,
            RefreshController? controller)?
        fetchBanner,
    TResult Function(BuildContext context, int id)? fetchProduct,
    TResult Function()? updateProduct,
    required TResult orElse(),
  }) {
    if (fetchProduct != null) {
      return fetchProduct(context, id);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(FetchBanner value) fetchBanner,
    required TResult Function(FetchProduct value) fetchProduct,
    required TResult Function(UpdateProduct value) updateProduct,
  }) {
    return fetchProduct(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(FetchBanner value)? fetchBanner,
    TResult? Function(FetchProduct value)? fetchProduct,
    TResult? Function(UpdateProduct value)? updateProduct,
  }) {
    return fetchProduct?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FetchBanner value)? fetchBanner,
    TResult Function(FetchProduct value)? fetchProduct,
    TResult Function(UpdateProduct value)? updateProduct,
    required TResult orElse(),
  }) {
    if (fetchProduct != null) {
      return fetchProduct(this);
    }
    return orElse();
  }
}

abstract class FetchProduct implements BannerEvent {
  const factory FetchProduct(
      {required final BuildContext context,
      required final int id}) = _$FetchProductImpl;

  BuildContext get context;
  int get id;

  /// Create a copy of BannerEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FetchProductImplCopyWith<_$FetchProductImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$UpdateProductImplCopyWith<$Res> {
  factory _$$UpdateProductImplCopyWith(
          _$UpdateProductImpl value, $Res Function(_$UpdateProductImpl) then) =
      __$$UpdateProductImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$UpdateProductImplCopyWithImpl<$Res>
    extends _$BannerEventCopyWithImpl<$Res, _$UpdateProductImpl>
    implements _$$UpdateProductImplCopyWith<$Res> {
  __$$UpdateProductImplCopyWithImpl(
      _$UpdateProductImpl _value, $Res Function(_$UpdateProductImpl) _then)
      : super(_value, _then);

  /// Create a copy of BannerEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$UpdateProductImpl implements UpdateProduct {
  const _$UpdateProductImpl();

  @override
  String toString() {
    return 'BannerEvent.updateProduct()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$UpdateProductImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(BuildContext context, bool? isRefresh,
            RefreshController? controller)
        fetchBanner,
    required TResult Function(BuildContext context, int id) fetchProduct,
    required TResult Function() updateProduct,
  }) {
    return updateProduct();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(BuildContext context, bool? isRefresh,
            RefreshController? controller)?
        fetchBanner,
    TResult? Function(BuildContext context, int id)? fetchProduct,
    TResult? Function()? updateProduct,
  }) {
    return updateProduct?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(BuildContext context, bool? isRefresh,
            RefreshController? controller)?
        fetchBanner,
    TResult Function(BuildContext context, int id)? fetchProduct,
    TResult Function()? updateProduct,
    required TResult orElse(),
  }) {
    if (updateProduct != null) {
      return updateProduct();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(FetchBanner value) fetchBanner,
    required TResult Function(FetchProduct value) fetchProduct,
    required TResult Function(UpdateProduct value) updateProduct,
  }) {
    return updateProduct(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(FetchBanner value)? fetchBanner,
    TResult? Function(FetchProduct value)? fetchProduct,
    TResult? Function(UpdateProduct value)? updateProduct,
  }) {
    return updateProduct?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FetchBanner value)? fetchBanner,
    TResult Function(FetchProduct value)? fetchProduct,
    TResult Function(UpdateProduct value)? updateProduct,
    required TResult orElse(),
  }) {
    if (updateProduct != null) {
      return updateProduct(this);
    }
    return orElse();
  }
}

abstract class UpdateProduct implements BannerEvent {
  const factory UpdateProduct() = _$UpdateProductImpl;
}

/// @nodoc
mixin _$BannerState {
  List<BannerData> get banners => throw _privateConstructorUsedError;
  List<ProductData> get products => throw _privateConstructorUsedError;
  bool get isLoadingBanner => throw _privateConstructorUsedError;
  bool get isLoadingProduct => throw _privateConstructorUsedError;

  /// Create a copy of BannerState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BannerStateCopyWith<BannerState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BannerStateCopyWith<$Res> {
  factory $BannerStateCopyWith(
          BannerState value, $Res Function(BannerState) then) =
      _$BannerStateCopyWithImpl<$Res, BannerState>;
  @useResult
  $Res call(
      {List<BannerData> banners,
      List<ProductData> products,
      bool isLoadingBanner,
      bool isLoadingProduct});
}

/// @nodoc
class _$BannerStateCopyWithImpl<$Res, $Val extends BannerState>
    implements $BannerStateCopyWith<$Res> {
  _$BannerStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BannerState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? banners = null,
    Object? products = null,
    Object? isLoadingBanner = null,
    Object? isLoadingProduct = null,
  }) {
    return _then(_value.copyWith(
      banners: null == banners
          ? _value.banners
          : banners // ignore: cast_nullable_to_non_nullable
              as List<BannerData>,
      products: null == products
          ? _value.products
          : products // ignore: cast_nullable_to_non_nullable
              as List<ProductData>,
      isLoadingBanner: null == isLoadingBanner
          ? _value.isLoadingBanner
          : isLoadingBanner // ignore: cast_nullable_to_non_nullable
              as bool,
      isLoadingProduct: null == isLoadingProduct
          ? _value.isLoadingProduct
          : isLoadingProduct // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BannerStateImplCopyWith<$Res>
    implements $BannerStateCopyWith<$Res> {
  factory _$$BannerStateImplCopyWith(
          _$BannerStateImpl value, $Res Function(_$BannerStateImpl) then) =
      __$$BannerStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<BannerData> banners,
      List<ProductData> products,
      bool isLoadingBanner,
      bool isLoadingProduct});
}

/// @nodoc
class __$$BannerStateImplCopyWithImpl<$Res>
    extends _$BannerStateCopyWithImpl<$Res, _$BannerStateImpl>
    implements _$$BannerStateImplCopyWith<$Res> {
  __$$BannerStateImplCopyWithImpl(
      _$BannerStateImpl _value, $Res Function(_$BannerStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of BannerState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? banners = null,
    Object? products = null,
    Object? isLoadingBanner = null,
    Object? isLoadingProduct = null,
  }) {
    return _then(_$BannerStateImpl(
      banners: null == banners
          ? _value._banners
          : banners // ignore: cast_nullable_to_non_nullable
              as List<BannerData>,
      products: null == products
          ? _value._products
          : products // ignore: cast_nullable_to_non_nullable
              as List<ProductData>,
      isLoadingBanner: null == isLoadingBanner
          ? _value.isLoadingBanner
          : isLoadingBanner // ignore: cast_nullable_to_non_nullable
              as bool,
      isLoadingProduct: null == isLoadingProduct
          ? _value.isLoadingProduct
          : isLoadingProduct // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$BannerStateImpl implements _BannerState {
  const _$BannerStateImpl(
      {final List<BannerData> banners = const [],
      final List<ProductData> products = const [],
      this.isLoadingBanner = true,
      this.isLoadingProduct = true})
      : _banners = banners,
        _products = products;

  final List<BannerData> _banners;
  @override
  @JsonKey()
  List<BannerData> get banners {
    if (_banners is EqualUnmodifiableListView) return _banners;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_banners);
  }

  final List<ProductData> _products;
  @override
  @JsonKey()
  List<ProductData> get products {
    if (_products is EqualUnmodifiableListView) return _products;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_products);
  }

  @override
  @JsonKey()
  final bool isLoadingBanner;
  @override
  @JsonKey()
  final bool isLoadingProduct;

  @override
  String toString() {
    return 'BannerState(banners: $banners, products: $products, isLoadingBanner: $isLoadingBanner, isLoadingProduct: $isLoadingProduct)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BannerStateImpl &&
            const DeepCollectionEquality().equals(other._banners, _banners) &&
            const DeepCollectionEquality().equals(other._products, _products) &&
            (identical(other.isLoadingBanner, isLoadingBanner) ||
                other.isLoadingBanner == isLoadingBanner) &&
            (identical(other.isLoadingProduct, isLoadingProduct) ||
                other.isLoadingProduct == isLoadingProduct));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_banners),
      const DeepCollectionEquality().hash(_products),
      isLoadingBanner,
      isLoadingProduct);

  /// Create a copy of BannerState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BannerStateImplCopyWith<_$BannerStateImpl> get copyWith =>
      __$$BannerStateImplCopyWithImpl<_$BannerStateImpl>(this, _$identity);
}

abstract class _BannerState implements BannerState {
  const factory _BannerState(
      {final List<BannerData> banners,
      final List<ProductData> products,
      final bool isLoadingBanner,
      final bool isLoadingProduct}) = _$BannerStateImpl;

  @override
  List<BannerData> get banners;
  @override
  List<ProductData> get products;
  @override
  bool get isLoadingBanner;
  @override
  bool get isLoadingProduct;

  /// Create a copy of BannerState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BannerStateImplCopyWith<_$BannerStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
