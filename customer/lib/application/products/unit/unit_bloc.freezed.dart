// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'unit_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$UnitEvent {
  BuildContext get context => throw _privateConstructorUsedError;
  bool? get isRefresh => throw _privateConstructorUsedError;
  String? get query => throw _privateConstructorUsedError;
  RefreshController? get controller => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(BuildContext context, bool? isRefresh,
            String? query, RefreshController? controller)
        fetchUnits,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(BuildContext context, bool? isRefresh, String? query,
            RefreshController? controller)?
        fetchUnits,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(BuildContext context, bool? isRefresh, String? query,
            RefreshController? controller)?
        fetchUnits,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(FetchUnits value) fetchUnits,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(FetchUnits value)? fetchUnits,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FetchUnits value)? fetchUnits,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  /// Create a copy of UnitEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UnitEventCopyWith<UnitEvent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UnitEventCopyWith<$Res> {
  factory $UnitEventCopyWith(UnitEvent value, $Res Function(UnitEvent) then) =
      _$UnitEventCopyWithImpl<$Res, UnitEvent>;
  @useResult
  $Res call(
      {BuildContext context,
      bool? isRefresh,
      String? query,
      RefreshController? controller});
}

/// @nodoc
class _$UnitEventCopyWithImpl<$Res, $Val extends UnitEvent>
    implements $UnitEventCopyWith<$Res> {
  _$UnitEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UnitEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? context = null,
    Object? isRefresh = freezed,
    Object? query = freezed,
    Object? controller = freezed,
  }) {
    return _then(_value.copyWith(
      context: null == context
          ? _value.context
          : context // ignore: cast_nullable_to_non_nullable
              as BuildContext,
      isRefresh: freezed == isRefresh
          ? _value.isRefresh
          : isRefresh // ignore: cast_nullable_to_non_nullable
              as bool?,
      query: freezed == query
          ? _value.query
          : query // ignore: cast_nullable_to_non_nullable
              as String?,
      controller: freezed == controller
          ? _value.controller
          : controller // ignore: cast_nullable_to_non_nullable
              as RefreshController?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FetchUnitsImplCopyWith<$Res>
    implements $UnitEventCopyWith<$Res> {
  factory _$$FetchUnitsImplCopyWith(
          _$FetchUnitsImpl value, $Res Function(_$FetchUnitsImpl) then) =
      __$$FetchUnitsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {BuildContext context,
      bool? isRefresh,
      String? query,
      RefreshController? controller});
}

/// @nodoc
class __$$FetchUnitsImplCopyWithImpl<$Res>
    extends _$UnitEventCopyWithImpl<$Res, _$FetchUnitsImpl>
    implements _$$FetchUnitsImplCopyWith<$Res> {
  __$$FetchUnitsImplCopyWithImpl(
      _$FetchUnitsImpl _value, $Res Function(_$FetchUnitsImpl) _then)
      : super(_value, _then);

  /// Create a copy of UnitEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? context = null,
    Object? isRefresh = freezed,
    Object? query = freezed,
    Object? controller = freezed,
  }) {
    return _then(_$FetchUnitsImpl(
      context: null == context
          ? _value.context
          : context // ignore: cast_nullable_to_non_nullable
              as BuildContext,
      isRefresh: freezed == isRefresh
          ? _value.isRefresh
          : isRefresh // ignore: cast_nullable_to_non_nullable
              as bool?,
      query: freezed == query
          ? _value.query
          : query // ignore: cast_nullable_to_non_nullable
              as String?,
      controller: freezed == controller
          ? _value.controller
          : controller // ignore: cast_nullable_to_non_nullable
              as RefreshController?,
    ));
  }
}

/// @nodoc

class _$FetchUnitsImpl implements FetchUnits {
  const _$FetchUnitsImpl(
      {required this.context, this.isRefresh, this.query, this.controller});

  @override
  final BuildContext context;
  @override
  final bool? isRefresh;
  @override
  final String? query;
  @override
  final RefreshController? controller;

  @override
  String toString() {
    return 'UnitEvent.fetchUnits(context: $context, isRefresh: $isRefresh, query: $query, controller: $controller)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FetchUnitsImpl &&
            (identical(other.context, context) || other.context == context) &&
            (identical(other.isRefresh, isRefresh) ||
                other.isRefresh == isRefresh) &&
            (identical(other.query, query) || other.query == query) &&
            (identical(other.controller, controller) ||
                other.controller == controller));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, context, isRefresh, query, controller);

  /// Create a copy of UnitEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FetchUnitsImplCopyWith<_$FetchUnitsImpl> get copyWith =>
      __$$FetchUnitsImplCopyWithImpl<_$FetchUnitsImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(BuildContext context, bool? isRefresh,
            String? query, RefreshController? controller)
        fetchUnits,
  }) {
    return fetchUnits(context, isRefresh, query, controller);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(BuildContext context, bool? isRefresh, String? query,
            RefreshController? controller)?
        fetchUnits,
  }) {
    return fetchUnits?.call(context, isRefresh, query, controller);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(BuildContext context, bool? isRefresh, String? query,
            RefreshController? controller)?
        fetchUnits,
    required TResult orElse(),
  }) {
    if (fetchUnits != null) {
      return fetchUnits(context, isRefresh, query, controller);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(FetchUnits value) fetchUnits,
  }) {
    return fetchUnits(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(FetchUnits value)? fetchUnits,
  }) {
    return fetchUnits?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FetchUnits value)? fetchUnits,
    required TResult orElse(),
  }) {
    if (fetchUnits != null) {
      return fetchUnits(this);
    }
    return orElse();
  }
}

abstract class FetchUnits implements UnitEvent {
  const factory FetchUnits(
      {required final BuildContext context,
      final bool? isRefresh,
      final String? query,
      final RefreshController? controller}) = _$FetchUnitsImpl;

  @override
  BuildContext get context;
  @override
  bool? get isRefresh;
  @override
  String? get query;
  @override
  RefreshController? get controller;

  /// Create a copy of UnitEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FetchUnitsImplCopyWith<_$FetchUnitsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$UnitState {
  List<UnitsData> get units => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;

  /// Create a copy of UnitState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UnitStateCopyWith<UnitState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UnitStateCopyWith<$Res> {
  factory $UnitStateCopyWith(UnitState value, $Res Function(UnitState) then) =
      _$UnitStateCopyWithImpl<$Res, UnitState>;
  @useResult
  $Res call({List<UnitsData> units, bool isLoading});
}

/// @nodoc
class _$UnitStateCopyWithImpl<$Res, $Val extends UnitState>
    implements $UnitStateCopyWith<$Res> {
  _$UnitStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UnitState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? units = null,
    Object? isLoading = null,
  }) {
    return _then(_value.copyWith(
      units: null == units
          ? _value.units
          : units // ignore: cast_nullable_to_non_nullable
              as List<UnitsData>,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UnitStateImplCopyWith<$Res>
    implements $UnitStateCopyWith<$Res> {
  factory _$$UnitStateImplCopyWith(
          _$UnitStateImpl value, $Res Function(_$UnitStateImpl) then) =
      __$$UnitStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<UnitsData> units, bool isLoading});
}

/// @nodoc
class __$$UnitStateImplCopyWithImpl<$Res>
    extends _$UnitStateCopyWithImpl<$Res, _$UnitStateImpl>
    implements _$$UnitStateImplCopyWith<$Res> {
  __$$UnitStateImplCopyWithImpl(
      _$UnitStateImpl _value, $Res Function(_$UnitStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of UnitState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? units = null,
    Object? isLoading = null,
  }) {
    return _then(_$UnitStateImpl(
      units: null == units
          ? _value._units
          : units // ignore: cast_nullable_to_non_nullable
              as List<UnitsData>,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$UnitStateImpl implements _UnitState {
  const _$UnitStateImpl(
      {final List<UnitsData> units = const [], this.isLoading = true})
      : _units = units;

  final List<UnitsData> _units;
  @override
  @JsonKey()
  List<UnitsData> get units {
    if (_units is EqualUnmodifiableListView) return _units;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_units);
  }

  @override
  @JsonKey()
  final bool isLoading;

  @override
  String toString() {
    return 'UnitState(units: $units, isLoading: $isLoading)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UnitStateImpl &&
            const DeepCollectionEquality().equals(other._units, _units) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_units), isLoading);

  /// Create a copy of UnitState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UnitStateImplCopyWith<_$UnitStateImpl> get copyWith =>
      __$$UnitStateImplCopyWithImpl<_$UnitStateImpl>(this, _$identity);
}

abstract class _UnitState implements UnitState {
  const factory _UnitState(
      {final List<UnitsData> units, final bool isLoading}) = _$UnitStateImpl;

  @override
  List<UnitsData> get units;
  @override
  bool get isLoading;

  /// Create a copy of UnitState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UnitStateImplCopyWith<_$UnitStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
