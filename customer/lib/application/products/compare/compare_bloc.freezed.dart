// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'compare_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$CompareEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(BuildContext context, bool? isRefresh,
            RefreshController? controller)
        fetchProducts,
    required TResult Function(List<ProductData> products) setExtraGroup,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(BuildContext context, bool? isRefresh,
            RefreshController? controller)?
        fetchProducts,
    TResult? Function(List<ProductData> products)? setExtraGroup,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(BuildContext context, bool? isRefresh,
            RefreshController? controller)?
        fetchProducts,
    TResult Function(List<ProductData> products)? setExtraGroup,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(FetchProducts value) fetchProducts,
    required TResult Function(SetExtraGroup value) setExtraGroup,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(FetchProducts value)? fetchProducts,
    TResult? Function(SetExtraGroup value)? setExtraGroup,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FetchProducts value)? fetchProducts,
    TResult Function(SetExtraGroup value)? setExtraGroup,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CompareEventCopyWith<$Res> {
  factory $CompareEventCopyWith(
          CompareEvent value, $Res Function(CompareEvent) then) =
      _$CompareEventCopyWithImpl<$Res, CompareEvent>;
}

/// @nodoc
class _$CompareEventCopyWithImpl<$Res, $Val extends CompareEvent>
    implements $CompareEventCopyWith<$Res> {
  _$CompareEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CompareEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$FetchProductsImplCopyWith<$Res> {
  factory _$$FetchProductsImplCopyWith(
          _$FetchProductsImpl value, $Res Function(_$FetchProductsImpl) then) =
      __$$FetchProductsImplCopyWithImpl<$Res>;
  @useResult
  $Res call(
      {BuildContext context, bool? isRefresh, RefreshController? controller});
}

/// @nodoc
class __$$FetchProductsImplCopyWithImpl<$Res>
    extends _$CompareEventCopyWithImpl<$Res, _$FetchProductsImpl>
    implements _$$FetchProductsImplCopyWith<$Res> {
  __$$FetchProductsImplCopyWithImpl(
      _$FetchProductsImpl _value, $Res Function(_$FetchProductsImpl) _then)
      : super(_value, _then);

  /// Create a copy of CompareEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? context = null,
    Object? isRefresh = freezed,
    Object? controller = freezed,
  }) {
    return _then(_$FetchProductsImpl(
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

class _$FetchProductsImpl implements FetchProducts {
  const _$FetchProductsImpl(
      {required this.context, this.isRefresh, this.controller});

  @override
  final BuildContext context;
  @override
  final bool? isRefresh;
  @override
  final RefreshController? controller;

  @override
  String toString() {
    return 'CompareEvent.fetchProducts(context: $context, isRefresh: $isRefresh, controller: $controller)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FetchProductsImpl &&
            (identical(other.context, context) || other.context == context) &&
            (identical(other.isRefresh, isRefresh) ||
                other.isRefresh == isRefresh) &&
            (identical(other.controller, controller) ||
                other.controller == controller));
  }

  @override
  int get hashCode => Object.hash(runtimeType, context, isRefresh, controller);

  /// Create a copy of CompareEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FetchProductsImplCopyWith<_$FetchProductsImpl> get copyWith =>
      __$$FetchProductsImplCopyWithImpl<_$FetchProductsImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(BuildContext context, bool? isRefresh,
            RefreshController? controller)
        fetchProducts,
    required TResult Function(List<ProductData> products) setExtraGroup,
  }) {
    return fetchProducts(context, isRefresh, controller);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(BuildContext context, bool? isRefresh,
            RefreshController? controller)?
        fetchProducts,
    TResult? Function(List<ProductData> products)? setExtraGroup,
  }) {
    return fetchProducts?.call(context, isRefresh, controller);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(BuildContext context, bool? isRefresh,
            RefreshController? controller)?
        fetchProducts,
    TResult Function(List<ProductData> products)? setExtraGroup,
    required TResult orElse(),
  }) {
    if (fetchProducts != null) {
      return fetchProducts(context, isRefresh, controller);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(FetchProducts value) fetchProducts,
    required TResult Function(SetExtraGroup value) setExtraGroup,
  }) {
    return fetchProducts(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(FetchProducts value)? fetchProducts,
    TResult? Function(SetExtraGroup value)? setExtraGroup,
  }) {
    return fetchProducts?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FetchProducts value)? fetchProducts,
    TResult Function(SetExtraGroup value)? setExtraGroup,
    required TResult orElse(),
  }) {
    if (fetchProducts != null) {
      return fetchProducts(this);
    }
    return orElse();
  }
}

abstract class FetchProducts implements CompareEvent {
  const factory FetchProducts(
      {required final BuildContext context,
      final bool? isRefresh,
      final RefreshController? controller}) = _$FetchProductsImpl;

  BuildContext get context;
  bool? get isRefresh;
  RefreshController? get controller;

  /// Create a copy of CompareEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FetchProductsImplCopyWith<_$FetchProductsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SetExtraGroupImplCopyWith<$Res> {
  factory _$$SetExtraGroupImplCopyWith(
          _$SetExtraGroupImpl value, $Res Function(_$SetExtraGroupImpl) then) =
      __$$SetExtraGroupImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<ProductData> products});
}

/// @nodoc
class __$$SetExtraGroupImplCopyWithImpl<$Res>
    extends _$CompareEventCopyWithImpl<$Res, _$SetExtraGroupImpl>
    implements _$$SetExtraGroupImplCopyWith<$Res> {
  __$$SetExtraGroupImplCopyWithImpl(
      _$SetExtraGroupImpl _value, $Res Function(_$SetExtraGroupImpl) _then)
      : super(_value, _then);

  /// Create a copy of CompareEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? products = null,
  }) {
    return _then(_$SetExtraGroupImpl(
      products: null == products
          ? _value._products
          : products // ignore: cast_nullable_to_non_nullable
              as List<ProductData>,
    ));
  }
}

/// @nodoc

class _$SetExtraGroupImpl implements SetExtraGroup {
  const _$SetExtraGroupImpl({required final List<ProductData> products})
      : _products = products;

  final List<ProductData> _products;
  @override
  List<ProductData> get products {
    if (_products is EqualUnmodifiableListView) return _products;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_products);
  }

  @override
  String toString() {
    return 'CompareEvent.setExtraGroup(products: $products)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SetExtraGroupImpl &&
            const DeepCollectionEquality().equals(other._products, _products));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_products));

  /// Create a copy of CompareEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SetExtraGroupImplCopyWith<_$SetExtraGroupImpl> get copyWith =>
      __$$SetExtraGroupImplCopyWithImpl<_$SetExtraGroupImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(BuildContext context, bool? isRefresh,
            RefreshController? controller)
        fetchProducts,
    required TResult Function(List<ProductData> products) setExtraGroup,
  }) {
    return setExtraGroup(products);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(BuildContext context, bool? isRefresh,
            RefreshController? controller)?
        fetchProducts,
    TResult? Function(List<ProductData> products)? setExtraGroup,
  }) {
    return setExtraGroup?.call(products);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(BuildContext context, bool? isRefresh,
            RefreshController? controller)?
        fetchProducts,
    TResult Function(List<ProductData> products)? setExtraGroup,
    required TResult orElse(),
  }) {
    if (setExtraGroup != null) {
      return setExtraGroup(products);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(FetchProducts value) fetchProducts,
    required TResult Function(SetExtraGroup value) setExtraGroup,
  }) {
    return setExtraGroup(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(FetchProducts value)? fetchProducts,
    TResult? Function(SetExtraGroup value)? setExtraGroup,
  }) {
    return setExtraGroup?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FetchProducts value)? fetchProducts,
    TResult Function(SetExtraGroup value)? setExtraGroup,
    required TResult orElse(),
  }) {
    if (setExtraGroup != null) {
      return setExtraGroup(this);
    }
    return orElse();
  }
}

abstract class SetExtraGroup implements CompareEvent {
  const factory SetExtraGroup({required final List<ProductData> products}) =
      _$SetExtraGroupImpl;

  List<ProductData> get products;

  /// Create a copy of CompareEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SetExtraGroupImplCopyWith<_$SetExtraGroupImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$CompareState {
  bool get isLoading => throw _privateConstructorUsedError;
  List<List<ProductData>> get compare => throw _privateConstructorUsedError;
  List<AttributesData> get attributes => throw _privateConstructorUsedError;

  /// Create a copy of CompareState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CompareStateCopyWith<CompareState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CompareStateCopyWith<$Res> {
  factory $CompareStateCopyWith(
          CompareState value, $Res Function(CompareState) then) =
      _$CompareStateCopyWithImpl<$Res, CompareState>;
  @useResult
  $Res call(
      {bool isLoading,
      List<List<ProductData>> compare,
      List<AttributesData> attributes});
}

/// @nodoc
class _$CompareStateCopyWithImpl<$Res, $Val extends CompareState>
    implements $CompareStateCopyWith<$Res> {
  _$CompareStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CompareState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? compare = null,
    Object? attributes = null,
  }) {
    return _then(_value.copyWith(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      compare: null == compare
          ? _value.compare
          : compare // ignore: cast_nullable_to_non_nullable
              as List<List<ProductData>>,
      attributes: null == attributes
          ? _value.attributes
          : attributes // ignore: cast_nullable_to_non_nullable
              as List<AttributesData>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CompareStateImplCopyWith<$Res>
    implements $CompareStateCopyWith<$Res> {
  factory _$$CompareStateImplCopyWith(
          _$CompareStateImpl value, $Res Function(_$CompareStateImpl) then) =
      __$$CompareStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool isLoading,
      List<List<ProductData>> compare,
      List<AttributesData> attributes});
}

/// @nodoc
class __$$CompareStateImplCopyWithImpl<$Res>
    extends _$CompareStateCopyWithImpl<$Res, _$CompareStateImpl>
    implements _$$CompareStateImplCopyWith<$Res> {
  __$$CompareStateImplCopyWithImpl(
      _$CompareStateImpl _value, $Res Function(_$CompareStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of CompareState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? compare = null,
    Object? attributes = null,
  }) {
    return _then(_$CompareStateImpl(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      compare: null == compare
          ? _value._compare
          : compare // ignore: cast_nullable_to_non_nullable
              as List<List<ProductData>>,
      attributes: null == attributes
          ? _value._attributes
          : attributes // ignore: cast_nullable_to_non_nullable
              as List<AttributesData>,
    ));
  }
}

/// @nodoc

class _$CompareStateImpl implements _CompareState {
  const _$CompareStateImpl(
      {this.isLoading = false,
      final List<List<ProductData>> compare = const [],
      final List<AttributesData> attributes = const []})
      : _compare = compare,
        _attributes = attributes;

  @override
  @JsonKey()
  final bool isLoading;
  final List<List<ProductData>> _compare;
  @override
  @JsonKey()
  List<List<ProductData>> get compare {
    if (_compare is EqualUnmodifiableListView) return _compare;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_compare);
  }

  final List<AttributesData> _attributes;
  @override
  @JsonKey()
  List<AttributesData> get attributes {
    if (_attributes is EqualUnmodifiableListView) return _attributes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_attributes);
  }

  @override
  String toString() {
    return 'CompareState(isLoading: $isLoading, compare: $compare, attributes: $attributes)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CompareStateImpl &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            const DeepCollectionEquality().equals(other._compare, _compare) &&
            const DeepCollectionEquality()
                .equals(other._attributes, _attributes));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      isLoading,
      const DeepCollectionEquality().hash(_compare),
      const DeepCollectionEquality().hash(_attributes));

  /// Create a copy of CompareState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CompareStateImplCopyWith<_$CompareStateImpl> get copyWith =>
      __$$CompareStateImplCopyWithImpl<_$CompareStateImpl>(this, _$identity);
}

abstract class _CompareState implements CompareState {
  const factory _CompareState(
      {final bool isLoading,
      final List<List<ProductData>> compare,
      final List<AttributesData> attributes}) = _$CompareStateImpl;

  @override
  bool get isLoading;
  @override
  List<List<ProductData>> get compare;
  @override
  List<AttributesData> get attributes;

  /// Create a copy of CompareState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CompareStateImplCopyWith<_$CompareStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
