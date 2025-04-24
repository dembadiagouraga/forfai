// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_product_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$UserProductEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(BuildContext context, bool? isRefresh,
            RefreshController? controller)
        fetchActiveProduct,
    required TResult Function(BuildContext context, bool? isRefresh,
            RefreshController? controller)
        fetchUnActiveProduct,
    required TResult Function(BuildContext context, bool? isRefresh,
            RefreshController? controller)
        fetchWaitingProduct,
    required TResult Function(
            BuildContext context, ProductData? product, bool? help)
        changeActivate,
    required TResult Function(BuildContext context, ProductData? product)
        deleteProduct,
    required TResult Function() updateState,
    required TResult Function(int index) setIndex,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(BuildContext context, bool? isRefresh,
            RefreshController? controller)?
        fetchActiveProduct,
    TResult? Function(BuildContext context, bool? isRefresh,
            RefreshController? controller)?
        fetchUnActiveProduct,
    TResult? Function(BuildContext context, bool? isRefresh,
            RefreshController? controller)?
        fetchWaitingProduct,
    TResult? Function(BuildContext context, ProductData? product, bool? help)?
        changeActivate,
    TResult? Function(BuildContext context, ProductData? product)?
        deleteProduct,
    TResult? Function()? updateState,
    TResult? Function(int index)? setIndex,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(BuildContext context, bool? isRefresh,
            RefreshController? controller)?
        fetchActiveProduct,
    TResult Function(BuildContext context, bool? isRefresh,
            RefreshController? controller)?
        fetchUnActiveProduct,
    TResult Function(BuildContext context, bool? isRefresh,
            RefreshController? controller)?
        fetchWaitingProduct,
    TResult Function(BuildContext context, ProductData? product, bool? help)?
        changeActivate,
    TResult Function(BuildContext context, ProductData? product)? deleteProduct,
    TResult Function()? updateState,
    TResult Function(int index)? setIndex,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(FetchActiveProduct value) fetchActiveProduct,
    required TResult Function(FetchUnActiveProduct value) fetchUnActiveProduct,
    required TResult Function(FetchWaitingProduct value) fetchWaitingProduct,
    required TResult Function(ChangeActivate value) changeActivate,
    required TResult Function(DeleteProduct value) deleteProduct,
    required TResult Function(UpdateState value) updateState,
    required TResult Function(SetIndex value) setIndex,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(FetchActiveProduct value)? fetchActiveProduct,
    TResult? Function(FetchUnActiveProduct value)? fetchUnActiveProduct,
    TResult? Function(FetchWaitingProduct value)? fetchWaitingProduct,
    TResult? Function(ChangeActivate value)? changeActivate,
    TResult? Function(DeleteProduct value)? deleteProduct,
    TResult? Function(UpdateState value)? updateState,
    TResult? Function(SetIndex value)? setIndex,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FetchActiveProduct value)? fetchActiveProduct,
    TResult Function(FetchUnActiveProduct value)? fetchUnActiveProduct,
    TResult Function(FetchWaitingProduct value)? fetchWaitingProduct,
    TResult Function(ChangeActivate value)? changeActivate,
    TResult Function(DeleteProduct value)? deleteProduct,
    TResult Function(UpdateState value)? updateState,
    TResult Function(SetIndex value)? setIndex,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserProductEventCopyWith<$Res> {
  factory $UserProductEventCopyWith(
          UserProductEvent value, $Res Function(UserProductEvent) then) =
      _$UserProductEventCopyWithImpl<$Res, UserProductEvent>;
}

/// @nodoc
class _$UserProductEventCopyWithImpl<$Res, $Val extends UserProductEvent>
    implements $UserProductEventCopyWith<$Res> {
  _$UserProductEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserProductEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$FetchActiveProductImplCopyWith<$Res> {
  factory _$$FetchActiveProductImplCopyWith(_$FetchActiveProductImpl value,
          $Res Function(_$FetchActiveProductImpl) then) =
      __$$FetchActiveProductImplCopyWithImpl<$Res>;
  @useResult
  $Res call(
      {BuildContext context, bool? isRefresh, RefreshController? controller});
}

/// @nodoc
class __$$FetchActiveProductImplCopyWithImpl<$Res>
    extends _$UserProductEventCopyWithImpl<$Res, _$FetchActiveProductImpl>
    implements _$$FetchActiveProductImplCopyWith<$Res> {
  __$$FetchActiveProductImplCopyWithImpl(_$FetchActiveProductImpl _value,
      $Res Function(_$FetchActiveProductImpl) _then)
      : super(_value, _then);

  /// Create a copy of UserProductEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? context = null,
    Object? isRefresh = freezed,
    Object? controller = freezed,
  }) {
    return _then(_$FetchActiveProductImpl(
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

class _$FetchActiveProductImpl implements FetchActiveProduct {
  const _$FetchActiveProductImpl(
      {required this.context, this.isRefresh, this.controller});

  @override
  final BuildContext context;
  @override
  final bool? isRefresh;
  @override
  final RefreshController? controller;

  @override
  String toString() {
    return 'UserProductEvent.fetchActiveProduct(context: $context, isRefresh: $isRefresh, controller: $controller)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FetchActiveProductImpl &&
            (identical(other.context, context) || other.context == context) &&
            (identical(other.isRefresh, isRefresh) ||
                other.isRefresh == isRefresh) &&
            (identical(other.controller, controller) ||
                other.controller == controller));
  }

  @override
  int get hashCode => Object.hash(runtimeType, context, isRefresh, controller);

  /// Create a copy of UserProductEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FetchActiveProductImplCopyWith<_$FetchActiveProductImpl> get copyWith =>
      __$$FetchActiveProductImplCopyWithImpl<_$FetchActiveProductImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(BuildContext context, bool? isRefresh,
            RefreshController? controller)
        fetchActiveProduct,
    required TResult Function(BuildContext context, bool? isRefresh,
            RefreshController? controller)
        fetchUnActiveProduct,
    required TResult Function(BuildContext context, bool? isRefresh,
            RefreshController? controller)
        fetchWaitingProduct,
    required TResult Function(
            BuildContext context, ProductData? product, bool? help)
        changeActivate,
    required TResult Function(BuildContext context, ProductData? product)
        deleteProduct,
    required TResult Function() updateState,
    required TResult Function(int index) setIndex,
  }) {
    return fetchActiveProduct(context, isRefresh, controller);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(BuildContext context, bool? isRefresh,
            RefreshController? controller)?
        fetchActiveProduct,
    TResult? Function(BuildContext context, bool? isRefresh,
            RefreshController? controller)?
        fetchUnActiveProduct,
    TResult? Function(BuildContext context, bool? isRefresh,
            RefreshController? controller)?
        fetchWaitingProduct,
    TResult? Function(BuildContext context, ProductData? product, bool? help)?
        changeActivate,
    TResult? Function(BuildContext context, ProductData? product)?
        deleteProduct,
    TResult? Function()? updateState,
    TResult? Function(int index)? setIndex,
  }) {
    return fetchActiveProduct?.call(context, isRefresh, controller);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(BuildContext context, bool? isRefresh,
            RefreshController? controller)?
        fetchActiveProduct,
    TResult Function(BuildContext context, bool? isRefresh,
            RefreshController? controller)?
        fetchUnActiveProduct,
    TResult Function(BuildContext context, bool? isRefresh,
            RefreshController? controller)?
        fetchWaitingProduct,
    TResult Function(BuildContext context, ProductData? product, bool? help)?
        changeActivate,
    TResult Function(BuildContext context, ProductData? product)? deleteProduct,
    TResult Function()? updateState,
    TResult Function(int index)? setIndex,
    required TResult orElse(),
  }) {
    if (fetchActiveProduct != null) {
      return fetchActiveProduct(context, isRefresh, controller);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(FetchActiveProduct value) fetchActiveProduct,
    required TResult Function(FetchUnActiveProduct value) fetchUnActiveProduct,
    required TResult Function(FetchWaitingProduct value) fetchWaitingProduct,
    required TResult Function(ChangeActivate value) changeActivate,
    required TResult Function(DeleteProduct value) deleteProduct,
    required TResult Function(UpdateState value) updateState,
    required TResult Function(SetIndex value) setIndex,
  }) {
    return fetchActiveProduct(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(FetchActiveProduct value)? fetchActiveProduct,
    TResult? Function(FetchUnActiveProduct value)? fetchUnActiveProduct,
    TResult? Function(FetchWaitingProduct value)? fetchWaitingProduct,
    TResult? Function(ChangeActivate value)? changeActivate,
    TResult? Function(DeleteProduct value)? deleteProduct,
    TResult? Function(UpdateState value)? updateState,
    TResult? Function(SetIndex value)? setIndex,
  }) {
    return fetchActiveProduct?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FetchActiveProduct value)? fetchActiveProduct,
    TResult Function(FetchUnActiveProduct value)? fetchUnActiveProduct,
    TResult Function(FetchWaitingProduct value)? fetchWaitingProduct,
    TResult Function(ChangeActivate value)? changeActivate,
    TResult Function(DeleteProduct value)? deleteProduct,
    TResult Function(UpdateState value)? updateState,
    TResult Function(SetIndex value)? setIndex,
    required TResult orElse(),
  }) {
    if (fetchActiveProduct != null) {
      return fetchActiveProduct(this);
    }
    return orElse();
  }
}

abstract class FetchActiveProduct implements UserProductEvent {
  const factory FetchActiveProduct(
      {required final BuildContext context,
      final bool? isRefresh,
      final RefreshController? controller}) = _$FetchActiveProductImpl;

  BuildContext get context;
  bool? get isRefresh;
  RefreshController? get controller;

  /// Create a copy of UserProductEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FetchActiveProductImplCopyWith<_$FetchActiveProductImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$FetchUnActiveProductImplCopyWith<$Res> {
  factory _$$FetchUnActiveProductImplCopyWith(_$FetchUnActiveProductImpl value,
          $Res Function(_$FetchUnActiveProductImpl) then) =
      __$$FetchUnActiveProductImplCopyWithImpl<$Res>;
  @useResult
  $Res call(
      {BuildContext context, bool? isRefresh, RefreshController? controller});
}

/// @nodoc
class __$$FetchUnActiveProductImplCopyWithImpl<$Res>
    extends _$UserProductEventCopyWithImpl<$Res, _$FetchUnActiveProductImpl>
    implements _$$FetchUnActiveProductImplCopyWith<$Res> {
  __$$FetchUnActiveProductImplCopyWithImpl(_$FetchUnActiveProductImpl _value,
      $Res Function(_$FetchUnActiveProductImpl) _then)
      : super(_value, _then);

  /// Create a copy of UserProductEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? context = null,
    Object? isRefresh = freezed,
    Object? controller = freezed,
  }) {
    return _then(_$FetchUnActiveProductImpl(
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

class _$FetchUnActiveProductImpl implements FetchUnActiveProduct {
  const _$FetchUnActiveProductImpl(
      {required this.context, this.isRefresh, this.controller});

  @override
  final BuildContext context;
  @override
  final bool? isRefresh;
  @override
  final RefreshController? controller;

  @override
  String toString() {
    return 'UserProductEvent.fetchUnActiveProduct(context: $context, isRefresh: $isRefresh, controller: $controller)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FetchUnActiveProductImpl &&
            (identical(other.context, context) || other.context == context) &&
            (identical(other.isRefresh, isRefresh) ||
                other.isRefresh == isRefresh) &&
            (identical(other.controller, controller) ||
                other.controller == controller));
  }

  @override
  int get hashCode => Object.hash(runtimeType, context, isRefresh, controller);

  /// Create a copy of UserProductEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FetchUnActiveProductImplCopyWith<_$FetchUnActiveProductImpl>
      get copyWith =>
          __$$FetchUnActiveProductImplCopyWithImpl<_$FetchUnActiveProductImpl>(
              this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(BuildContext context, bool? isRefresh,
            RefreshController? controller)
        fetchActiveProduct,
    required TResult Function(BuildContext context, bool? isRefresh,
            RefreshController? controller)
        fetchUnActiveProduct,
    required TResult Function(BuildContext context, bool? isRefresh,
            RefreshController? controller)
        fetchWaitingProduct,
    required TResult Function(
            BuildContext context, ProductData? product, bool? help)
        changeActivate,
    required TResult Function(BuildContext context, ProductData? product)
        deleteProduct,
    required TResult Function() updateState,
    required TResult Function(int index) setIndex,
  }) {
    return fetchUnActiveProduct(context, isRefresh, controller);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(BuildContext context, bool? isRefresh,
            RefreshController? controller)?
        fetchActiveProduct,
    TResult? Function(BuildContext context, bool? isRefresh,
            RefreshController? controller)?
        fetchUnActiveProduct,
    TResult? Function(BuildContext context, bool? isRefresh,
            RefreshController? controller)?
        fetchWaitingProduct,
    TResult? Function(BuildContext context, ProductData? product, bool? help)?
        changeActivate,
    TResult? Function(BuildContext context, ProductData? product)?
        deleteProduct,
    TResult? Function()? updateState,
    TResult? Function(int index)? setIndex,
  }) {
    return fetchUnActiveProduct?.call(context, isRefresh, controller);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(BuildContext context, bool? isRefresh,
            RefreshController? controller)?
        fetchActiveProduct,
    TResult Function(BuildContext context, bool? isRefresh,
            RefreshController? controller)?
        fetchUnActiveProduct,
    TResult Function(BuildContext context, bool? isRefresh,
            RefreshController? controller)?
        fetchWaitingProduct,
    TResult Function(BuildContext context, ProductData? product, bool? help)?
        changeActivate,
    TResult Function(BuildContext context, ProductData? product)? deleteProduct,
    TResult Function()? updateState,
    TResult Function(int index)? setIndex,
    required TResult orElse(),
  }) {
    if (fetchUnActiveProduct != null) {
      return fetchUnActiveProduct(context, isRefresh, controller);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(FetchActiveProduct value) fetchActiveProduct,
    required TResult Function(FetchUnActiveProduct value) fetchUnActiveProduct,
    required TResult Function(FetchWaitingProduct value) fetchWaitingProduct,
    required TResult Function(ChangeActivate value) changeActivate,
    required TResult Function(DeleteProduct value) deleteProduct,
    required TResult Function(UpdateState value) updateState,
    required TResult Function(SetIndex value) setIndex,
  }) {
    return fetchUnActiveProduct(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(FetchActiveProduct value)? fetchActiveProduct,
    TResult? Function(FetchUnActiveProduct value)? fetchUnActiveProduct,
    TResult? Function(FetchWaitingProduct value)? fetchWaitingProduct,
    TResult? Function(ChangeActivate value)? changeActivate,
    TResult? Function(DeleteProduct value)? deleteProduct,
    TResult? Function(UpdateState value)? updateState,
    TResult? Function(SetIndex value)? setIndex,
  }) {
    return fetchUnActiveProduct?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FetchActiveProduct value)? fetchActiveProduct,
    TResult Function(FetchUnActiveProduct value)? fetchUnActiveProduct,
    TResult Function(FetchWaitingProduct value)? fetchWaitingProduct,
    TResult Function(ChangeActivate value)? changeActivate,
    TResult Function(DeleteProduct value)? deleteProduct,
    TResult Function(UpdateState value)? updateState,
    TResult Function(SetIndex value)? setIndex,
    required TResult orElse(),
  }) {
    if (fetchUnActiveProduct != null) {
      return fetchUnActiveProduct(this);
    }
    return orElse();
  }
}

abstract class FetchUnActiveProduct implements UserProductEvent {
  const factory FetchUnActiveProduct(
      {required final BuildContext context,
      final bool? isRefresh,
      final RefreshController? controller}) = _$FetchUnActiveProductImpl;

  BuildContext get context;
  bool? get isRefresh;
  RefreshController? get controller;

  /// Create a copy of UserProductEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FetchUnActiveProductImplCopyWith<_$FetchUnActiveProductImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$FetchWaitingProductImplCopyWith<$Res> {
  factory _$$FetchWaitingProductImplCopyWith(_$FetchWaitingProductImpl value,
          $Res Function(_$FetchWaitingProductImpl) then) =
      __$$FetchWaitingProductImplCopyWithImpl<$Res>;
  @useResult
  $Res call(
      {BuildContext context, bool? isRefresh, RefreshController? controller});
}

/// @nodoc
class __$$FetchWaitingProductImplCopyWithImpl<$Res>
    extends _$UserProductEventCopyWithImpl<$Res, _$FetchWaitingProductImpl>
    implements _$$FetchWaitingProductImplCopyWith<$Res> {
  __$$FetchWaitingProductImplCopyWithImpl(_$FetchWaitingProductImpl _value,
      $Res Function(_$FetchWaitingProductImpl) _then)
      : super(_value, _then);

  /// Create a copy of UserProductEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? context = null,
    Object? isRefresh = freezed,
    Object? controller = freezed,
  }) {
    return _then(_$FetchWaitingProductImpl(
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

class _$FetchWaitingProductImpl implements FetchWaitingProduct {
  const _$FetchWaitingProductImpl(
      {required this.context, this.isRefresh, this.controller});

  @override
  final BuildContext context;
  @override
  final bool? isRefresh;
  @override
  final RefreshController? controller;

  @override
  String toString() {
    return 'UserProductEvent.fetchWaitingProduct(context: $context, isRefresh: $isRefresh, controller: $controller)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FetchWaitingProductImpl &&
            (identical(other.context, context) || other.context == context) &&
            (identical(other.isRefresh, isRefresh) ||
                other.isRefresh == isRefresh) &&
            (identical(other.controller, controller) ||
                other.controller == controller));
  }

  @override
  int get hashCode => Object.hash(runtimeType, context, isRefresh, controller);

  /// Create a copy of UserProductEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FetchWaitingProductImplCopyWith<_$FetchWaitingProductImpl> get copyWith =>
      __$$FetchWaitingProductImplCopyWithImpl<_$FetchWaitingProductImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(BuildContext context, bool? isRefresh,
            RefreshController? controller)
        fetchActiveProduct,
    required TResult Function(BuildContext context, bool? isRefresh,
            RefreshController? controller)
        fetchUnActiveProduct,
    required TResult Function(BuildContext context, bool? isRefresh,
            RefreshController? controller)
        fetchWaitingProduct,
    required TResult Function(
            BuildContext context, ProductData? product, bool? help)
        changeActivate,
    required TResult Function(BuildContext context, ProductData? product)
        deleteProduct,
    required TResult Function() updateState,
    required TResult Function(int index) setIndex,
  }) {
    return fetchWaitingProduct(context, isRefresh, controller);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(BuildContext context, bool? isRefresh,
            RefreshController? controller)?
        fetchActiveProduct,
    TResult? Function(BuildContext context, bool? isRefresh,
            RefreshController? controller)?
        fetchUnActiveProduct,
    TResult? Function(BuildContext context, bool? isRefresh,
            RefreshController? controller)?
        fetchWaitingProduct,
    TResult? Function(BuildContext context, ProductData? product, bool? help)?
        changeActivate,
    TResult? Function(BuildContext context, ProductData? product)?
        deleteProduct,
    TResult? Function()? updateState,
    TResult? Function(int index)? setIndex,
  }) {
    return fetchWaitingProduct?.call(context, isRefresh, controller);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(BuildContext context, bool? isRefresh,
            RefreshController? controller)?
        fetchActiveProduct,
    TResult Function(BuildContext context, bool? isRefresh,
            RefreshController? controller)?
        fetchUnActiveProduct,
    TResult Function(BuildContext context, bool? isRefresh,
            RefreshController? controller)?
        fetchWaitingProduct,
    TResult Function(BuildContext context, ProductData? product, bool? help)?
        changeActivate,
    TResult Function(BuildContext context, ProductData? product)? deleteProduct,
    TResult Function()? updateState,
    TResult Function(int index)? setIndex,
    required TResult orElse(),
  }) {
    if (fetchWaitingProduct != null) {
      return fetchWaitingProduct(context, isRefresh, controller);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(FetchActiveProduct value) fetchActiveProduct,
    required TResult Function(FetchUnActiveProduct value) fetchUnActiveProduct,
    required TResult Function(FetchWaitingProduct value) fetchWaitingProduct,
    required TResult Function(ChangeActivate value) changeActivate,
    required TResult Function(DeleteProduct value) deleteProduct,
    required TResult Function(UpdateState value) updateState,
    required TResult Function(SetIndex value) setIndex,
  }) {
    return fetchWaitingProduct(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(FetchActiveProduct value)? fetchActiveProduct,
    TResult? Function(FetchUnActiveProduct value)? fetchUnActiveProduct,
    TResult? Function(FetchWaitingProduct value)? fetchWaitingProduct,
    TResult? Function(ChangeActivate value)? changeActivate,
    TResult? Function(DeleteProduct value)? deleteProduct,
    TResult? Function(UpdateState value)? updateState,
    TResult? Function(SetIndex value)? setIndex,
  }) {
    return fetchWaitingProduct?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FetchActiveProduct value)? fetchActiveProduct,
    TResult Function(FetchUnActiveProduct value)? fetchUnActiveProduct,
    TResult Function(FetchWaitingProduct value)? fetchWaitingProduct,
    TResult Function(ChangeActivate value)? changeActivate,
    TResult Function(DeleteProduct value)? deleteProduct,
    TResult Function(UpdateState value)? updateState,
    TResult Function(SetIndex value)? setIndex,
    required TResult orElse(),
  }) {
    if (fetchWaitingProduct != null) {
      return fetchWaitingProduct(this);
    }
    return orElse();
  }
}

abstract class FetchWaitingProduct implements UserProductEvent {
  const factory FetchWaitingProduct(
      {required final BuildContext context,
      final bool? isRefresh,
      final RefreshController? controller}) = _$FetchWaitingProductImpl;

  BuildContext get context;
  bool? get isRefresh;
  RefreshController? get controller;

  /// Create a copy of UserProductEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FetchWaitingProductImplCopyWith<_$FetchWaitingProductImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ChangeActivateImplCopyWith<$Res> {
  factory _$$ChangeActivateImplCopyWith(_$ChangeActivateImpl value,
          $Res Function(_$ChangeActivateImpl) then) =
      __$$ChangeActivateImplCopyWithImpl<$Res>;
  @useResult
  $Res call({BuildContext context, ProductData? product, bool? help});
}

/// @nodoc
class __$$ChangeActivateImplCopyWithImpl<$Res>
    extends _$UserProductEventCopyWithImpl<$Res, _$ChangeActivateImpl>
    implements _$$ChangeActivateImplCopyWith<$Res> {
  __$$ChangeActivateImplCopyWithImpl(
      _$ChangeActivateImpl _value, $Res Function(_$ChangeActivateImpl) _then)
      : super(_value, _then);

  /// Create a copy of UserProductEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? context = null,
    Object? product = freezed,
    Object? help = freezed,
  }) {
    return _then(_$ChangeActivateImpl(
      context: null == context
          ? _value.context
          : context // ignore: cast_nullable_to_non_nullable
              as BuildContext,
      product: freezed == product
          ? _value.product
          : product // ignore: cast_nullable_to_non_nullable
              as ProductData?,
      help: freezed == help
          ? _value.help
          : help // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc

class _$ChangeActivateImpl implements ChangeActivate {
  const _$ChangeActivateImpl({required this.context, this.product, this.help});

  @override
  final BuildContext context;
  @override
  final ProductData? product;
  @override
  final bool? help;

  @override
  String toString() {
    return 'UserProductEvent.changeActivate(context: $context, product: $product, help: $help)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChangeActivateImpl &&
            (identical(other.context, context) || other.context == context) &&
            (identical(other.product, product) || other.product == product) &&
            (identical(other.help, help) || other.help == help));
  }

  @override
  int get hashCode => Object.hash(runtimeType, context, product, help);

  /// Create a copy of UserProductEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ChangeActivateImplCopyWith<_$ChangeActivateImpl> get copyWith =>
      __$$ChangeActivateImplCopyWithImpl<_$ChangeActivateImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(BuildContext context, bool? isRefresh,
            RefreshController? controller)
        fetchActiveProduct,
    required TResult Function(BuildContext context, bool? isRefresh,
            RefreshController? controller)
        fetchUnActiveProduct,
    required TResult Function(BuildContext context, bool? isRefresh,
            RefreshController? controller)
        fetchWaitingProduct,
    required TResult Function(
            BuildContext context, ProductData? product, bool? help)
        changeActivate,
    required TResult Function(BuildContext context, ProductData? product)
        deleteProduct,
    required TResult Function() updateState,
    required TResult Function(int index) setIndex,
  }) {
    return changeActivate(context, product, help);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(BuildContext context, bool? isRefresh,
            RefreshController? controller)?
        fetchActiveProduct,
    TResult? Function(BuildContext context, bool? isRefresh,
            RefreshController? controller)?
        fetchUnActiveProduct,
    TResult? Function(BuildContext context, bool? isRefresh,
            RefreshController? controller)?
        fetchWaitingProduct,
    TResult? Function(BuildContext context, ProductData? product, bool? help)?
        changeActivate,
    TResult? Function(BuildContext context, ProductData? product)?
        deleteProduct,
    TResult? Function()? updateState,
    TResult? Function(int index)? setIndex,
  }) {
    return changeActivate?.call(context, product, help);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(BuildContext context, bool? isRefresh,
            RefreshController? controller)?
        fetchActiveProduct,
    TResult Function(BuildContext context, bool? isRefresh,
            RefreshController? controller)?
        fetchUnActiveProduct,
    TResult Function(BuildContext context, bool? isRefresh,
            RefreshController? controller)?
        fetchWaitingProduct,
    TResult Function(BuildContext context, ProductData? product, bool? help)?
        changeActivate,
    TResult Function(BuildContext context, ProductData? product)? deleteProduct,
    TResult Function()? updateState,
    TResult Function(int index)? setIndex,
    required TResult orElse(),
  }) {
    if (changeActivate != null) {
      return changeActivate(context, product, help);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(FetchActiveProduct value) fetchActiveProduct,
    required TResult Function(FetchUnActiveProduct value) fetchUnActiveProduct,
    required TResult Function(FetchWaitingProduct value) fetchWaitingProduct,
    required TResult Function(ChangeActivate value) changeActivate,
    required TResult Function(DeleteProduct value) deleteProduct,
    required TResult Function(UpdateState value) updateState,
    required TResult Function(SetIndex value) setIndex,
  }) {
    return changeActivate(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(FetchActiveProduct value)? fetchActiveProduct,
    TResult? Function(FetchUnActiveProduct value)? fetchUnActiveProduct,
    TResult? Function(FetchWaitingProduct value)? fetchWaitingProduct,
    TResult? Function(ChangeActivate value)? changeActivate,
    TResult? Function(DeleteProduct value)? deleteProduct,
    TResult? Function(UpdateState value)? updateState,
    TResult? Function(SetIndex value)? setIndex,
  }) {
    return changeActivate?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FetchActiveProduct value)? fetchActiveProduct,
    TResult Function(FetchUnActiveProduct value)? fetchUnActiveProduct,
    TResult Function(FetchWaitingProduct value)? fetchWaitingProduct,
    TResult Function(ChangeActivate value)? changeActivate,
    TResult Function(DeleteProduct value)? deleteProduct,
    TResult Function(UpdateState value)? updateState,
    TResult Function(SetIndex value)? setIndex,
    required TResult orElse(),
  }) {
    if (changeActivate != null) {
      return changeActivate(this);
    }
    return orElse();
  }
}

abstract class ChangeActivate implements UserProductEvent {
  const factory ChangeActivate(
      {required final BuildContext context,
      final ProductData? product,
      final bool? help}) = _$ChangeActivateImpl;

  BuildContext get context;
  ProductData? get product;
  bool? get help;

  /// Create a copy of UserProductEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ChangeActivateImplCopyWith<_$ChangeActivateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$DeleteProductImplCopyWith<$Res> {
  factory _$$DeleteProductImplCopyWith(
          _$DeleteProductImpl value, $Res Function(_$DeleteProductImpl) then) =
      __$$DeleteProductImplCopyWithImpl<$Res>;
  @useResult
  $Res call({BuildContext context, ProductData? product});
}

/// @nodoc
class __$$DeleteProductImplCopyWithImpl<$Res>
    extends _$UserProductEventCopyWithImpl<$Res, _$DeleteProductImpl>
    implements _$$DeleteProductImplCopyWith<$Res> {
  __$$DeleteProductImplCopyWithImpl(
      _$DeleteProductImpl _value, $Res Function(_$DeleteProductImpl) _then)
      : super(_value, _then);

  /// Create a copy of UserProductEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? context = null,
    Object? product = freezed,
  }) {
    return _then(_$DeleteProductImpl(
      context: null == context
          ? _value.context
          : context // ignore: cast_nullable_to_non_nullable
              as BuildContext,
      product: freezed == product
          ? _value.product
          : product // ignore: cast_nullable_to_non_nullable
              as ProductData?,
    ));
  }
}

/// @nodoc

class _$DeleteProductImpl implements DeleteProduct {
  const _$DeleteProductImpl({required this.context, this.product});

  @override
  final BuildContext context;
  @override
  final ProductData? product;

  @override
  String toString() {
    return 'UserProductEvent.deleteProduct(context: $context, product: $product)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DeleteProductImpl &&
            (identical(other.context, context) || other.context == context) &&
            (identical(other.product, product) || other.product == product));
  }

  @override
  int get hashCode => Object.hash(runtimeType, context, product);

  /// Create a copy of UserProductEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DeleteProductImplCopyWith<_$DeleteProductImpl> get copyWith =>
      __$$DeleteProductImplCopyWithImpl<_$DeleteProductImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(BuildContext context, bool? isRefresh,
            RefreshController? controller)
        fetchActiveProduct,
    required TResult Function(BuildContext context, bool? isRefresh,
            RefreshController? controller)
        fetchUnActiveProduct,
    required TResult Function(BuildContext context, bool? isRefresh,
            RefreshController? controller)
        fetchWaitingProduct,
    required TResult Function(
            BuildContext context, ProductData? product, bool? help)
        changeActivate,
    required TResult Function(BuildContext context, ProductData? product)
        deleteProduct,
    required TResult Function() updateState,
    required TResult Function(int index) setIndex,
  }) {
    return deleteProduct(context, product);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(BuildContext context, bool? isRefresh,
            RefreshController? controller)?
        fetchActiveProduct,
    TResult? Function(BuildContext context, bool? isRefresh,
            RefreshController? controller)?
        fetchUnActiveProduct,
    TResult? Function(BuildContext context, bool? isRefresh,
            RefreshController? controller)?
        fetchWaitingProduct,
    TResult? Function(BuildContext context, ProductData? product, bool? help)?
        changeActivate,
    TResult? Function(BuildContext context, ProductData? product)?
        deleteProduct,
    TResult? Function()? updateState,
    TResult? Function(int index)? setIndex,
  }) {
    return deleteProduct?.call(context, product);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(BuildContext context, bool? isRefresh,
            RefreshController? controller)?
        fetchActiveProduct,
    TResult Function(BuildContext context, bool? isRefresh,
            RefreshController? controller)?
        fetchUnActiveProduct,
    TResult Function(BuildContext context, bool? isRefresh,
            RefreshController? controller)?
        fetchWaitingProduct,
    TResult Function(BuildContext context, ProductData? product, bool? help)?
        changeActivate,
    TResult Function(BuildContext context, ProductData? product)? deleteProduct,
    TResult Function()? updateState,
    TResult Function(int index)? setIndex,
    required TResult orElse(),
  }) {
    if (deleteProduct != null) {
      return deleteProduct(context, product);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(FetchActiveProduct value) fetchActiveProduct,
    required TResult Function(FetchUnActiveProduct value) fetchUnActiveProduct,
    required TResult Function(FetchWaitingProduct value) fetchWaitingProduct,
    required TResult Function(ChangeActivate value) changeActivate,
    required TResult Function(DeleteProduct value) deleteProduct,
    required TResult Function(UpdateState value) updateState,
    required TResult Function(SetIndex value) setIndex,
  }) {
    return deleteProduct(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(FetchActiveProduct value)? fetchActiveProduct,
    TResult? Function(FetchUnActiveProduct value)? fetchUnActiveProduct,
    TResult? Function(FetchWaitingProduct value)? fetchWaitingProduct,
    TResult? Function(ChangeActivate value)? changeActivate,
    TResult? Function(DeleteProduct value)? deleteProduct,
    TResult? Function(UpdateState value)? updateState,
    TResult? Function(SetIndex value)? setIndex,
  }) {
    return deleteProduct?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FetchActiveProduct value)? fetchActiveProduct,
    TResult Function(FetchUnActiveProduct value)? fetchUnActiveProduct,
    TResult Function(FetchWaitingProduct value)? fetchWaitingProduct,
    TResult Function(ChangeActivate value)? changeActivate,
    TResult Function(DeleteProduct value)? deleteProduct,
    TResult Function(UpdateState value)? updateState,
    TResult Function(SetIndex value)? setIndex,
    required TResult orElse(),
  }) {
    if (deleteProduct != null) {
      return deleteProduct(this);
    }
    return orElse();
  }
}

abstract class DeleteProduct implements UserProductEvent {
  const factory DeleteProduct(
      {required final BuildContext context,
      final ProductData? product}) = _$DeleteProductImpl;

  BuildContext get context;
  ProductData? get product;

  /// Create a copy of UserProductEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DeleteProductImplCopyWith<_$DeleteProductImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$UpdateStateImplCopyWith<$Res> {
  factory _$$UpdateStateImplCopyWith(
          _$UpdateStateImpl value, $Res Function(_$UpdateStateImpl) then) =
      __$$UpdateStateImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$UpdateStateImplCopyWithImpl<$Res>
    extends _$UserProductEventCopyWithImpl<$Res, _$UpdateStateImpl>
    implements _$$UpdateStateImplCopyWith<$Res> {
  __$$UpdateStateImplCopyWithImpl(
      _$UpdateStateImpl _value, $Res Function(_$UpdateStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of UserProductEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$UpdateStateImpl implements UpdateState {
  const _$UpdateStateImpl();

  @override
  String toString() {
    return 'UserProductEvent.updateState()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$UpdateStateImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(BuildContext context, bool? isRefresh,
            RefreshController? controller)
        fetchActiveProduct,
    required TResult Function(BuildContext context, bool? isRefresh,
            RefreshController? controller)
        fetchUnActiveProduct,
    required TResult Function(BuildContext context, bool? isRefresh,
            RefreshController? controller)
        fetchWaitingProduct,
    required TResult Function(
            BuildContext context, ProductData? product, bool? help)
        changeActivate,
    required TResult Function(BuildContext context, ProductData? product)
        deleteProduct,
    required TResult Function() updateState,
    required TResult Function(int index) setIndex,
  }) {
    return updateState();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(BuildContext context, bool? isRefresh,
            RefreshController? controller)?
        fetchActiveProduct,
    TResult? Function(BuildContext context, bool? isRefresh,
            RefreshController? controller)?
        fetchUnActiveProduct,
    TResult? Function(BuildContext context, bool? isRefresh,
            RefreshController? controller)?
        fetchWaitingProduct,
    TResult? Function(BuildContext context, ProductData? product, bool? help)?
        changeActivate,
    TResult? Function(BuildContext context, ProductData? product)?
        deleteProduct,
    TResult? Function()? updateState,
    TResult? Function(int index)? setIndex,
  }) {
    return updateState?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(BuildContext context, bool? isRefresh,
            RefreshController? controller)?
        fetchActiveProduct,
    TResult Function(BuildContext context, bool? isRefresh,
            RefreshController? controller)?
        fetchUnActiveProduct,
    TResult Function(BuildContext context, bool? isRefresh,
            RefreshController? controller)?
        fetchWaitingProduct,
    TResult Function(BuildContext context, ProductData? product, bool? help)?
        changeActivate,
    TResult Function(BuildContext context, ProductData? product)? deleteProduct,
    TResult Function()? updateState,
    TResult Function(int index)? setIndex,
    required TResult orElse(),
  }) {
    if (updateState != null) {
      return updateState();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(FetchActiveProduct value) fetchActiveProduct,
    required TResult Function(FetchUnActiveProduct value) fetchUnActiveProduct,
    required TResult Function(FetchWaitingProduct value) fetchWaitingProduct,
    required TResult Function(ChangeActivate value) changeActivate,
    required TResult Function(DeleteProduct value) deleteProduct,
    required TResult Function(UpdateState value) updateState,
    required TResult Function(SetIndex value) setIndex,
  }) {
    return updateState(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(FetchActiveProduct value)? fetchActiveProduct,
    TResult? Function(FetchUnActiveProduct value)? fetchUnActiveProduct,
    TResult? Function(FetchWaitingProduct value)? fetchWaitingProduct,
    TResult? Function(ChangeActivate value)? changeActivate,
    TResult? Function(DeleteProduct value)? deleteProduct,
    TResult? Function(UpdateState value)? updateState,
    TResult? Function(SetIndex value)? setIndex,
  }) {
    return updateState?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FetchActiveProduct value)? fetchActiveProduct,
    TResult Function(FetchUnActiveProduct value)? fetchUnActiveProduct,
    TResult Function(FetchWaitingProduct value)? fetchWaitingProduct,
    TResult Function(ChangeActivate value)? changeActivate,
    TResult Function(DeleteProduct value)? deleteProduct,
    TResult Function(UpdateState value)? updateState,
    TResult Function(SetIndex value)? setIndex,
    required TResult orElse(),
  }) {
    if (updateState != null) {
      return updateState(this);
    }
    return orElse();
  }
}

abstract class UpdateState implements UserProductEvent {
  const factory UpdateState() = _$UpdateStateImpl;
}

/// @nodoc
abstract class _$$SetIndexImplCopyWith<$Res> {
  factory _$$SetIndexImplCopyWith(
          _$SetIndexImpl value, $Res Function(_$SetIndexImpl) then) =
      __$$SetIndexImplCopyWithImpl<$Res>;
  @useResult
  $Res call({int index});
}

/// @nodoc
class __$$SetIndexImplCopyWithImpl<$Res>
    extends _$UserProductEventCopyWithImpl<$Res, _$SetIndexImpl>
    implements _$$SetIndexImplCopyWith<$Res> {
  __$$SetIndexImplCopyWithImpl(
      _$SetIndexImpl _value, $Res Function(_$SetIndexImpl) _then)
      : super(_value, _then);

  /// Create a copy of UserProductEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? index = null,
  }) {
    return _then(_$SetIndexImpl(
      index: null == index
          ? _value.index
          : index // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$SetIndexImpl implements SetIndex {
  const _$SetIndexImpl({required this.index});

  @override
  final int index;

  @override
  String toString() {
    return 'UserProductEvent.setIndex(index: $index)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SetIndexImpl &&
            (identical(other.index, index) || other.index == index));
  }

  @override
  int get hashCode => Object.hash(runtimeType, index);

  /// Create a copy of UserProductEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SetIndexImplCopyWith<_$SetIndexImpl> get copyWith =>
      __$$SetIndexImplCopyWithImpl<_$SetIndexImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(BuildContext context, bool? isRefresh,
            RefreshController? controller)
        fetchActiveProduct,
    required TResult Function(BuildContext context, bool? isRefresh,
            RefreshController? controller)
        fetchUnActiveProduct,
    required TResult Function(BuildContext context, bool? isRefresh,
            RefreshController? controller)
        fetchWaitingProduct,
    required TResult Function(
            BuildContext context, ProductData? product, bool? help)
        changeActivate,
    required TResult Function(BuildContext context, ProductData? product)
        deleteProduct,
    required TResult Function() updateState,
    required TResult Function(int index) setIndex,
  }) {
    return setIndex(index);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(BuildContext context, bool? isRefresh,
            RefreshController? controller)?
        fetchActiveProduct,
    TResult? Function(BuildContext context, bool? isRefresh,
            RefreshController? controller)?
        fetchUnActiveProduct,
    TResult? Function(BuildContext context, bool? isRefresh,
            RefreshController? controller)?
        fetchWaitingProduct,
    TResult? Function(BuildContext context, ProductData? product, bool? help)?
        changeActivate,
    TResult? Function(BuildContext context, ProductData? product)?
        deleteProduct,
    TResult? Function()? updateState,
    TResult? Function(int index)? setIndex,
  }) {
    return setIndex?.call(index);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(BuildContext context, bool? isRefresh,
            RefreshController? controller)?
        fetchActiveProduct,
    TResult Function(BuildContext context, bool? isRefresh,
            RefreshController? controller)?
        fetchUnActiveProduct,
    TResult Function(BuildContext context, bool? isRefresh,
            RefreshController? controller)?
        fetchWaitingProduct,
    TResult Function(BuildContext context, ProductData? product, bool? help)?
        changeActivate,
    TResult Function(BuildContext context, ProductData? product)? deleteProduct,
    TResult Function()? updateState,
    TResult Function(int index)? setIndex,
    required TResult orElse(),
  }) {
    if (setIndex != null) {
      return setIndex(index);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(FetchActiveProduct value) fetchActiveProduct,
    required TResult Function(FetchUnActiveProduct value) fetchUnActiveProduct,
    required TResult Function(FetchWaitingProduct value) fetchWaitingProduct,
    required TResult Function(ChangeActivate value) changeActivate,
    required TResult Function(DeleteProduct value) deleteProduct,
    required TResult Function(UpdateState value) updateState,
    required TResult Function(SetIndex value) setIndex,
  }) {
    return setIndex(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(FetchActiveProduct value)? fetchActiveProduct,
    TResult? Function(FetchUnActiveProduct value)? fetchUnActiveProduct,
    TResult? Function(FetchWaitingProduct value)? fetchWaitingProduct,
    TResult? Function(ChangeActivate value)? changeActivate,
    TResult? Function(DeleteProduct value)? deleteProduct,
    TResult? Function(UpdateState value)? updateState,
    TResult? Function(SetIndex value)? setIndex,
  }) {
    return setIndex?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FetchActiveProduct value)? fetchActiveProduct,
    TResult Function(FetchUnActiveProduct value)? fetchUnActiveProduct,
    TResult Function(FetchWaitingProduct value)? fetchWaitingProduct,
    TResult Function(ChangeActivate value)? changeActivate,
    TResult Function(DeleteProduct value)? deleteProduct,
    TResult Function(UpdateState value)? updateState,
    TResult Function(SetIndex value)? setIndex,
    required TResult orElse(),
  }) {
    if (setIndex != null) {
      return setIndex(this);
    }
    return orElse();
  }
}

abstract class SetIndex implements UserProductEvent {
  const factory SetIndex({required final int index}) = _$SetIndexImpl;

  int get index;

  /// Create a copy of UserProductEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SetIndexImplCopyWith<_$SetIndexImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$UserProductState {
  List<ProductData> get activeProducts => throw _privateConstructorUsedError;
  List<ProductData> get unActiveProducts => throw _privateConstructorUsedError;
  List<ProductData> get waitingProducts => throw _privateConstructorUsedError;
  bool get isLoadingActive => throw _privateConstructorUsedError;
  bool get isLoadingUnActive => throw _privateConstructorUsedError;
  bool get isLoadingWaiting => throw _privateConstructorUsedError;
  bool get isButtonLoading => throw _privateConstructorUsedError;
  int get tabIndex => throw _privateConstructorUsedError;
  int? get activeLength => throw _privateConstructorUsedError;
  int? get unActiveLength => throw _privateConstructorUsedError;
  int? get waitingLength => throw _privateConstructorUsedError;

  /// Create a copy of UserProductState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserProductStateCopyWith<UserProductState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserProductStateCopyWith<$Res> {
  factory $UserProductStateCopyWith(
          UserProductState value, $Res Function(UserProductState) then) =
      _$UserProductStateCopyWithImpl<$Res, UserProductState>;
  @useResult
  $Res call(
      {List<ProductData> activeProducts,
      List<ProductData> unActiveProducts,
      List<ProductData> waitingProducts,
      bool isLoadingActive,
      bool isLoadingUnActive,
      bool isLoadingWaiting,
      bool isButtonLoading,
      int tabIndex,
      int? activeLength,
      int? unActiveLength,
      int? waitingLength});
}

/// @nodoc
class _$UserProductStateCopyWithImpl<$Res, $Val extends UserProductState>
    implements $UserProductStateCopyWith<$Res> {
  _$UserProductStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserProductState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? activeProducts = null,
    Object? unActiveProducts = null,
    Object? waitingProducts = null,
    Object? isLoadingActive = null,
    Object? isLoadingUnActive = null,
    Object? isLoadingWaiting = null,
    Object? isButtonLoading = null,
    Object? tabIndex = null,
    Object? activeLength = freezed,
    Object? unActiveLength = freezed,
    Object? waitingLength = freezed,
  }) {
    return _then(_value.copyWith(
      activeProducts: null == activeProducts
          ? _value.activeProducts
          : activeProducts // ignore: cast_nullable_to_non_nullable
              as List<ProductData>,
      unActiveProducts: null == unActiveProducts
          ? _value.unActiveProducts
          : unActiveProducts // ignore: cast_nullable_to_non_nullable
              as List<ProductData>,
      waitingProducts: null == waitingProducts
          ? _value.waitingProducts
          : waitingProducts // ignore: cast_nullable_to_non_nullable
              as List<ProductData>,
      isLoadingActive: null == isLoadingActive
          ? _value.isLoadingActive
          : isLoadingActive // ignore: cast_nullable_to_non_nullable
              as bool,
      isLoadingUnActive: null == isLoadingUnActive
          ? _value.isLoadingUnActive
          : isLoadingUnActive // ignore: cast_nullable_to_non_nullable
              as bool,
      isLoadingWaiting: null == isLoadingWaiting
          ? _value.isLoadingWaiting
          : isLoadingWaiting // ignore: cast_nullable_to_non_nullable
              as bool,
      isButtonLoading: null == isButtonLoading
          ? _value.isButtonLoading
          : isButtonLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      tabIndex: null == tabIndex
          ? _value.tabIndex
          : tabIndex // ignore: cast_nullable_to_non_nullable
              as int,
      activeLength: freezed == activeLength
          ? _value.activeLength
          : activeLength // ignore: cast_nullable_to_non_nullable
              as int?,
      unActiveLength: freezed == unActiveLength
          ? _value.unActiveLength
          : unActiveLength // ignore: cast_nullable_to_non_nullable
              as int?,
      waitingLength: freezed == waitingLength
          ? _value.waitingLength
          : waitingLength // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UserProductStateImplCopyWith<$Res>
    implements $UserProductStateCopyWith<$Res> {
  factory _$$UserProductStateImplCopyWith(_$UserProductStateImpl value,
          $Res Function(_$UserProductStateImpl) then) =
      __$$UserProductStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<ProductData> activeProducts,
      List<ProductData> unActiveProducts,
      List<ProductData> waitingProducts,
      bool isLoadingActive,
      bool isLoadingUnActive,
      bool isLoadingWaiting,
      bool isButtonLoading,
      int tabIndex,
      int? activeLength,
      int? unActiveLength,
      int? waitingLength});
}

/// @nodoc
class __$$UserProductStateImplCopyWithImpl<$Res>
    extends _$UserProductStateCopyWithImpl<$Res, _$UserProductStateImpl>
    implements _$$UserProductStateImplCopyWith<$Res> {
  __$$UserProductStateImplCopyWithImpl(_$UserProductStateImpl _value,
      $Res Function(_$UserProductStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of UserProductState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? activeProducts = null,
    Object? unActiveProducts = null,
    Object? waitingProducts = null,
    Object? isLoadingActive = null,
    Object? isLoadingUnActive = null,
    Object? isLoadingWaiting = null,
    Object? isButtonLoading = null,
    Object? tabIndex = null,
    Object? activeLength = freezed,
    Object? unActiveLength = freezed,
    Object? waitingLength = freezed,
  }) {
    return _then(_$UserProductStateImpl(
      activeProducts: null == activeProducts
          ? _value._activeProducts
          : activeProducts // ignore: cast_nullable_to_non_nullable
              as List<ProductData>,
      unActiveProducts: null == unActiveProducts
          ? _value._unActiveProducts
          : unActiveProducts // ignore: cast_nullable_to_non_nullable
              as List<ProductData>,
      waitingProducts: null == waitingProducts
          ? _value._waitingProducts
          : waitingProducts // ignore: cast_nullable_to_non_nullable
              as List<ProductData>,
      isLoadingActive: null == isLoadingActive
          ? _value.isLoadingActive
          : isLoadingActive // ignore: cast_nullable_to_non_nullable
              as bool,
      isLoadingUnActive: null == isLoadingUnActive
          ? _value.isLoadingUnActive
          : isLoadingUnActive // ignore: cast_nullable_to_non_nullable
              as bool,
      isLoadingWaiting: null == isLoadingWaiting
          ? _value.isLoadingWaiting
          : isLoadingWaiting // ignore: cast_nullable_to_non_nullable
              as bool,
      isButtonLoading: null == isButtonLoading
          ? _value.isButtonLoading
          : isButtonLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      tabIndex: null == tabIndex
          ? _value.tabIndex
          : tabIndex // ignore: cast_nullable_to_non_nullable
              as int,
      activeLength: freezed == activeLength
          ? _value.activeLength
          : activeLength // ignore: cast_nullable_to_non_nullable
              as int?,
      unActiveLength: freezed == unActiveLength
          ? _value.unActiveLength
          : unActiveLength // ignore: cast_nullable_to_non_nullable
              as int?,
      waitingLength: freezed == waitingLength
          ? _value.waitingLength
          : waitingLength // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc

class _$UserProductStateImpl implements _UserProductState {
  const _$UserProductStateImpl(
      {final List<ProductData> activeProducts = const [],
      final List<ProductData> unActiveProducts = const [],
      final List<ProductData> waitingProducts = const [],
      this.isLoadingActive = true,
      this.isLoadingUnActive = true,
      this.isLoadingWaiting = true,
      this.isButtonLoading = true,
      this.tabIndex = 0,
      this.activeLength,
      this.unActiveLength,
      this.waitingLength})
      : _activeProducts = activeProducts,
        _unActiveProducts = unActiveProducts,
        _waitingProducts = waitingProducts;

  final List<ProductData> _activeProducts;
  @override
  @JsonKey()
  List<ProductData> get activeProducts {
    if (_activeProducts is EqualUnmodifiableListView) return _activeProducts;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_activeProducts);
  }

  final List<ProductData> _unActiveProducts;
  @override
  @JsonKey()
  List<ProductData> get unActiveProducts {
    if (_unActiveProducts is EqualUnmodifiableListView)
      return _unActiveProducts;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_unActiveProducts);
  }

  final List<ProductData> _waitingProducts;
  @override
  @JsonKey()
  List<ProductData> get waitingProducts {
    if (_waitingProducts is EqualUnmodifiableListView) return _waitingProducts;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_waitingProducts);
  }

  @override
  @JsonKey()
  final bool isLoadingActive;
  @override
  @JsonKey()
  final bool isLoadingUnActive;
  @override
  @JsonKey()
  final bool isLoadingWaiting;
  @override
  @JsonKey()
  final bool isButtonLoading;
  @override
  @JsonKey()
  final int tabIndex;
  @override
  final int? activeLength;
  @override
  final int? unActiveLength;
  @override
  final int? waitingLength;

  @override
  String toString() {
    return 'UserProductState(activeProducts: $activeProducts, unActiveProducts: $unActiveProducts, waitingProducts: $waitingProducts, isLoadingActive: $isLoadingActive, isLoadingUnActive: $isLoadingUnActive, isLoadingWaiting: $isLoadingWaiting, isButtonLoading: $isButtonLoading, tabIndex: $tabIndex, activeLength: $activeLength, unActiveLength: $unActiveLength, waitingLength: $waitingLength)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserProductStateImpl &&
            const DeepCollectionEquality()
                .equals(other._activeProducts, _activeProducts) &&
            const DeepCollectionEquality()
                .equals(other._unActiveProducts, _unActiveProducts) &&
            const DeepCollectionEquality()
                .equals(other._waitingProducts, _waitingProducts) &&
            (identical(other.isLoadingActive, isLoadingActive) ||
                other.isLoadingActive == isLoadingActive) &&
            (identical(other.isLoadingUnActive, isLoadingUnActive) ||
                other.isLoadingUnActive == isLoadingUnActive) &&
            (identical(other.isLoadingWaiting, isLoadingWaiting) ||
                other.isLoadingWaiting == isLoadingWaiting) &&
            (identical(other.isButtonLoading, isButtonLoading) ||
                other.isButtonLoading == isButtonLoading) &&
            (identical(other.tabIndex, tabIndex) ||
                other.tabIndex == tabIndex) &&
            (identical(other.activeLength, activeLength) ||
                other.activeLength == activeLength) &&
            (identical(other.unActiveLength, unActiveLength) ||
                other.unActiveLength == unActiveLength) &&
            (identical(other.waitingLength, waitingLength) ||
                other.waitingLength == waitingLength));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_activeProducts),
      const DeepCollectionEquality().hash(_unActiveProducts),
      const DeepCollectionEquality().hash(_waitingProducts),
      isLoadingActive,
      isLoadingUnActive,
      isLoadingWaiting,
      isButtonLoading,
      tabIndex,
      activeLength,
      unActiveLength,
      waitingLength);

  /// Create a copy of UserProductState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserProductStateImplCopyWith<_$UserProductStateImpl> get copyWith =>
      __$$UserProductStateImplCopyWithImpl<_$UserProductStateImpl>(
          this, _$identity);
}

abstract class _UserProductState implements UserProductState {
  const factory _UserProductState(
      {final List<ProductData> activeProducts,
      final List<ProductData> unActiveProducts,
      final List<ProductData> waitingProducts,
      final bool isLoadingActive,
      final bool isLoadingUnActive,
      final bool isLoadingWaiting,
      final bool isButtonLoading,
      final int tabIndex,
      final int? activeLength,
      final int? unActiveLength,
      final int? waitingLength}) = _$UserProductStateImpl;

  @override
  List<ProductData> get activeProducts;
  @override
  List<ProductData> get unActiveProducts;
  @override
  List<ProductData> get waitingProducts;
  @override
  bool get isLoadingActive;
  @override
  bool get isLoadingUnActive;
  @override
  bool get isLoadingWaiting;
  @override
  bool get isButtonLoading;
  @override
  int get tabIndex;
  @override
  int? get activeLength;
  @override
  int? get unActiveLength;
  @override
  int? get waitingLength;

  /// Create a copy of UserProductState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserProductStateImplCopyWith<_$UserProductStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
