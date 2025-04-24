// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'currency_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$CurrencyEvent {
  BuildContext get context => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(BuildContext context) getCurrency,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(BuildContext context)? getCurrency,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(BuildContext context)? getCurrency,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(GetCurrency value) getCurrency,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(GetCurrency value)? getCurrency,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(GetCurrency value)? getCurrency,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  /// Create a copy of CurrencyEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CurrencyEventCopyWith<CurrencyEvent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CurrencyEventCopyWith<$Res> {
  factory $CurrencyEventCopyWith(
          CurrencyEvent value, $Res Function(CurrencyEvent) then) =
      _$CurrencyEventCopyWithImpl<$Res, CurrencyEvent>;
  @useResult
  $Res call({BuildContext context});
}

/// @nodoc
class _$CurrencyEventCopyWithImpl<$Res, $Val extends CurrencyEvent>
    implements $CurrencyEventCopyWith<$Res> {
  _$CurrencyEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CurrencyEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? context = null,
  }) {
    return _then(_value.copyWith(
      context: null == context
          ? _value.context
          : context // ignore: cast_nullable_to_non_nullable
              as BuildContext,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$GetCurrencyImplCopyWith<$Res>
    implements $CurrencyEventCopyWith<$Res> {
  factory _$$GetCurrencyImplCopyWith(
          _$GetCurrencyImpl value, $Res Function(_$GetCurrencyImpl) then) =
      __$$GetCurrencyImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({BuildContext context});
}

/// @nodoc
class __$$GetCurrencyImplCopyWithImpl<$Res>
    extends _$CurrencyEventCopyWithImpl<$Res, _$GetCurrencyImpl>
    implements _$$GetCurrencyImplCopyWith<$Res> {
  __$$GetCurrencyImplCopyWithImpl(
      _$GetCurrencyImpl _value, $Res Function(_$GetCurrencyImpl) _then)
      : super(_value, _then);

  /// Create a copy of CurrencyEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? context = null,
  }) {
    return _then(_$GetCurrencyImpl(
      context: null == context
          ? _value.context
          : context // ignore: cast_nullable_to_non_nullable
              as BuildContext,
    ));
  }
}

/// @nodoc

class _$GetCurrencyImpl implements GetCurrency {
  const _$GetCurrencyImpl({required this.context});

  @override
  final BuildContext context;

  @override
  String toString() {
    return 'CurrencyEvent.getCurrency(context: $context)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GetCurrencyImpl &&
            (identical(other.context, context) || other.context == context));
  }

  @override
  int get hashCode => Object.hash(runtimeType, context);

  /// Create a copy of CurrencyEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GetCurrencyImplCopyWith<_$GetCurrencyImpl> get copyWith =>
      __$$GetCurrencyImplCopyWithImpl<_$GetCurrencyImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(BuildContext context) getCurrency,
  }) {
    return getCurrency(context);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(BuildContext context)? getCurrency,
  }) {
    return getCurrency?.call(context);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(BuildContext context)? getCurrency,
    required TResult orElse(),
  }) {
    if (getCurrency != null) {
      return getCurrency(context);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(GetCurrency value) getCurrency,
  }) {
    return getCurrency(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(GetCurrency value)? getCurrency,
  }) {
    return getCurrency?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(GetCurrency value)? getCurrency,
    required TResult orElse(),
  }) {
    if (getCurrency != null) {
      return getCurrency(this);
    }
    return orElse();
  }
}

abstract class GetCurrency implements CurrencyEvent {
  const factory GetCurrency({required final BuildContext context}) =
      _$GetCurrencyImpl;

  @override
  BuildContext get context;

  /// Create a copy of CurrencyEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GetCurrencyImplCopyWith<_$GetCurrencyImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$CurrencyState {
  bool get isLoading => throw _privateConstructorUsedError;
  List<CurrencyData> get currency => throw _privateConstructorUsedError;

  /// Create a copy of CurrencyState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CurrencyStateCopyWith<CurrencyState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CurrencyStateCopyWith<$Res> {
  factory $CurrencyStateCopyWith(
          CurrencyState value, $Res Function(CurrencyState) then) =
      _$CurrencyStateCopyWithImpl<$Res, CurrencyState>;
  @useResult
  $Res call({bool isLoading, List<CurrencyData> currency});
}

/// @nodoc
class _$CurrencyStateCopyWithImpl<$Res, $Val extends CurrencyState>
    implements $CurrencyStateCopyWith<$Res> {
  _$CurrencyStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CurrencyState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? currency = null,
  }) {
    return _then(_value.copyWith(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      currency: null == currency
          ? _value.currency
          : currency // ignore: cast_nullable_to_non_nullable
              as List<CurrencyData>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CurrencyStateImplCopyWith<$Res>
    implements $CurrencyStateCopyWith<$Res> {
  factory _$$CurrencyStateImplCopyWith(
          _$CurrencyStateImpl value, $Res Function(_$CurrencyStateImpl) then) =
      __$$CurrencyStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool isLoading, List<CurrencyData> currency});
}

/// @nodoc
class __$$CurrencyStateImplCopyWithImpl<$Res>
    extends _$CurrencyStateCopyWithImpl<$Res, _$CurrencyStateImpl>
    implements _$$CurrencyStateImplCopyWith<$Res> {
  __$$CurrencyStateImplCopyWithImpl(
      _$CurrencyStateImpl _value, $Res Function(_$CurrencyStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of CurrencyState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? currency = null,
  }) {
    return _then(_$CurrencyStateImpl(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      currency: null == currency
          ? _value._currency
          : currency // ignore: cast_nullable_to_non_nullable
              as List<CurrencyData>,
    ));
  }
}

/// @nodoc

class _$CurrencyStateImpl implements _CurrencyState {
  const _$CurrencyStateImpl(
      {this.isLoading = false, final List<CurrencyData> currency = const []})
      : _currency = currency;

  @override
  @JsonKey()
  final bool isLoading;
  final List<CurrencyData> _currency;
  @override
  @JsonKey()
  List<CurrencyData> get currency {
    if (_currency is EqualUnmodifiableListView) return _currency;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_currency);
  }

  @override
  String toString() {
    return 'CurrencyState(isLoading: $isLoading, currency: $currency)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CurrencyStateImpl &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            const DeepCollectionEquality().equals(other._currency, _currency));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, isLoading, const DeepCollectionEquality().hash(_currency));

  /// Create a copy of CurrencyState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CurrencyStateImplCopyWith<_$CurrencyStateImpl> get copyWith =>
      __$$CurrencyStateImplCopyWithImpl<_$CurrencyStateImpl>(this, _$identity);
}

abstract class _CurrencyState implements CurrencyState {
  const factory _CurrencyState(
      {final bool isLoading,
      final List<CurrencyData> currency}) = _$CurrencyStateImpl;

  @override
  bool get isLoading;
  @override
  List<CurrencyData> get currency;

  /// Create a copy of CurrencyState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CurrencyStateImplCopyWith<_$CurrencyStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
