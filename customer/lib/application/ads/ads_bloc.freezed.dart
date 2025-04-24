// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ads_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$AdsEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(BuildContext context, int? categoryId,
            AreaModel? area, bool? isRefresh, RefreshController? controller)
        fetchAds,
    required TResult Function(BuildContext context) fetchPayments,
    required TResult Function(BuildContext context, int? categoryId,
            AreaModel? area, bool? isRefresh, RefreshController? controller)
        fetchUserAds,
    required TResult Function(PaymentData payment) changePayment,
    required TResult Function(int id) selectAds,
    required TResult Function(BuildContext context, VoidCallback onSuccess,
            VoidCallback onFailure)
        purchaseAds,
    required TResult Function(BuildContext context, int? productId, int? adsId)
        boost,
    required TResult Function(int id) setPayment,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(BuildContext context, int? categoryId, AreaModel? area,
            bool? isRefresh, RefreshController? controller)?
        fetchAds,
    TResult? Function(BuildContext context)? fetchPayments,
    TResult? Function(BuildContext context, int? categoryId, AreaModel? area,
            bool? isRefresh, RefreshController? controller)?
        fetchUserAds,
    TResult? Function(PaymentData payment)? changePayment,
    TResult? Function(int id)? selectAds,
    TResult? Function(BuildContext context, VoidCallback onSuccess,
            VoidCallback onFailure)?
        purchaseAds,
    TResult? Function(BuildContext context, int? productId, int? adsId)? boost,
    TResult? Function(int id)? setPayment,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(BuildContext context, int? categoryId, AreaModel? area,
            bool? isRefresh, RefreshController? controller)?
        fetchAds,
    TResult Function(BuildContext context)? fetchPayments,
    TResult Function(BuildContext context, int? categoryId, AreaModel? area,
            bool? isRefresh, RefreshController? controller)?
        fetchUserAds,
    TResult Function(PaymentData payment)? changePayment,
    TResult Function(int id)? selectAds,
    TResult Function(BuildContext context, VoidCallback onSuccess,
            VoidCallback onFailure)?
        purchaseAds,
    TResult Function(BuildContext context, int? productId, int? adsId)? boost,
    TResult Function(int id)? setPayment,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(FetchAds value) fetchAds,
    required TResult Function(FetchPayments value) fetchPayments,
    required TResult Function(FetchUserAds value) fetchUserAds,
    required TResult Function(ChangePayment value) changePayment,
    required TResult Function(SelectAds value) selectAds,
    required TResult Function(PurchaseAds value) purchaseAds,
    required TResult Function(Boost value) boost,
    required TResult Function(setPayment value) setPayment,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(FetchAds value)? fetchAds,
    TResult? Function(FetchPayments value)? fetchPayments,
    TResult? Function(FetchUserAds value)? fetchUserAds,
    TResult? Function(ChangePayment value)? changePayment,
    TResult? Function(SelectAds value)? selectAds,
    TResult? Function(PurchaseAds value)? purchaseAds,
    TResult? Function(Boost value)? boost,
    TResult? Function(setPayment value)? setPayment,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FetchAds value)? fetchAds,
    TResult Function(FetchPayments value)? fetchPayments,
    TResult Function(FetchUserAds value)? fetchUserAds,
    TResult Function(ChangePayment value)? changePayment,
    TResult Function(SelectAds value)? selectAds,
    TResult Function(PurchaseAds value)? purchaseAds,
    TResult Function(Boost value)? boost,
    TResult Function(setPayment value)? setPayment,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AdsEventCopyWith<$Res> {
  factory $AdsEventCopyWith(AdsEvent value, $Res Function(AdsEvent) then) =
      _$AdsEventCopyWithImpl<$Res, AdsEvent>;
}

/// @nodoc
class _$AdsEventCopyWithImpl<$Res, $Val extends AdsEvent>
    implements $AdsEventCopyWith<$Res> {
  _$AdsEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AdsEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$FetchAdsImplCopyWith<$Res> {
  factory _$$FetchAdsImplCopyWith(
          _$FetchAdsImpl value, $Res Function(_$FetchAdsImpl) then) =
      __$$FetchAdsImplCopyWithImpl<$Res>;
  @useResult
  $Res call(
      {BuildContext context,
      int? categoryId,
      AreaModel? area,
      bool? isRefresh,
      RefreshController? controller});
}

/// @nodoc
class __$$FetchAdsImplCopyWithImpl<$Res>
    extends _$AdsEventCopyWithImpl<$Res, _$FetchAdsImpl>
    implements _$$FetchAdsImplCopyWith<$Res> {
  __$$FetchAdsImplCopyWithImpl(
      _$FetchAdsImpl _value, $Res Function(_$FetchAdsImpl) _then)
      : super(_value, _then);

  /// Create a copy of AdsEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? context = null,
    Object? categoryId = freezed,
    Object? area = freezed,
    Object? isRefresh = freezed,
    Object? controller = freezed,
  }) {
    return _then(_$FetchAdsImpl(
      context: null == context
          ? _value.context
          : context // ignore: cast_nullable_to_non_nullable
              as BuildContext,
      categoryId: freezed == categoryId
          ? _value.categoryId
          : categoryId // ignore: cast_nullable_to_non_nullable
              as int?,
      area: freezed == area
          ? _value.area
          : area // ignore: cast_nullable_to_non_nullable
              as AreaModel?,
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

class _$FetchAdsImpl implements FetchAds {
  const _$FetchAdsImpl(
      {required this.context,
      this.categoryId,
      this.area,
      this.isRefresh,
      this.controller});

  @override
  final BuildContext context;
  @override
  final int? categoryId;
  @override
  final AreaModel? area;
  @override
  final bool? isRefresh;
  @override
  final RefreshController? controller;

  @override
  String toString() {
    return 'AdsEvent.fetchAds(context: $context, categoryId: $categoryId, area: $area, isRefresh: $isRefresh, controller: $controller)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FetchAdsImpl &&
            (identical(other.context, context) || other.context == context) &&
            (identical(other.categoryId, categoryId) ||
                other.categoryId == categoryId) &&
            (identical(other.area, area) || other.area == area) &&
            (identical(other.isRefresh, isRefresh) ||
                other.isRefresh == isRefresh) &&
            (identical(other.controller, controller) ||
                other.controller == controller));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, context, categoryId, area, isRefresh, controller);

  /// Create a copy of AdsEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FetchAdsImplCopyWith<_$FetchAdsImpl> get copyWith =>
      __$$FetchAdsImplCopyWithImpl<_$FetchAdsImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(BuildContext context, int? categoryId,
            AreaModel? area, bool? isRefresh, RefreshController? controller)
        fetchAds,
    required TResult Function(BuildContext context) fetchPayments,
    required TResult Function(BuildContext context, int? categoryId,
            AreaModel? area, bool? isRefresh, RefreshController? controller)
        fetchUserAds,
    required TResult Function(PaymentData payment) changePayment,
    required TResult Function(int id) selectAds,
    required TResult Function(BuildContext context, VoidCallback onSuccess,
            VoidCallback onFailure)
        purchaseAds,
    required TResult Function(BuildContext context, int? productId, int? adsId)
        boost,
    required TResult Function(int id) setPayment,
  }) {
    return fetchAds(context, categoryId, area, isRefresh, controller);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(BuildContext context, int? categoryId, AreaModel? area,
            bool? isRefresh, RefreshController? controller)?
        fetchAds,
    TResult? Function(BuildContext context)? fetchPayments,
    TResult? Function(BuildContext context, int? categoryId, AreaModel? area,
            bool? isRefresh, RefreshController? controller)?
        fetchUserAds,
    TResult? Function(PaymentData payment)? changePayment,
    TResult? Function(int id)? selectAds,
    TResult? Function(BuildContext context, VoidCallback onSuccess,
            VoidCallback onFailure)?
        purchaseAds,
    TResult? Function(BuildContext context, int? productId, int? adsId)? boost,
    TResult? Function(int id)? setPayment,
  }) {
    return fetchAds?.call(context, categoryId, area, isRefresh, controller);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(BuildContext context, int? categoryId, AreaModel? area,
            bool? isRefresh, RefreshController? controller)?
        fetchAds,
    TResult Function(BuildContext context)? fetchPayments,
    TResult Function(BuildContext context, int? categoryId, AreaModel? area,
            bool? isRefresh, RefreshController? controller)?
        fetchUserAds,
    TResult Function(PaymentData payment)? changePayment,
    TResult Function(int id)? selectAds,
    TResult Function(BuildContext context, VoidCallback onSuccess,
            VoidCallback onFailure)?
        purchaseAds,
    TResult Function(BuildContext context, int? productId, int? adsId)? boost,
    TResult Function(int id)? setPayment,
    required TResult orElse(),
  }) {
    if (fetchAds != null) {
      return fetchAds(context, categoryId, area, isRefresh, controller);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(FetchAds value) fetchAds,
    required TResult Function(FetchPayments value) fetchPayments,
    required TResult Function(FetchUserAds value) fetchUserAds,
    required TResult Function(ChangePayment value) changePayment,
    required TResult Function(SelectAds value) selectAds,
    required TResult Function(PurchaseAds value) purchaseAds,
    required TResult Function(Boost value) boost,
    required TResult Function(setPayment value) setPayment,
  }) {
    return fetchAds(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(FetchAds value)? fetchAds,
    TResult? Function(FetchPayments value)? fetchPayments,
    TResult? Function(FetchUserAds value)? fetchUserAds,
    TResult? Function(ChangePayment value)? changePayment,
    TResult? Function(SelectAds value)? selectAds,
    TResult? Function(PurchaseAds value)? purchaseAds,
    TResult? Function(Boost value)? boost,
    TResult? Function(setPayment value)? setPayment,
  }) {
    return fetchAds?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FetchAds value)? fetchAds,
    TResult Function(FetchPayments value)? fetchPayments,
    TResult Function(FetchUserAds value)? fetchUserAds,
    TResult Function(ChangePayment value)? changePayment,
    TResult Function(SelectAds value)? selectAds,
    TResult Function(PurchaseAds value)? purchaseAds,
    TResult Function(Boost value)? boost,
    TResult Function(setPayment value)? setPayment,
    required TResult orElse(),
  }) {
    if (fetchAds != null) {
      return fetchAds(this);
    }
    return orElse();
  }
}

abstract class FetchAds implements AdsEvent {
  const factory FetchAds(
      {required final BuildContext context,
      final int? categoryId,
      final AreaModel? area,
      final bool? isRefresh,
      final RefreshController? controller}) = _$FetchAdsImpl;

  BuildContext get context;
  int? get categoryId;
  AreaModel? get area;
  bool? get isRefresh;
  RefreshController? get controller;

  /// Create a copy of AdsEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FetchAdsImplCopyWith<_$FetchAdsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$FetchPaymentsImplCopyWith<$Res> {
  factory _$$FetchPaymentsImplCopyWith(
          _$FetchPaymentsImpl value, $Res Function(_$FetchPaymentsImpl) then) =
      __$$FetchPaymentsImplCopyWithImpl<$Res>;
  @useResult
  $Res call({BuildContext context});
}

/// @nodoc
class __$$FetchPaymentsImplCopyWithImpl<$Res>
    extends _$AdsEventCopyWithImpl<$Res, _$FetchPaymentsImpl>
    implements _$$FetchPaymentsImplCopyWith<$Res> {
  __$$FetchPaymentsImplCopyWithImpl(
      _$FetchPaymentsImpl _value, $Res Function(_$FetchPaymentsImpl) _then)
      : super(_value, _then);

  /// Create a copy of AdsEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? context = null,
  }) {
    return _then(_$FetchPaymentsImpl(
      context: null == context
          ? _value.context
          : context // ignore: cast_nullable_to_non_nullable
              as BuildContext,
    ));
  }
}

/// @nodoc

class _$FetchPaymentsImpl implements FetchPayments {
  const _$FetchPaymentsImpl({required this.context});

  @override
  final BuildContext context;

  @override
  String toString() {
    return 'AdsEvent.fetchPayments(context: $context)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FetchPaymentsImpl &&
            (identical(other.context, context) || other.context == context));
  }

  @override
  int get hashCode => Object.hash(runtimeType, context);

  /// Create a copy of AdsEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FetchPaymentsImplCopyWith<_$FetchPaymentsImpl> get copyWith =>
      __$$FetchPaymentsImplCopyWithImpl<_$FetchPaymentsImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(BuildContext context, int? categoryId,
            AreaModel? area, bool? isRefresh, RefreshController? controller)
        fetchAds,
    required TResult Function(BuildContext context) fetchPayments,
    required TResult Function(BuildContext context, int? categoryId,
            AreaModel? area, bool? isRefresh, RefreshController? controller)
        fetchUserAds,
    required TResult Function(PaymentData payment) changePayment,
    required TResult Function(int id) selectAds,
    required TResult Function(BuildContext context, VoidCallback onSuccess,
            VoidCallback onFailure)
        purchaseAds,
    required TResult Function(BuildContext context, int? productId, int? adsId)
        boost,
    required TResult Function(int id) setPayment,
  }) {
    return fetchPayments(context);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(BuildContext context, int? categoryId, AreaModel? area,
            bool? isRefresh, RefreshController? controller)?
        fetchAds,
    TResult? Function(BuildContext context)? fetchPayments,
    TResult? Function(BuildContext context, int? categoryId, AreaModel? area,
            bool? isRefresh, RefreshController? controller)?
        fetchUserAds,
    TResult? Function(PaymentData payment)? changePayment,
    TResult? Function(int id)? selectAds,
    TResult? Function(BuildContext context, VoidCallback onSuccess,
            VoidCallback onFailure)?
        purchaseAds,
    TResult? Function(BuildContext context, int? productId, int? adsId)? boost,
    TResult? Function(int id)? setPayment,
  }) {
    return fetchPayments?.call(context);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(BuildContext context, int? categoryId, AreaModel? area,
            bool? isRefresh, RefreshController? controller)?
        fetchAds,
    TResult Function(BuildContext context)? fetchPayments,
    TResult Function(BuildContext context, int? categoryId, AreaModel? area,
            bool? isRefresh, RefreshController? controller)?
        fetchUserAds,
    TResult Function(PaymentData payment)? changePayment,
    TResult Function(int id)? selectAds,
    TResult Function(BuildContext context, VoidCallback onSuccess,
            VoidCallback onFailure)?
        purchaseAds,
    TResult Function(BuildContext context, int? productId, int? adsId)? boost,
    TResult Function(int id)? setPayment,
    required TResult orElse(),
  }) {
    if (fetchPayments != null) {
      return fetchPayments(context);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(FetchAds value) fetchAds,
    required TResult Function(FetchPayments value) fetchPayments,
    required TResult Function(FetchUserAds value) fetchUserAds,
    required TResult Function(ChangePayment value) changePayment,
    required TResult Function(SelectAds value) selectAds,
    required TResult Function(PurchaseAds value) purchaseAds,
    required TResult Function(Boost value) boost,
    required TResult Function(setPayment value) setPayment,
  }) {
    return fetchPayments(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(FetchAds value)? fetchAds,
    TResult? Function(FetchPayments value)? fetchPayments,
    TResult? Function(FetchUserAds value)? fetchUserAds,
    TResult? Function(ChangePayment value)? changePayment,
    TResult? Function(SelectAds value)? selectAds,
    TResult? Function(PurchaseAds value)? purchaseAds,
    TResult? Function(Boost value)? boost,
    TResult? Function(setPayment value)? setPayment,
  }) {
    return fetchPayments?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FetchAds value)? fetchAds,
    TResult Function(FetchPayments value)? fetchPayments,
    TResult Function(FetchUserAds value)? fetchUserAds,
    TResult Function(ChangePayment value)? changePayment,
    TResult Function(SelectAds value)? selectAds,
    TResult Function(PurchaseAds value)? purchaseAds,
    TResult Function(Boost value)? boost,
    TResult Function(setPayment value)? setPayment,
    required TResult orElse(),
  }) {
    if (fetchPayments != null) {
      return fetchPayments(this);
    }
    return orElse();
  }
}

abstract class FetchPayments implements AdsEvent {
  const factory FetchPayments({required final BuildContext context}) =
      _$FetchPaymentsImpl;

  BuildContext get context;

  /// Create a copy of AdsEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FetchPaymentsImplCopyWith<_$FetchPaymentsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$FetchUserAdsImplCopyWith<$Res> {
  factory _$$FetchUserAdsImplCopyWith(
          _$FetchUserAdsImpl value, $Res Function(_$FetchUserAdsImpl) then) =
      __$$FetchUserAdsImplCopyWithImpl<$Res>;
  @useResult
  $Res call(
      {BuildContext context,
      int? categoryId,
      AreaModel? area,
      bool? isRefresh,
      RefreshController? controller});
}

/// @nodoc
class __$$FetchUserAdsImplCopyWithImpl<$Res>
    extends _$AdsEventCopyWithImpl<$Res, _$FetchUserAdsImpl>
    implements _$$FetchUserAdsImplCopyWith<$Res> {
  __$$FetchUserAdsImplCopyWithImpl(
      _$FetchUserAdsImpl _value, $Res Function(_$FetchUserAdsImpl) _then)
      : super(_value, _then);

  /// Create a copy of AdsEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? context = null,
    Object? categoryId = freezed,
    Object? area = freezed,
    Object? isRefresh = freezed,
    Object? controller = freezed,
  }) {
    return _then(_$FetchUserAdsImpl(
      context: null == context
          ? _value.context
          : context // ignore: cast_nullable_to_non_nullable
              as BuildContext,
      categoryId: freezed == categoryId
          ? _value.categoryId
          : categoryId // ignore: cast_nullable_to_non_nullable
              as int?,
      area: freezed == area
          ? _value.area
          : area // ignore: cast_nullable_to_non_nullable
              as AreaModel?,
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

class _$FetchUserAdsImpl implements FetchUserAds {
  const _$FetchUserAdsImpl(
      {required this.context,
      this.categoryId,
      this.area,
      this.isRefresh,
      this.controller});

  @override
  final BuildContext context;
  @override
  final int? categoryId;
  @override
  final AreaModel? area;
  @override
  final bool? isRefresh;
  @override
  final RefreshController? controller;

  @override
  String toString() {
    return 'AdsEvent.fetchUserAds(context: $context, categoryId: $categoryId, area: $area, isRefresh: $isRefresh, controller: $controller)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FetchUserAdsImpl &&
            (identical(other.context, context) || other.context == context) &&
            (identical(other.categoryId, categoryId) ||
                other.categoryId == categoryId) &&
            (identical(other.area, area) || other.area == area) &&
            (identical(other.isRefresh, isRefresh) ||
                other.isRefresh == isRefresh) &&
            (identical(other.controller, controller) ||
                other.controller == controller));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, context, categoryId, area, isRefresh, controller);

  /// Create a copy of AdsEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FetchUserAdsImplCopyWith<_$FetchUserAdsImpl> get copyWith =>
      __$$FetchUserAdsImplCopyWithImpl<_$FetchUserAdsImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(BuildContext context, int? categoryId,
            AreaModel? area, bool? isRefresh, RefreshController? controller)
        fetchAds,
    required TResult Function(BuildContext context) fetchPayments,
    required TResult Function(BuildContext context, int? categoryId,
            AreaModel? area, bool? isRefresh, RefreshController? controller)
        fetchUserAds,
    required TResult Function(PaymentData payment) changePayment,
    required TResult Function(int id) selectAds,
    required TResult Function(BuildContext context, VoidCallback onSuccess,
            VoidCallback onFailure)
        purchaseAds,
    required TResult Function(BuildContext context, int? productId, int? adsId)
        boost,
    required TResult Function(int id) setPayment,
  }) {
    return fetchUserAds(context, categoryId, area, isRefresh, controller);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(BuildContext context, int? categoryId, AreaModel? area,
            bool? isRefresh, RefreshController? controller)?
        fetchAds,
    TResult? Function(BuildContext context)? fetchPayments,
    TResult? Function(BuildContext context, int? categoryId, AreaModel? area,
            bool? isRefresh, RefreshController? controller)?
        fetchUserAds,
    TResult? Function(PaymentData payment)? changePayment,
    TResult? Function(int id)? selectAds,
    TResult? Function(BuildContext context, VoidCallback onSuccess,
            VoidCallback onFailure)?
        purchaseAds,
    TResult? Function(BuildContext context, int? productId, int? adsId)? boost,
    TResult? Function(int id)? setPayment,
  }) {
    return fetchUserAds?.call(context, categoryId, area, isRefresh, controller);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(BuildContext context, int? categoryId, AreaModel? area,
            bool? isRefresh, RefreshController? controller)?
        fetchAds,
    TResult Function(BuildContext context)? fetchPayments,
    TResult Function(BuildContext context, int? categoryId, AreaModel? area,
            bool? isRefresh, RefreshController? controller)?
        fetchUserAds,
    TResult Function(PaymentData payment)? changePayment,
    TResult Function(int id)? selectAds,
    TResult Function(BuildContext context, VoidCallback onSuccess,
            VoidCallback onFailure)?
        purchaseAds,
    TResult Function(BuildContext context, int? productId, int? adsId)? boost,
    TResult Function(int id)? setPayment,
    required TResult orElse(),
  }) {
    if (fetchUserAds != null) {
      return fetchUserAds(context, categoryId, area, isRefresh, controller);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(FetchAds value) fetchAds,
    required TResult Function(FetchPayments value) fetchPayments,
    required TResult Function(FetchUserAds value) fetchUserAds,
    required TResult Function(ChangePayment value) changePayment,
    required TResult Function(SelectAds value) selectAds,
    required TResult Function(PurchaseAds value) purchaseAds,
    required TResult Function(Boost value) boost,
    required TResult Function(setPayment value) setPayment,
  }) {
    return fetchUserAds(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(FetchAds value)? fetchAds,
    TResult? Function(FetchPayments value)? fetchPayments,
    TResult? Function(FetchUserAds value)? fetchUserAds,
    TResult? Function(ChangePayment value)? changePayment,
    TResult? Function(SelectAds value)? selectAds,
    TResult? Function(PurchaseAds value)? purchaseAds,
    TResult? Function(Boost value)? boost,
    TResult? Function(setPayment value)? setPayment,
  }) {
    return fetchUserAds?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FetchAds value)? fetchAds,
    TResult Function(FetchPayments value)? fetchPayments,
    TResult Function(FetchUserAds value)? fetchUserAds,
    TResult Function(ChangePayment value)? changePayment,
    TResult Function(SelectAds value)? selectAds,
    TResult Function(PurchaseAds value)? purchaseAds,
    TResult Function(Boost value)? boost,
    TResult Function(setPayment value)? setPayment,
    required TResult orElse(),
  }) {
    if (fetchUserAds != null) {
      return fetchUserAds(this);
    }
    return orElse();
  }
}

abstract class FetchUserAds implements AdsEvent {
  const factory FetchUserAds(
      {required final BuildContext context,
      final int? categoryId,
      final AreaModel? area,
      final bool? isRefresh,
      final RefreshController? controller}) = _$FetchUserAdsImpl;

  BuildContext get context;
  int? get categoryId;
  AreaModel? get area;
  bool? get isRefresh;
  RefreshController? get controller;

  /// Create a copy of AdsEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FetchUserAdsImplCopyWith<_$FetchUserAdsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ChangePaymentImplCopyWith<$Res> {
  factory _$$ChangePaymentImplCopyWith(
          _$ChangePaymentImpl value, $Res Function(_$ChangePaymentImpl) then) =
      __$$ChangePaymentImplCopyWithImpl<$Res>;
  @useResult
  $Res call({PaymentData payment});
}

/// @nodoc
class __$$ChangePaymentImplCopyWithImpl<$Res>
    extends _$AdsEventCopyWithImpl<$Res, _$ChangePaymentImpl>
    implements _$$ChangePaymentImplCopyWith<$Res> {
  __$$ChangePaymentImplCopyWithImpl(
      _$ChangePaymentImpl _value, $Res Function(_$ChangePaymentImpl) _then)
      : super(_value, _then);

  /// Create a copy of AdsEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? payment = null,
  }) {
    return _then(_$ChangePaymentImpl(
      payment: null == payment
          ? _value.payment
          : payment // ignore: cast_nullable_to_non_nullable
              as PaymentData,
    ));
  }
}

/// @nodoc

class _$ChangePaymentImpl implements ChangePayment {
  const _$ChangePaymentImpl({required this.payment});

  @override
  final PaymentData payment;

  @override
  String toString() {
    return 'AdsEvent.changePayment(payment: $payment)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChangePaymentImpl &&
            (identical(other.payment, payment) || other.payment == payment));
  }

  @override
  int get hashCode => Object.hash(runtimeType, payment);

  /// Create a copy of AdsEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ChangePaymentImplCopyWith<_$ChangePaymentImpl> get copyWith =>
      __$$ChangePaymentImplCopyWithImpl<_$ChangePaymentImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(BuildContext context, int? categoryId,
            AreaModel? area, bool? isRefresh, RefreshController? controller)
        fetchAds,
    required TResult Function(BuildContext context) fetchPayments,
    required TResult Function(BuildContext context, int? categoryId,
            AreaModel? area, bool? isRefresh, RefreshController? controller)
        fetchUserAds,
    required TResult Function(PaymentData payment) changePayment,
    required TResult Function(int id) selectAds,
    required TResult Function(BuildContext context, VoidCallback onSuccess,
            VoidCallback onFailure)
        purchaseAds,
    required TResult Function(BuildContext context, int? productId, int? adsId)
        boost,
    required TResult Function(int id) setPayment,
  }) {
    return changePayment(payment);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(BuildContext context, int? categoryId, AreaModel? area,
            bool? isRefresh, RefreshController? controller)?
        fetchAds,
    TResult? Function(BuildContext context)? fetchPayments,
    TResult? Function(BuildContext context, int? categoryId, AreaModel? area,
            bool? isRefresh, RefreshController? controller)?
        fetchUserAds,
    TResult? Function(PaymentData payment)? changePayment,
    TResult? Function(int id)? selectAds,
    TResult? Function(BuildContext context, VoidCallback onSuccess,
            VoidCallback onFailure)?
        purchaseAds,
    TResult? Function(BuildContext context, int? productId, int? adsId)? boost,
    TResult? Function(int id)? setPayment,
  }) {
    return changePayment?.call(payment);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(BuildContext context, int? categoryId, AreaModel? area,
            bool? isRefresh, RefreshController? controller)?
        fetchAds,
    TResult Function(BuildContext context)? fetchPayments,
    TResult Function(BuildContext context, int? categoryId, AreaModel? area,
            bool? isRefresh, RefreshController? controller)?
        fetchUserAds,
    TResult Function(PaymentData payment)? changePayment,
    TResult Function(int id)? selectAds,
    TResult Function(BuildContext context, VoidCallback onSuccess,
            VoidCallback onFailure)?
        purchaseAds,
    TResult Function(BuildContext context, int? productId, int? adsId)? boost,
    TResult Function(int id)? setPayment,
    required TResult orElse(),
  }) {
    if (changePayment != null) {
      return changePayment(payment);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(FetchAds value) fetchAds,
    required TResult Function(FetchPayments value) fetchPayments,
    required TResult Function(FetchUserAds value) fetchUserAds,
    required TResult Function(ChangePayment value) changePayment,
    required TResult Function(SelectAds value) selectAds,
    required TResult Function(PurchaseAds value) purchaseAds,
    required TResult Function(Boost value) boost,
    required TResult Function(setPayment value) setPayment,
  }) {
    return changePayment(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(FetchAds value)? fetchAds,
    TResult? Function(FetchPayments value)? fetchPayments,
    TResult? Function(FetchUserAds value)? fetchUserAds,
    TResult? Function(ChangePayment value)? changePayment,
    TResult? Function(SelectAds value)? selectAds,
    TResult? Function(PurchaseAds value)? purchaseAds,
    TResult? Function(Boost value)? boost,
    TResult? Function(setPayment value)? setPayment,
  }) {
    return changePayment?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FetchAds value)? fetchAds,
    TResult Function(FetchPayments value)? fetchPayments,
    TResult Function(FetchUserAds value)? fetchUserAds,
    TResult Function(ChangePayment value)? changePayment,
    TResult Function(SelectAds value)? selectAds,
    TResult Function(PurchaseAds value)? purchaseAds,
    TResult Function(Boost value)? boost,
    TResult Function(setPayment value)? setPayment,
    required TResult orElse(),
  }) {
    if (changePayment != null) {
      return changePayment(this);
    }
    return orElse();
  }
}

abstract class ChangePayment implements AdsEvent {
  const factory ChangePayment({required final PaymentData payment}) =
      _$ChangePaymentImpl;

  PaymentData get payment;

  /// Create a copy of AdsEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ChangePaymentImplCopyWith<_$ChangePaymentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SelectAdsImplCopyWith<$Res> {
  factory _$$SelectAdsImplCopyWith(
          _$SelectAdsImpl value, $Res Function(_$SelectAdsImpl) then) =
      __$$SelectAdsImplCopyWithImpl<$Res>;
  @useResult
  $Res call({int id});
}

/// @nodoc
class __$$SelectAdsImplCopyWithImpl<$Res>
    extends _$AdsEventCopyWithImpl<$Res, _$SelectAdsImpl>
    implements _$$SelectAdsImplCopyWith<$Res> {
  __$$SelectAdsImplCopyWithImpl(
      _$SelectAdsImpl _value, $Res Function(_$SelectAdsImpl) _then)
      : super(_value, _then);

  /// Create a copy of AdsEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
  }) {
    return _then(_$SelectAdsImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$SelectAdsImpl implements SelectAds {
  const _$SelectAdsImpl({required this.id});

  @override
  final int id;

  @override
  String toString() {
    return 'AdsEvent.selectAds(id: $id)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SelectAdsImpl &&
            (identical(other.id, id) || other.id == id));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id);

  /// Create a copy of AdsEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SelectAdsImplCopyWith<_$SelectAdsImpl> get copyWith =>
      __$$SelectAdsImplCopyWithImpl<_$SelectAdsImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(BuildContext context, int? categoryId,
            AreaModel? area, bool? isRefresh, RefreshController? controller)
        fetchAds,
    required TResult Function(BuildContext context) fetchPayments,
    required TResult Function(BuildContext context, int? categoryId,
            AreaModel? area, bool? isRefresh, RefreshController? controller)
        fetchUserAds,
    required TResult Function(PaymentData payment) changePayment,
    required TResult Function(int id) selectAds,
    required TResult Function(BuildContext context, VoidCallback onSuccess,
            VoidCallback onFailure)
        purchaseAds,
    required TResult Function(BuildContext context, int? productId, int? adsId)
        boost,
    required TResult Function(int id) setPayment,
  }) {
    return selectAds(id);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(BuildContext context, int? categoryId, AreaModel? area,
            bool? isRefresh, RefreshController? controller)?
        fetchAds,
    TResult? Function(BuildContext context)? fetchPayments,
    TResult? Function(BuildContext context, int? categoryId, AreaModel? area,
            bool? isRefresh, RefreshController? controller)?
        fetchUserAds,
    TResult? Function(PaymentData payment)? changePayment,
    TResult? Function(int id)? selectAds,
    TResult? Function(BuildContext context, VoidCallback onSuccess,
            VoidCallback onFailure)?
        purchaseAds,
    TResult? Function(BuildContext context, int? productId, int? adsId)? boost,
    TResult? Function(int id)? setPayment,
  }) {
    return selectAds?.call(id);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(BuildContext context, int? categoryId, AreaModel? area,
            bool? isRefresh, RefreshController? controller)?
        fetchAds,
    TResult Function(BuildContext context)? fetchPayments,
    TResult Function(BuildContext context, int? categoryId, AreaModel? area,
            bool? isRefresh, RefreshController? controller)?
        fetchUserAds,
    TResult Function(PaymentData payment)? changePayment,
    TResult Function(int id)? selectAds,
    TResult Function(BuildContext context, VoidCallback onSuccess,
            VoidCallback onFailure)?
        purchaseAds,
    TResult Function(BuildContext context, int? productId, int? adsId)? boost,
    TResult Function(int id)? setPayment,
    required TResult orElse(),
  }) {
    if (selectAds != null) {
      return selectAds(id);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(FetchAds value) fetchAds,
    required TResult Function(FetchPayments value) fetchPayments,
    required TResult Function(FetchUserAds value) fetchUserAds,
    required TResult Function(ChangePayment value) changePayment,
    required TResult Function(SelectAds value) selectAds,
    required TResult Function(PurchaseAds value) purchaseAds,
    required TResult Function(Boost value) boost,
    required TResult Function(setPayment value) setPayment,
  }) {
    return selectAds(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(FetchAds value)? fetchAds,
    TResult? Function(FetchPayments value)? fetchPayments,
    TResult? Function(FetchUserAds value)? fetchUserAds,
    TResult? Function(ChangePayment value)? changePayment,
    TResult? Function(SelectAds value)? selectAds,
    TResult? Function(PurchaseAds value)? purchaseAds,
    TResult? Function(Boost value)? boost,
    TResult? Function(setPayment value)? setPayment,
  }) {
    return selectAds?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FetchAds value)? fetchAds,
    TResult Function(FetchPayments value)? fetchPayments,
    TResult Function(FetchUserAds value)? fetchUserAds,
    TResult Function(ChangePayment value)? changePayment,
    TResult Function(SelectAds value)? selectAds,
    TResult Function(PurchaseAds value)? purchaseAds,
    TResult Function(Boost value)? boost,
    TResult Function(setPayment value)? setPayment,
    required TResult orElse(),
  }) {
    if (selectAds != null) {
      return selectAds(this);
    }
    return orElse();
  }
}

abstract class SelectAds implements AdsEvent {
  const factory SelectAds({required final int id}) = _$SelectAdsImpl;

  int get id;

  /// Create a copy of AdsEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SelectAdsImplCopyWith<_$SelectAdsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$PurchaseAdsImplCopyWith<$Res> {
  factory _$$PurchaseAdsImplCopyWith(
          _$PurchaseAdsImpl value, $Res Function(_$PurchaseAdsImpl) then) =
      __$$PurchaseAdsImplCopyWithImpl<$Res>;
  @useResult
  $Res call(
      {BuildContext context, VoidCallback onSuccess, VoidCallback onFailure});
}

/// @nodoc
class __$$PurchaseAdsImplCopyWithImpl<$Res>
    extends _$AdsEventCopyWithImpl<$Res, _$PurchaseAdsImpl>
    implements _$$PurchaseAdsImplCopyWith<$Res> {
  __$$PurchaseAdsImplCopyWithImpl(
      _$PurchaseAdsImpl _value, $Res Function(_$PurchaseAdsImpl) _then)
      : super(_value, _then);

  /// Create a copy of AdsEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? context = null,
    Object? onSuccess = null,
    Object? onFailure = null,
  }) {
    return _then(_$PurchaseAdsImpl(
      context: null == context
          ? _value.context
          : context // ignore: cast_nullable_to_non_nullable
              as BuildContext,
      onSuccess: null == onSuccess
          ? _value.onSuccess
          : onSuccess // ignore: cast_nullable_to_non_nullable
              as VoidCallback,
      onFailure: null == onFailure
          ? _value.onFailure
          : onFailure // ignore: cast_nullable_to_non_nullable
              as VoidCallback,
    ));
  }
}

/// @nodoc

class _$PurchaseAdsImpl implements PurchaseAds {
  const _$PurchaseAdsImpl(
      {required this.context,
      required this.onSuccess,
      required this.onFailure});

  @override
  final BuildContext context;
  @override
  final VoidCallback onSuccess;
  @override
  final VoidCallback onFailure;

  @override
  String toString() {
    return 'AdsEvent.purchaseAds(context: $context, onSuccess: $onSuccess, onFailure: $onFailure)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PurchaseAdsImpl &&
            (identical(other.context, context) || other.context == context) &&
            (identical(other.onSuccess, onSuccess) ||
                other.onSuccess == onSuccess) &&
            (identical(other.onFailure, onFailure) ||
                other.onFailure == onFailure));
  }

  @override
  int get hashCode => Object.hash(runtimeType, context, onSuccess, onFailure);

  /// Create a copy of AdsEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PurchaseAdsImplCopyWith<_$PurchaseAdsImpl> get copyWith =>
      __$$PurchaseAdsImplCopyWithImpl<_$PurchaseAdsImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(BuildContext context, int? categoryId,
            AreaModel? area, bool? isRefresh, RefreshController? controller)
        fetchAds,
    required TResult Function(BuildContext context) fetchPayments,
    required TResult Function(BuildContext context, int? categoryId,
            AreaModel? area, bool? isRefresh, RefreshController? controller)
        fetchUserAds,
    required TResult Function(PaymentData payment) changePayment,
    required TResult Function(int id) selectAds,
    required TResult Function(BuildContext context, VoidCallback onSuccess,
            VoidCallback onFailure)
        purchaseAds,
    required TResult Function(BuildContext context, int? productId, int? adsId)
        boost,
    required TResult Function(int id) setPayment,
  }) {
    return purchaseAds(context, onSuccess, onFailure);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(BuildContext context, int? categoryId, AreaModel? area,
            bool? isRefresh, RefreshController? controller)?
        fetchAds,
    TResult? Function(BuildContext context)? fetchPayments,
    TResult? Function(BuildContext context, int? categoryId, AreaModel? area,
            bool? isRefresh, RefreshController? controller)?
        fetchUserAds,
    TResult? Function(PaymentData payment)? changePayment,
    TResult? Function(int id)? selectAds,
    TResult? Function(BuildContext context, VoidCallback onSuccess,
            VoidCallback onFailure)?
        purchaseAds,
    TResult? Function(BuildContext context, int? productId, int? adsId)? boost,
    TResult? Function(int id)? setPayment,
  }) {
    return purchaseAds?.call(context, onSuccess, onFailure);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(BuildContext context, int? categoryId, AreaModel? area,
            bool? isRefresh, RefreshController? controller)?
        fetchAds,
    TResult Function(BuildContext context)? fetchPayments,
    TResult Function(BuildContext context, int? categoryId, AreaModel? area,
            bool? isRefresh, RefreshController? controller)?
        fetchUserAds,
    TResult Function(PaymentData payment)? changePayment,
    TResult Function(int id)? selectAds,
    TResult Function(BuildContext context, VoidCallback onSuccess,
            VoidCallback onFailure)?
        purchaseAds,
    TResult Function(BuildContext context, int? productId, int? adsId)? boost,
    TResult Function(int id)? setPayment,
    required TResult orElse(),
  }) {
    if (purchaseAds != null) {
      return purchaseAds(context, onSuccess, onFailure);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(FetchAds value) fetchAds,
    required TResult Function(FetchPayments value) fetchPayments,
    required TResult Function(FetchUserAds value) fetchUserAds,
    required TResult Function(ChangePayment value) changePayment,
    required TResult Function(SelectAds value) selectAds,
    required TResult Function(PurchaseAds value) purchaseAds,
    required TResult Function(Boost value) boost,
    required TResult Function(setPayment value) setPayment,
  }) {
    return purchaseAds(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(FetchAds value)? fetchAds,
    TResult? Function(FetchPayments value)? fetchPayments,
    TResult? Function(FetchUserAds value)? fetchUserAds,
    TResult? Function(ChangePayment value)? changePayment,
    TResult? Function(SelectAds value)? selectAds,
    TResult? Function(PurchaseAds value)? purchaseAds,
    TResult? Function(Boost value)? boost,
    TResult? Function(setPayment value)? setPayment,
  }) {
    return purchaseAds?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FetchAds value)? fetchAds,
    TResult Function(FetchPayments value)? fetchPayments,
    TResult Function(FetchUserAds value)? fetchUserAds,
    TResult Function(ChangePayment value)? changePayment,
    TResult Function(SelectAds value)? selectAds,
    TResult Function(PurchaseAds value)? purchaseAds,
    TResult Function(Boost value)? boost,
    TResult Function(setPayment value)? setPayment,
    required TResult orElse(),
  }) {
    if (purchaseAds != null) {
      return purchaseAds(this);
    }
    return orElse();
  }
}

abstract class PurchaseAds implements AdsEvent {
  const factory PurchaseAds(
      {required final BuildContext context,
      required final VoidCallback onSuccess,
      required final VoidCallback onFailure}) = _$PurchaseAdsImpl;

  BuildContext get context;
  VoidCallback get onSuccess;
  VoidCallback get onFailure;

  /// Create a copy of AdsEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PurchaseAdsImplCopyWith<_$PurchaseAdsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$BoostImplCopyWith<$Res> {
  factory _$$BoostImplCopyWith(
          _$BoostImpl value, $Res Function(_$BoostImpl) then) =
      __$$BoostImplCopyWithImpl<$Res>;
  @useResult
  $Res call({BuildContext context, int? productId, int? adsId});
}

/// @nodoc
class __$$BoostImplCopyWithImpl<$Res>
    extends _$AdsEventCopyWithImpl<$Res, _$BoostImpl>
    implements _$$BoostImplCopyWith<$Res> {
  __$$BoostImplCopyWithImpl(
      _$BoostImpl _value, $Res Function(_$BoostImpl) _then)
      : super(_value, _then);

  /// Create a copy of AdsEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? context = null,
    Object? productId = freezed,
    Object? adsId = freezed,
  }) {
    return _then(_$BoostImpl(
      context: null == context
          ? _value.context
          : context // ignore: cast_nullable_to_non_nullable
              as BuildContext,
      productId: freezed == productId
          ? _value.productId
          : productId // ignore: cast_nullable_to_non_nullable
              as int?,
      adsId: freezed == adsId
          ? _value.adsId
          : adsId // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc

class _$BoostImpl implements Boost {
  const _$BoostImpl(
      {required this.context, required this.productId, required this.adsId});

  @override
  final BuildContext context;
  @override
  final int? productId;
  @override
  final int? adsId;

  @override
  String toString() {
    return 'AdsEvent.boost(context: $context, productId: $productId, adsId: $adsId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BoostImpl &&
            (identical(other.context, context) || other.context == context) &&
            (identical(other.productId, productId) ||
                other.productId == productId) &&
            (identical(other.adsId, adsId) || other.adsId == adsId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, context, productId, adsId);

  /// Create a copy of AdsEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BoostImplCopyWith<_$BoostImpl> get copyWith =>
      __$$BoostImplCopyWithImpl<_$BoostImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(BuildContext context, int? categoryId,
            AreaModel? area, bool? isRefresh, RefreshController? controller)
        fetchAds,
    required TResult Function(BuildContext context) fetchPayments,
    required TResult Function(BuildContext context, int? categoryId,
            AreaModel? area, bool? isRefresh, RefreshController? controller)
        fetchUserAds,
    required TResult Function(PaymentData payment) changePayment,
    required TResult Function(int id) selectAds,
    required TResult Function(BuildContext context, VoidCallback onSuccess,
            VoidCallback onFailure)
        purchaseAds,
    required TResult Function(BuildContext context, int? productId, int? adsId)
        boost,
    required TResult Function(int id) setPayment,
  }) {
    return boost(context, productId, adsId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(BuildContext context, int? categoryId, AreaModel? area,
            bool? isRefresh, RefreshController? controller)?
        fetchAds,
    TResult? Function(BuildContext context)? fetchPayments,
    TResult? Function(BuildContext context, int? categoryId, AreaModel? area,
            bool? isRefresh, RefreshController? controller)?
        fetchUserAds,
    TResult? Function(PaymentData payment)? changePayment,
    TResult? Function(int id)? selectAds,
    TResult? Function(BuildContext context, VoidCallback onSuccess,
            VoidCallback onFailure)?
        purchaseAds,
    TResult? Function(BuildContext context, int? productId, int? adsId)? boost,
    TResult? Function(int id)? setPayment,
  }) {
    return boost?.call(context, productId, adsId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(BuildContext context, int? categoryId, AreaModel? area,
            bool? isRefresh, RefreshController? controller)?
        fetchAds,
    TResult Function(BuildContext context)? fetchPayments,
    TResult Function(BuildContext context, int? categoryId, AreaModel? area,
            bool? isRefresh, RefreshController? controller)?
        fetchUserAds,
    TResult Function(PaymentData payment)? changePayment,
    TResult Function(int id)? selectAds,
    TResult Function(BuildContext context, VoidCallback onSuccess,
            VoidCallback onFailure)?
        purchaseAds,
    TResult Function(BuildContext context, int? productId, int? adsId)? boost,
    TResult Function(int id)? setPayment,
    required TResult orElse(),
  }) {
    if (boost != null) {
      return boost(context, productId, adsId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(FetchAds value) fetchAds,
    required TResult Function(FetchPayments value) fetchPayments,
    required TResult Function(FetchUserAds value) fetchUserAds,
    required TResult Function(ChangePayment value) changePayment,
    required TResult Function(SelectAds value) selectAds,
    required TResult Function(PurchaseAds value) purchaseAds,
    required TResult Function(Boost value) boost,
    required TResult Function(setPayment value) setPayment,
  }) {
    return boost(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(FetchAds value)? fetchAds,
    TResult? Function(FetchPayments value)? fetchPayments,
    TResult? Function(FetchUserAds value)? fetchUserAds,
    TResult? Function(ChangePayment value)? changePayment,
    TResult? Function(SelectAds value)? selectAds,
    TResult? Function(PurchaseAds value)? purchaseAds,
    TResult? Function(Boost value)? boost,
    TResult? Function(setPayment value)? setPayment,
  }) {
    return boost?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FetchAds value)? fetchAds,
    TResult Function(FetchPayments value)? fetchPayments,
    TResult Function(FetchUserAds value)? fetchUserAds,
    TResult Function(ChangePayment value)? changePayment,
    TResult Function(SelectAds value)? selectAds,
    TResult Function(PurchaseAds value)? purchaseAds,
    TResult Function(Boost value)? boost,
    TResult Function(setPayment value)? setPayment,
    required TResult orElse(),
  }) {
    if (boost != null) {
      return boost(this);
    }
    return orElse();
  }
}

abstract class Boost implements AdsEvent {
  const factory Boost(
      {required final BuildContext context,
      required final int? productId,
      required final int? adsId}) = _$BoostImpl;

  BuildContext get context;
  int? get productId;
  int? get adsId;

  /// Create a copy of AdsEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BoostImplCopyWith<_$BoostImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$setPaymentImplCopyWith<$Res> {
  factory _$$setPaymentImplCopyWith(
          _$setPaymentImpl value, $Res Function(_$setPaymentImpl) then) =
      __$$setPaymentImplCopyWithImpl<$Res>;
  @useResult
  $Res call({int id});
}

/// @nodoc
class __$$setPaymentImplCopyWithImpl<$Res>
    extends _$AdsEventCopyWithImpl<$Res, _$setPaymentImpl>
    implements _$$setPaymentImplCopyWith<$Res> {
  __$$setPaymentImplCopyWithImpl(
      _$setPaymentImpl _value, $Res Function(_$setPaymentImpl) _then)
      : super(_value, _then);

  /// Create a copy of AdsEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
  }) {
    return _then(_$setPaymentImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$setPaymentImpl implements setPayment {
  const _$setPaymentImpl({required this.id});

  @override
  final int id;

  @override
  String toString() {
    return 'AdsEvent.setPayment(id: $id)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$setPaymentImpl &&
            (identical(other.id, id) || other.id == id));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id);

  /// Create a copy of AdsEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$setPaymentImplCopyWith<_$setPaymentImpl> get copyWith =>
      __$$setPaymentImplCopyWithImpl<_$setPaymentImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(BuildContext context, int? categoryId,
            AreaModel? area, bool? isRefresh, RefreshController? controller)
        fetchAds,
    required TResult Function(BuildContext context) fetchPayments,
    required TResult Function(BuildContext context, int? categoryId,
            AreaModel? area, bool? isRefresh, RefreshController? controller)
        fetchUserAds,
    required TResult Function(PaymentData payment) changePayment,
    required TResult Function(int id) selectAds,
    required TResult Function(BuildContext context, VoidCallback onSuccess,
            VoidCallback onFailure)
        purchaseAds,
    required TResult Function(BuildContext context, int? productId, int? adsId)
        boost,
    required TResult Function(int id) setPayment,
  }) {
    return setPayment(id);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(BuildContext context, int? categoryId, AreaModel? area,
            bool? isRefresh, RefreshController? controller)?
        fetchAds,
    TResult? Function(BuildContext context)? fetchPayments,
    TResult? Function(BuildContext context, int? categoryId, AreaModel? area,
            bool? isRefresh, RefreshController? controller)?
        fetchUserAds,
    TResult? Function(PaymentData payment)? changePayment,
    TResult? Function(int id)? selectAds,
    TResult? Function(BuildContext context, VoidCallback onSuccess,
            VoidCallback onFailure)?
        purchaseAds,
    TResult? Function(BuildContext context, int? productId, int? adsId)? boost,
    TResult? Function(int id)? setPayment,
  }) {
    return setPayment?.call(id);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(BuildContext context, int? categoryId, AreaModel? area,
            bool? isRefresh, RefreshController? controller)?
        fetchAds,
    TResult Function(BuildContext context)? fetchPayments,
    TResult Function(BuildContext context, int? categoryId, AreaModel? area,
            bool? isRefresh, RefreshController? controller)?
        fetchUserAds,
    TResult Function(PaymentData payment)? changePayment,
    TResult Function(int id)? selectAds,
    TResult Function(BuildContext context, VoidCallback onSuccess,
            VoidCallback onFailure)?
        purchaseAds,
    TResult Function(BuildContext context, int? productId, int? adsId)? boost,
    TResult Function(int id)? setPayment,
    required TResult orElse(),
  }) {
    if (setPayment != null) {
      return setPayment(id);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(FetchAds value) fetchAds,
    required TResult Function(FetchPayments value) fetchPayments,
    required TResult Function(FetchUserAds value) fetchUserAds,
    required TResult Function(ChangePayment value) changePayment,
    required TResult Function(SelectAds value) selectAds,
    required TResult Function(PurchaseAds value) purchaseAds,
    required TResult Function(Boost value) boost,
    required TResult Function(setPayment value) setPayment,
  }) {
    return setPayment(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(FetchAds value)? fetchAds,
    TResult? Function(FetchPayments value)? fetchPayments,
    TResult? Function(FetchUserAds value)? fetchUserAds,
    TResult? Function(ChangePayment value)? changePayment,
    TResult? Function(SelectAds value)? selectAds,
    TResult? Function(PurchaseAds value)? purchaseAds,
    TResult? Function(Boost value)? boost,
    TResult? Function(setPayment value)? setPayment,
  }) {
    return setPayment?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FetchAds value)? fetchAds,
    TResult Function(FetchPayments value)? fetchPayments,
    TResult Function(FetchUserAds value)? fetchUserAds,
    TResult Function(ChangePayment value)? changePayment,
    TResult Function(SelectAds value)? selectAds,
    TResult Function(PurchaseAds value)? purchaseAds,
    TResult Function(Boost value)? boost,
    TResult Function(setPayment value)? setPayment,
    required TResult orElse(),
  }) {
    if (setPayment != null) {
      return setPayment(this);
    }
    return orElse();
  }
}

abstract class setPayment implements AdsEvent {
  const factory setPayment({required final int id}) = _$setPaymentImpl;

  int get id;

  /// Create a copy of AdsEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$setPaymentImplCopyWith<_$setPaymentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$AdsState {
  List<AdModel> get adsBanners => throw _privateConstructorUsedError;
  List<AdModel> get userAds => throw _privateConstructorUsedError;
  List<PaymentData> get payments => throw _privateConstructorUsedError;
  int get selectAds => throw _privateConstructorUsedError;
  PaymentData? get selectPayment => throw _privateConstructorUsedError;
  bool get isPaymentLoading => throw _privateConstructorUsedError;
  bool get isPurchaseLoading => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;

  /// Create a copy of AdsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AdsStateCopyWith<AdsState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AdsStateCopyWith<$Res> {
  factory $AdsStateCopyWith(AdsState value, $Res Function(AdsState) then) =
      _$AdsStateCopyWithImpl<$Res, AdsState>;
  @useResult
  $Res call(
      {List<AdModel> adsBanners,
      List<AdModel> userAds,
      List<PaymentData> payments,
      int selectAds,
      PaymentData? selectPayment,
      bool isPaymentLoading,
      bool isPurchaseLoading,
      bool isLoading});
}

/// @nodoc
class _$AdsStateCopyWithImpl<$Res, $Val extends AdsState>
    implements $AdsStateCopyWith<$Res> {
  _$AdsStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AdsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? adsBanners = null,
    Object? userAds = null,
    Object? payments = null,
    Object? selectAds = null,
    Object? selectPayment = freezed,
    Object? isPaymentLoading = null,
    Object? isPurchaseLoading = null,
    Object? isLoading = null,
  }) {
    return _then(_value.copyWith(
      adsBanners: null == adsBanners
          ? _value.adsBanners
          : adsBanners // ignore: cast_nullable_to_non_nullable
              as List<AdModel>,
      userAds: null == userAds
          ? _value.userAds
          : userAds // ignore: cast_nullable_to_non_nullable
              as List<AdModel>,
      payments: null == payments
          ? _value.payments
          : payments // ignore: cast_nullable_to_non_nullable
              as List<PaymentData>,
      selectAds: null == selectAds
          ? _value.selectAds
          : selectAds // ignore: cast_nullable_to_non_nullable
              as int,
      selectPayment: freezed == selectPayment
          ? _value.selectPayment
          : selectPayment // ignore: cast_nullable_to_non_nullable
              as PaymentData?,
      isPaymentLoading: null == isPaymentLoading
          ? _value.isPaymentLoading
          : isPaymentLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isPurchaseLoading: null == isPurchaseLoading
          ? _value.isPurchaseLoading
          : isPurchaseLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AdsStateImplCopyWith<$Res>
    implements $AdsStateCopyWith<$Res> {
  factory _$$AdsStateImplCopyWith(
          _$AdsStateImpl value, $Res Function(_$AdsStateImpl) then) =
      __$$AdsStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<AdModel> adsBanners,
      List<AdModel> userAds,
      List<PaymentData> payments,
      int selectAds,
      PaymentData? selectPayment,
      bool isPaymentLoading,
      bool isPurchaseLoading,
      bool isLoading});
}

/// @nodoc
class __$$AdsStateImplCopyWithImpl<$Res>
    extends _$AdsStateCopyWithImpl<$Res, _$AdsStateImpl>
    implements _$$AdsStateImplCopyWith<$Res> {
  __$$AdsStateImplCopyWithImpl(
      _$AdsStateImpl _value, $Res Function(_$AdsStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of AdsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? adsBanners = null,
    Object? userAds = null,
    Object? payments = null,
    Object? selectAds = null,
    Object? selectPayment = freezed,
    Object? isPaymentLoading = null,
    Object? isPurchaseLoading = null,
    Object? isLoading = null,
  }) {
    return _then(_$AdsStateImpl(
      adsBanners: null == adsBanners
          ? _value._adsBanners
          : adsBanners // ignore: cast_nullable_to_non_nullable
              as List<AdModel>,
      userAds: null == userAds
          ? _value._userAds
          : userAds // ignore: cast_nullable_to_non_nullable
              as List<AdModel>,
      payments: null == payments
          ? _value._payments
          : payments // ignore: cast_nullable_to_non_nullable
              as List<PaymentData>,
      selectAds: null == selectAds
          ? _value.selectAds
          : selectAds // ignore: cast_nullable_to_non_nullable
              as int,
      selectPayment: freezed == selectPayment
          ? _value.selectPayment
          : selectPayment // ignore: cast_nullable_to_non_nullable
              as PaymentData?,
      isPaymentLoading: null == isPaymentLoading
          ? _value.isPaymentLoading
          : isPaymentLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isPurchaseLoading: null == isPurchaseLoading
          ? _value.isPurchaseLoading
          : isPurchaseLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$AdsStateImpl implements _AdsState {
  const _$AdsStateImpl(
      {final List<AdModel> adsBanners = const [],
      final List<AdModel> userAds = const [],
      final List<PaymentData> payments = const [],
      this.selectAds = -1,
      this.selectPayment = null,
      this.isPaymentLoading = true,
      this.isPurchaseLoading = false,
      this.isLoading = true})
      : _adsBanners = adsBanners,
        _userAds = userAds,
        _payments = payments;

  final List<AdModel> _adsBanners;
  @override
  @JsonKey()
  List<AdModel> get adsBanners {
    if (_adsBanners is EqualUnmodifiableListView) return _adsBanners;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_adsBanners);
  }

  final List<AdModel> _userAds;
  @override
  @JsonKey()
  List<AdModel> get userAds {
    if (_userAds is EqualUnmodifiableListView) return _userAds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_userAds);
  }

  final List<PaymentData> _payments;
  @override
  @JsonKey()
  List<PaymentData> get payments {
    if (_payments is EqualUnmodifiableListView) return _payments;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_payments);
  }

  @override
  @JsonKey()
  final int selectAds;
  @override
  @JsonKey()
  final PaymentData? selectPayment;
  @override
  @JsonKey()
  final bool isPaymentLoading;
  @override
  @JsonKey()
  final bool isPurchaseLoading;
  @override
  @JsonKey()
  final bool isLoading;

  @override
  String toString() {
    return 'AdsState(adsBanners: $adsBanners, userAds: $userAds, payments: $payments, selectAds: $selectAds, selectPayment: $selectPayment, isPaymentLoading: $isPaymentLoading, isPurchaseLoading: $isPurchaseLoading, isLoading: $isLoading)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AdsStateImpl &&
            const DeepCollectionEquality()
                .equals(other._adsBanners, _adsBanners) &&
            const DeepCollectionEquality().equals(other._userAds, _userAds) &&
            const DeepCollectionEquality().equals(other._payments, _payments) &&
            (identical(other.selectAds, selectAds) ||
                other.selectAds == selectAds) &&
            (identical(other.selectPayment, selectPayment) ||
                other.selectPayment == selectPayment) &&
            (identical(other.isPaymentLoading, isPaymentLoading) ||
                other.isPaymentLoading == isPaymentLoading) &&
            (identical(other.isPurchaseLoading, isPurchaseLoading) ||
                other.isPurchaseLoading == isPurchaseLoading) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_adsBanners),
      const DeepCollectionEquality().hash(_userAds),
      const DeepCollectionEquality().hash(_payments),
      selectAds,
      selectPayment,
      isPaymentLoading,
      isPurchaseLoading,
      isLoading);

  /// Create a copy of AdsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AdsStateImplCopyWith<_$AdsStateImpl> get copyWith =>
      __$$AdsStateImplCopyWithImpl<_$AdsStateImpl>(this, _$identity);
}

abstract class _AdsState implements AdsState {
  const factory _AdsState(
      {final List<AdModel> adsBanners,
      final List<AdModel> userAds,
      final List<PaymentData> payments,
      final int selectAds,
      final PaymentData? selectPayment,
      final bool isPaymentLoading,
      final bool isPurchaseLoading,
      final bool isLoading}) = _$AdsStateImpl;

  @override
  List<AdModel> get adsBanners;
  @override
  List<AdModel> get userAds;
  @override
  List<PaymentData> get payments;
  @override
  int get selectAds;
  @override
  PaymentData? get selectPayment;
  @override
  bool get isPaymentLoading;
  @override
  bool get isPurchaseLoading;
  @override
  bool get isLoading;

  /// Create a copy of AdsState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AdsStateImplCopyWith<_$AdsStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
