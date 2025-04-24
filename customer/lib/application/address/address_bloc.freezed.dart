// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'address_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$AddressEvent {
  BuildContext get context => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(BuildContext context, bool? isRefresh,
            RefreshController? controller)
        fetchCountry,
    required TResult Function(BuildContext context, String? search)
        searchCountry,
    required TResult Function(BuildContext context, int? countyId,
            bool? isRefresh, RefreshController? controller)
        fetchCity,
    required TResult Function(
            BuildContext context, int? countyId, String? search)
        searchCity,
    required TResult Function(BuildContext context, int? cityId,
            bool? isRefresh, RefreshController? controller)
        fetchArea,
    required TResult Function(BuildContext context, int? cityId, String? search)
        searchArea,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(BuildContext context, bool? isRefresh,
            RefreshController? controller)?
        fetchCountry,
    TResult? Function(BuildContext context, String? search)? searchCountry,
    TResult? Function(BuildContext context, int? countyId, bool? isRefresh,
            RefreshController? controller)?
        fetchCity,
    TResult? Function(BuildContext context, int? countyId, String? search)?
        searchCity,
    TResult? Function(BuildContext context, int? cityId, bool? isRefresh,
            RefreshController? controller)?
        fetchArea,
    TResult? Function(BuildContext context, int? cityId, String? search)?
        searchArea,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(BuildContext context, bool? isRefresh,
            RefreshController? controller)?
        fetchCountry,
    TResult Function(BuildContext context, String? search)? searchCountry,
    TResult Function(BuildContext context, int? countyId, bool? isRefresh,
            RefreshController? controller)?
        fetchCity,
    TResult Function(BuildContext context, int? countyId, String? search)?
        searchCity,
    TResult Function(BuildContext context, int? cityId, bool? isRefresh,
            RefreshController? controller)?
        fetchArea,
    TResult Function(BuildContext context, int? cityId, String? search)?
        searchArea,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(FetchCountry value) fetchCountry,
    required TResult Function(SearchCountry value) searchCountry,
    required TResult Function(FetchCity value) fetchCity,
    required TResult Function(SearchCity value) searchCity,
    required TResult Function(FetchArea value) fetchArea,
    required TResult Function(SearchArea value) searchArea,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(FetchCountry value)? fetchCountry,
    TResult? Function(SearchCountry value)? searchCountry,
    TResult? Function(FetchCity value)? fetchCity,
    TResult? Function(SearchCity value)? searchCity,
    TResult? Function(FetchArea value)? fetchArea,
    TResult? Function(SearchArea value)? searchArea,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FetchCountry value)? fetchCountry,
    TResult Function(SearchCountry value)? searchCountry,
    TResult Function(FetchCity value)? fetchCity,
    TResult Function(SearchCity value)? searchCity,
    TResult Function(FetchArea value)? fetchArea,
    TResult Function(SearchArea value)? searchArea,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  /// Create a copy of AddressEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AddressEventCopyWith<AddressEvent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AddressEventCopyWith<$Res> {
  factory $AddressEventCopyWith(
          AddressEvent value, $Res Function(AddressEvent) then) =
      _$AddressEventCopyWithImpl<$Res, AddressEvent>;
  @useResult
  $Res call({BuildContext context});
}

/// @nodoc
class _$AddressEventCopyWithImpl<$Res, $Val extends AddressEvent>
    implements $AddressEventCopyWith<$Res> {
  _$AddressEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AddressEvent
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
abstract class _$$FetchCountryImplCopyWith<$Res>
    implements $AddressEventCopyWith<$Res> {
  factory _$$FetchCountryImplCopyWith(
          _$FetchCountryImpl value, $Res Function(_$FetchCountryImpl) then) =
      __$$FetchCountryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {BuildContext context, bool? isRefresh, RefreshController? controller});
}

/// @nodoc
class __$$FetchCountryImplCopyWithImpl<$Res>
    extends _$AddressEventCopyWithImpl<$Res, _$FetchCountryImpl>
    implements _$$FetchCountryImplCopyWith<$Res> {
  __$$FetchCountryImplCopyWithImpl(
      _$FetchCountryImpl _value, $Res Function(_$FetchCountryImpl) _then)
      : super(_value, _then);

  /// Create a copy of AddressEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? context = null,
    Object? isRefresh = freezed,
    Object? controller = freezed,
  }) {
    return _then(_$FetchCountryImpl(
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

class _$FetchCountryImpl implements FetchCountry {
  const _$FetchCountryImpl(
      {required this.context, this.isRefresh, this.controller});

  @override
  final BuildContext context;
  @override
  final bool? isRefresh;
  @override
  final RefreshController? controller;

  @override
  String toString() {
    return 'AddressEvent.fetchCountry(context: $context, isRefresh: $isRefresh, controller: $controller)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FetchCountryImpl &&
            (identical(other.context, context) || other.context == context) &&
            (identical(other.isRefresh, isRefresh) ||
                other.isRefresh == isRefresh) &&
            (identical(other.controller, controller) ||
                other.controller == controller));
  }

  @override
  int get hashCode => Object.hash(runtimeType, context, isRefresh, controller);

  /// Create a copy of AddressEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FetchCountryImplCopyWith<_$FetchCountryImpl> get copyWith =>
      __$$FetchCountryImplCopyWithImpl<_$FetchCountryImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(BuildContext context, bool? isRefresh,
            RefreshController? controller)
        fetchCountry,
    required TResult Function(BuildContext context, String? search)
        searchCountry,
    required TResult Function(BuildContext context, int? countyId,
            bool? isRefresh, RefreshController? controller)
        fetchCity,
    required TResult Function(
            BuildContext context, int? countyId, String? search)
        searchCity,
    required TResult Function(BuildContext context, int? cityId,
            bool? isRefresh, RefreshController? controller)
        fetchArea,
    required TResult Function(BuildContext context, int? cityId, String? search)
        searchArea,
  }) {
    return fetchCountry(context, isRefresh, controller);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(BuildContext context, bool? isRefresh,
            RefreshController? controller)?
        fetchCountry,
    TResult? Function(BuildContext context, String? search)? searchCountry,
    TResult? Function(BuildContext context, int? countyId, bool? isRefresh,
            RefreshController? controller)?
        fetchCity,
    TResult? Function(BuildContext context, int? countyId, String? search)?
        searchCity,
    TResult? Function(BuildContext context, int? cityId, bool? isRefresh,
            RefreshController? controller)?
        fetchArea,
    TResult? Function(BuildContext context, int? cityId, String? search)?
        searchArea,
  }) {
    return fetchCountry?.call(context, isRefresh, controller);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(BuildContext context, bool? isRefresh,
            RefreshController? controller)?
        fetchCountry,
    TResult Function(BuildContext context, String? search)? searchCountry,
    TResult Function(BuildContext context, int? countyId, bool? isRefresh,
            RefreshController? controller)?
        fetchCity,
    TResult Function(BuildContext context, int? countyId, String? search)?
        searchCity,
    TResult Function(BuildContext context, int? cityId, bool? isRefresh,
            RefreshController? controller)?
        fetchArea,
    TResult Function(BuildContext context, int? cityId, String? search)?
        searchArea,
    required TResult orElse(),
  }) {
    if (fetchCountry != null) {
      return fetchCountry(context, isRefresh, controller);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(FetchCountry value) fetchCountry,
    required TResult Function(SearchCountry value) searchCountry,
    required TResult Function(FetchCity value) fetchCity,
    required TResult Function(SearchCity value) searchCity,
    required TResult Function(FetchArea value) fetchArea,
    required TResult Function(SearchArea value) searchArea,
  }) {
    return fetchCountry(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(FetchCountry value)? fetchCountry,
    TResult? Function(SearchCountry value)? searchCountry,
    TResult? Function(FetchCity value)? fetchCity,
    TResult? Function(SearchCity value)? searchCity,
    TResult? Function(FetchArea value)? fetchArea,
    TResult? Function(SearchArea value)? searchArea,
  }) {
    return fetchCountry?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FetchCountry value)? fetchCountry,
    TResult Function(SearchCountry value)? searchCountry,
    TResult Function(FetchCity value)? fetchCity,
    TResult Function(SearchCity value)? searchCity,
    TResult Function(FetchArea value)? fetchArea,
    TResult Function(SearchArea value)? searchArea,
    required TResult orElse(),
  }) {
    if (fetchCountry != null) {
      return fetchCountry(this);
    }
    return orElse();
  }
}

abstract class FetchCountry implements AddressEvent {
  const factory FetchCountry(
      {required final BuildContext context,
      final bool? isRefresh,
      final RefreshController? controller}) = _$FetchCountryImpl;

  @override
  BuildContext get context;
  bool? get isRefresh;
  RefreshController? get controller;

  /// Create a copy of AddressEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FetchCountryImplCopyWith<_$FetchCountryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SearchCountryImplCopyWith<$Res>
    implements $AddressEventCopyWith<$Res> {
  factory _$$SearchCountryImplCopyWith(
          _$SearchCountryImpl value, $Res Function(_$SearchCountryImpl) then) =
      __$$SearchCountryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({BuildContext context, String? search});
}

/// @nodoc
class __$$SearchCountryImplCopyWithImpl<$Res>
    extends _$AddressEventCopyWithImpl<$Res, _$SearchCountryImpl>
    implements _$$SearchCountryImplCopyWith<$Res> {
  __$$SearchCountryImplCopyWithImpl(
      _$SearchCountryImpl _value, $Res Function(_$SearchCountryImpl) _then)
      : super(_value, _then);

  /// Create a copy of AddressEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? context = null,
    Object? search = freezed,
  }) {
    return _then(_$SearchCountryImpl(
      context: null == context
          ? _value.context
          : context // ignore: cast_nullable_to_non_nullable
              as BuildContext,
      search: freezed == search
          ? _value.search
          : search // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$SearchCountryImpl implements SearchCountry {
  const _$SearchCountryImpl({required this.context, this.search});

  @override
  final BuildContext context;
  @override
  final String? search;

  @override
  String toString() {
    return 'AddressEvent.searchCountry(context: $context, search: $search)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SearchCountryImpl &&
            (identical(other.context, context) || other.context == context) &&
            (identical(other.search, search) || other.search == search));
  }

  @override
  int get hashCode => Object.hash(runtimeType, context, search);

  /// Create a copy of AddressEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SearchCountryImplCopyWith<_$SearchCountryImpl> get copyWith =>
      __$$SearchCountryImplCopyWithImpl<_$SearchCountryImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(BuildContext context, bool? isRefresh,
            RefreshController? controller)
        fetchCountry,
    required TResult Function(BuildContext context, String? search)
        searchCountry,
    required TResult Function(BuildContext context, int? countyId,
            bool? isRefresh, RefreshController? controller)
        fetchCity,
    required TResult Function(
            BuildContext context, int? countyId, String? search)
        searchCity,
    required TResult Function(BuildContext context, int? cityId,
            bool? isRefresh, RefreshController? controller)
        fetchArea,
    required TResult Function(BuildContext context, int? cityId, String? search)
        searchArea,
  }) {
    return searchCountry(context, search);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(BuildContext context, bool? isRefresh,
            RefreshController? controller)?
        fetchCountry,
    TResult? Function(BuildContext context, String? search)? searchCountry,
    TResult? Function(BuildContext context, int? countyId, bool? isRefresh,
            RefreshController? controller)?
        fetchCity,
    TResult? Function(BuildContext context, int? countyId, String? search)?
        searchCity,
    TResult? Function(BuildContext context, int? cityId, bool? isRefresh,
            RefreshController? controller)?
        fetchArea,
    TResult? Function(BuildContext context, int? cityId, String? search)?
        searchArea,
  }) {
    return searchCountry?.call(context, search);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(BuildContext context, bool? isRefresh,
            RefreshController? controller)?
        fetchCountry,
    TResult Function(BuildContext context, String? search)? searchCountry,
    TResult Function(BuildContext context, int? countyId, bool? isRefresh,
            RefreshController? controller)?
        fetchCity,
    TResult Function(BuildContext context, int? countyId, String? search)?
        searchCity,
    TResult Function(BuildContext context, int? cityId, bool? isRefresh,
            RefreshController? controller)?
        fetchArea,
    TResult Function(BuildContext context, int? cityId, String? search)?
        searchArea,
    required TResult orElse(),
  }) {
    if (searchCountry != null) {
      return searchCountry(context, search);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(FetchCountry value) fetchCountry,
    required TResult Function(SearchCountry value) searchCountry,
    required TResult Function(FetchCity value) fetchCity,
    required TResult Function(SearchCity value) searchCity,
    required TResult Function(FetchArea value) fetchArea,
    required TResult Function(SearchArea value) searchArea,
  }) {
    return searchCountry(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(FetchCountry value)? fetchCountry,
    TResult? Function(SearchCountry value)? searchCountry,
    TResult? Function(FetchCity value)? fetchCity,
    TResult? Function(SearchCity value)? searchCity,
    TResult? Function(FetchArea value)? fetchArea,
    TResult? Function(SearchArea value)? searchArea,
  }) {
    return searchCountry?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FetchCountry value)? fetchCountry,
    TResult Function(SearchCountry value)? searchCountry,
    TResult Function(FetchCity value)? fetchCity,
    TResult Function(SearchCity value)? searchCity,
    TResult Function(FetchArea value)? fetchArea,
    TResult Function(SearchArea value)? searchArea,
    required TResult orElse(),
  }) {
    if (searchCountry != null) {
      return searchCountry(this);
    }
    return orElse();
  }
}

abstract class SearchCountry implements AddressEvent {
  const factory SearchCountry(
      {required final BuildContext context,
      final String? search}) = _$SearchCountryImpl;

  @override
  BuildContext get context;
  String? get search;

  /// Create a copy of AddressEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SearchCountryImplCopyWith<_$SearchCountryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$FetchCityImplCopyWith<$Res>
    implements $AddressEventCopyWith<$Res> {
  factory _$$FetchCityImplCopyWith(
          _$FetchCityImpl value, $Res Function(_$FetchCityImpl) then) =
      __$$FetchCityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {BuildContext context,
      int? countyId,
      bool? isRefresh,
      RefreshController? controller});
}

/// @nodoc
class __$$FetchCityImplCopyWithImpl<$Res>
    extends _$AddressEventCopyWithImpl<$Res, _$FetchCityImpl>
    implements _$$FetchCityImplCopyWith<$Res> {
  __$$FetchCityImplCopyWithImpl(
      _$FetchCityImpl _value, $Res Function(_$FetchCityImpl) _then)
      : super(_value, _then);

  /// Create a copy of AddressEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? context = null,
    Object? countyId = freezed,
    Object? isRefresh = freezed,
    Object? controller = freezed,
  }) {
    return _then(_$FetchCityImpl(
      context: null == context
          ? _value.context
          : context // ignore: cast_nullable_to_non_nullable
              as BuildContext,
      countyId: freezed == countyId
          ? _value.countyId
          : countyId // ignore: cast_nullable_to_non_nullable
              as int?,
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

class _$FetchCityImpl implements FetchCity {
  const _$FetchCityImpl(
      {required this.context,
      required this.countyId,
      this.isRefresh,
      this.controller});

  @override
  final BuildContext context;
  @override
  final int? countyId;
  @override
  final bool? isRefresh;
  @override
  final RefreshController? controller;

  @override
  String toString() {
    return 'AddressEvent.fetchCity(context: $context, countyId: $countyId, isRefresh: $isRefresh, controller: $controller)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FetchCityImpl &&
            (identical(other.context, context) || other.context == context) &&
            (identical(other.countyId, countyId) ||
                other.countyId == countyId) &&
            (identical(other.isRefresh, isRefresh) ||
                other.isRefresh == isRefresh) &&
            (identical(other.controller, controller) ||
                other.controller == controller));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, context, countyId, isRefresh, controller);

  /// Create a copy of AddressEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FetchCityImplCopyWith<_$FetchCityImpl> get copyWith =>
      __$$FetchCityImplCopyWithImpl<_$FetchCityImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(BuildContext context, bool? isRefresh,
            RefreshController? controller)
        fetchCountry,
    required TResult Function(BuildContext context, String? search)
        searchCountry,
    required TResult Function(BuildContext context, int? countyId,
            bool? isRefresh, RefreshController? controller)
        fetchCity,
    required TResult Function(
            BuildContext context, int? countyId, String? search)
        searchCity,
    required TResult Function(BuildContext context, int? cityId,
            bool? isRefresh, RefreshController? controller)
        fetchArea,
    required TResult Function(BuildContext context, int? cityId, String? search)
        searchArea,
  }) {
    return fetchCity(context, countyId, isRefresh, controller);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(BuildContext context, bool? isRefresh,
            RefreshController? controller)?
        fetchCountry,
    TResult? Function(BuildContext context, String? search)? searchCountry,
    TResult? Function(BuildContext context, int? countyId, bool? isRefresh,
            RefreshController? controller)?
        fetchCity,
    TResult? Function(BuildContext context, int? countyId, String? search)?
        searchCity,
    TResult? Function(BuildContext context, int? cityId, bool? isRefresh,
            RefreshController? controller)?
        fetchArea,
    TResult? Function(BuildContext context, int? cityId, String? search)?
        searchArea,
  }) {
    return fetchCity?.call(context, countyId, isRefresh, controller);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(BuildContext context, bool? isRefresh,
            RefreshController? controller)?
        fetchCountry,
    TResult Function(BuildContext context, String? search)? searchCountry,
    TResult Function(BuildContext context, int? countyId, bool? isRefresh,
            RefreshController? controller)?
        fetchCity,
    TResult Function(BuildContext context, int? countyId, String? search)?
        searchCity,
    TResult Function(BuildContext context, int? cityId, bool? isRefresh,
            RefreshController? controller)?
        fetchArea,
    TResult Function(BuildContext context, int? cityId, String? search)?
        searchArea,
    required TResult orElse(),
  }) {
    if (fetchCity != null) {
      return fetchCity(context, countyId, isRefresh, controller);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(FetchCountry value) fetchCountry,
    required TResult Function(SearchCountry value) searchCountry,
    required TResult Function(FetchCity value) fetchCity,
    required TResult Function(SearchCity value) searchCity,
    required TResult Function(FetchArea value) fetchArea,
    required TResult Function(SearchArea value) searchArea,
  }) {
    return fetchCity(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(FetchCountry value)? fetchCountry,
    TResult? Function(SearchCountry value)? searchCountry,
    TResult? Function(FetchCity value)? fetchCity,
    TResult? Function(SearchCity value)? searchCity,
    TResult? Function(FetchArea value)? fetchArea,
    TResult? Function(SearchArea value)? searchArea,
  }) {
    return fetchCity?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FetchCountry value)? fetchCountry,
    TResult Function(SearchCountry value)? searchCountry,
    TResult Function(FetchCity value)? fetchCity,
    TResult Function(SearchCity value)? searchCity,
    TResult Function(FetchArea value)? fetchArea,
    TResult Function(SearchArea value)? searchArea,
    required TResult orElse(),
  }) {
    if (fetchCity != null) {
      return fetchCity(this);
    }
    return orElse();
  }
}

abstract class FetchCity implements AddressEvent {
  const factory FetchCity(
      {required final BuildContext context,
      required final int? countyId,
      final bool? isRefresh,
      final RefreshController? controller}) = _$FetchCityImpl;

  @override
  BuildContext get context;
  int? get countyId;
  bool? get isRefresh;
  RefreshController? get controller;

  /// Create a copy of AddressEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FetchCityImplCopyWith<_$FetchCityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SearchCityImplCopyWith<$Res>
    implements $AddressEventCopyWith<$Res> {
  factory _$$SearchCityImplCopyWith(
          _$SearchCityImpl value, $Res Function(_$SearchCityImpl) then) =
      __$$SearchCityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({BuildContext context, int? countyId, String? search});
}

/// @nodoc
class __$$SearchCityImplCopyWithImpl<$Res>
    extends _$AddressEventCopyWithImpl<$Res, _$SearchCityImpl>
    implements _$$SearchCityImplCopyWith<$Res> {
  __$$SearchCityImplCopyWithImpl(
      _$SearchCityImpl _value, $Res Function(_$SearchCityImpl) _then)
      : super(_value, _then);

  /// Create a copy of AddressEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? context = null,
    Object? countyId = freezed,
    Object? search = freezed,
  }) {
    return _then(_$SearchCityImpl(
      context: null == context
          ? _value.context
          : context // ignore: cast_nullable_to_non_nullable
              as BuildContext,
      countyId: freezed == countyId
          ? _value.countyId
          : countyId // ignore: cast_nullable_to_non_nullable
              as int?,
      search: freezed == search
          ? _value.search
          : search // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$SearchCityImpl implements SearchCity {
  const _$SearchCityImpl(
      {required this.context, required this.countyId, this.search});

  @override
  final BuildContext context;
  @override
  final int? countyId;
  @override
  final String? search;

  @override
  String toString() {
    return 'AddressEvent.searchCity(context: $context, countyId: $countyId, search: $search)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SearchCityImpl &&
            (identical(other.context, context) || other.context == context) &&
            (identical(other.countyId, countyId) ||
                other.countyId == countyId) &&
            (identical(other.search, search) || other.search == search));
  }

  @override
  int get hashCode => Object.hash(runtimeType, context, countyId, search);

  /// Create a copy of AddressEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SearchCityImplCopyWith<_$SearchCityImpl> get copyWith =>
      __$$SearchCityImplCopyWithImpl<_$SearchCityImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(BuildContext context, bool? isRefresh,
            RefreshController? controller)
        fetchCountry,
    required TResult Function(BuildContext context, String? search)
        searchCountry,
    required TResult Function(BuildContext context, int? countyId,
            bool? isRefresh, RefreshController? controller)
        fetchCity,
    required TResult Function(
            BuildContext context, int? countyId, String? search)
        searchCity,
    required TResult Function(BuildContext context, int? cityId,
            bool? isRefresh, RefreshController? controller)
        fetchArea,
    required TResult Function(BuildContext context, int? cityId, String? search)
        searchArea,
  }) {
    return searchCity(context, countyId, search);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(BuildContext context, bool? isRefresh,
            RefreshController? controller)?
        fetchCountry,
    TResult? Function(BuildContext context, String? search)? searchCountry,
    TResult? Function(BuildContext context, int? countyId, bool? isRefresh,
            RefreshController? controller)?
        fetchCity,
    TResult? Function(BuildContext context, int? countyId, String? search)?
        searchCity,
    TResult? Function(BuildContext context, int? cityId, bool? isRefresh,
            RefreshController? controller)?
        fetchArea,
    TResult? Function(BuildContext context, int? cityId, String? search)?
        searchArea,
  }) {
    return searchCity?.call(context, countyId, search);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(BuildContext context, bool? isRefresh,
            RefreshController? controller)?
        fetchCountry,
    TResult Function(BuildContext context, String? search)? searchCountry,
    TResult Function(BuildContext context, int? countyId, bool? isRefresh,
            RefreshController? controller)?
        fetchCity,
    TResult Function(BuildContext context, int? countyId, String? search)?
        searchCity,
    TResult Function(BuildContext context, int? cityId, bool? isRefresh,
            RefreshController? controller)?
        fetchArea,
    TResult Function(BuildContext context, int? cityId, String? search)?
        searchArea,
    required TResult orElse(),
  }) {
    if (searchCity != null) {
      return searchCity(context, countyId, search);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(FetchCountry value) fetchCountry,
    required TResult Function(SearchCountry value) searchCountry,
    required TResult Function(FetchCity value) fetchCity,
    required TResult Function(SearchCity value) searchCity,
    required TResult Function(FetchArea value) fetchArea,
    required TResult Function(SearchArea value) searchArea,
  }) {
    return searchCity(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(FetchCountry value)? fetchCountry,
    TResult? Function(SearchCountry value)? searchCountry,
    TResult? Function(FetchCity value)? fetchCity,
    TResult? Function(SearchCity value)? searchCity,
    TResult? Function(FetchArea value)? fetchArea,
    TResult? Function(SearchArea value)? searchArea,
  }) {
    return searchCity?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FetchCountry value)? fetchCountry,
    TResult Function(SearchCountry value)? searchCountry,
    TResult Function(FetchCity value)? fetchCity,
    TResult Function(SearchCity value)? searchCity,
    TResult Function(FetchArea value)? fetchArea,
    TResult Function(SearchArea value)? searchArea,
    required TResult orElse(),
  }) {
    if (searchCity != null) {
      return searchCity(this);
    }
    return orElse();
  }
}

abstract class SearchCity implements AddressEvent {
  const factory SearchCity(
      {required final BuildContext context,
      required final int? countyId,
      final String? search}) = _$SearchCityImpl;

  @override
  BuildContext get context;
  int? get countyId;
  String? get search;

  /// Create a copy of AddressEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SearchCityImplCopyWith<_$SearchCityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$FetchAreaImplCopyWith<$Res>
    implements $AddressEventCopyWith<$Res> {
  factory _$$FetchAreaImplCopyWith(
          _$FetchAreaImpl value, $Res Function(_$FetchAreaImpl) then) =
      __$$FetchAreaImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {BuildContext context,
      int? cityId,
      bool? isRefresh,
      RefreshController? controller});
}

/// @nodoc
class __$$FetchAreaImplCopyWithImpl<$Res>
    extends _$AddressEventCopyWithImpl<$Res, _$FetchAreaImpl>
    implements _$$FetchAreaImplCopyWith<$Res> {
  __$$FetchAreaImplCopyWithImpl(
      _$FetchAreaImpl _value, $Res Function(_$FetchAreaImpl) _then)
      : super(_value, _then);

  /// Create a copy of AddressEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? context = null,
    Object? cityId = freezed,
    Object? isRefresh = freezed,
    Object? controller = freezed,
  }) {
    return _then(_$FetchAreaImpl(
      context: null == context
          ? _value.context
          : context // ignore: cast_nullable_to_non_nullable
              as BuildContext,
      cityId: freezed == cityId
          ? _value.cityId
          : cityId // ignore: cast_nullable_to_non_nullable
              as int?,
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

class _$FetchAreaImpl implements FetchArea {
  const _$FetchAreaImpl(
      {required this.context,
      required this.cityId,
      this.isRefresh,
      this.controller});

  @override
  final BuildContext context;
  @override
  final int? cityId;
  @override
  final bool? isRefresh;
  @override
  final RefreshController? controller;

  @override
  String toString() {
    return 'AddressEvent.fetchArea(context: $context, cityId: $cityId, isRefresh: $isRefresh, controller: $controller)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FetchAreaImpl &&
            (identical(other.context, context) || other.context == context) &&
            (identical(other.cityId, cityId) || other.cityId == cityId) &&
            (identical(other.isRefresh, isRefresh) ||
                other.isRefresh == isRefresh) &&
            (identical(other.controller, controller) ||
                other.controller == controller));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, context, cityId, isRefresh, controller);

  /// Create a copy of AddressEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FetchAreaImplCopyWith<_$FetchAreaImpl> get copyWith =>
      __$$FetchAreaImplCopyWithImpl<_$FetchAreaImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(BuildContext context, bool? isRefresh,
            RefreshController? controller)
        fetchCountry,
    required TResult Function(BuildContext context, String? search)
        searchCountry,
    required TResult Function(BuildContext context, int? countyId,
            bool? isRefresh, RefreshController? controller)
        fetchCity,
    required TResult Function(
            BuildContext context, int? countyId, String? search)
        searchCity,
    required TResult Function(BuildContext context, int? cityId,
            bool? isRefresh, RefreshController? controller)
        fetchArea,
    required TResult Function(BuildContext context, int? cityId, String? search)
        searchArea,
  }) {
    return fetchArea(context, cityId, isRefresh, controller);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(BuildContext context, bool? isRefresh,
            RefreshController? controller)?
        fetchCountry,
    TResult? Function(BuildContext context, String? search)? searchCountry,
    TResult? Function(BuildContext context, int? countyId, bool? isRefresh,
            RefreshController? controller)?
        fetchCity,
    TResult? Function(BuildContext context, int? countyId, String? search)?
        searchCity,
    TResult? Function(BuildContext context, int? cityId, bool? isRefresh,
            RefreshController? controller)?
        fetchArea,
    TResult? Function(BuildContext context, int? cityId, String? search)?
        searchArea,
  }) {
    return fetchArea?.call(context, cityId, isRefresh, controller);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(BuildContext context, bool? isRefresh,
            RefreshController? controller)?
        fetchCountry,
    TResult Function(BuildContext context, String? search)? searchCountry,
    TResult Function(BuildContext context, int? countyId, bool? isRefresh,
            RefreshController? controller)?
        fetchCity,
    TResult Function(BuildContext context, int? countyId, String? search)?
        searchCity,
    TResult Function(BuildContext context, int? cityId, bool? isRefresh,
            RefreshController? controller)?
        fetchArea,
    TResult Function(BuildContext context, int? cityId, String? search)?
        searchArea,
    required TResult orElse(),
  }) {
    if (fetchArea != null) {
      return fetchArea(context, cityId, isRefresh, controller);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(FetchCountry value) fetchCountry,
    required TResult Function(SearchCountry value) searchCountry,
    required TResult Function(FetchCity value) fetchCity,
    required TResult Function(SearchCity value) searchCity,
    required TResult Function(FetchArea value) fetchArea,
    required TResult Function(SearchArea value) searchArea,
  }) {
    return fetchArea(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(FetchCountry value)? fetchCountry,
    TResult? Function(SearchCountry value)? searchCountry,
    TResult? Function(FetchCity value)? fetchCity,
    TResult? Function(SearchCity value)? searchCity,
    TResult? Function(FetchArea value)? fetchArea,
    TResult? Function(SearchArea value)? searchArea,
  }) {
    return fetchArea?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FetchCountry value)? fetchCountry,
    TResult Function(SearchCountry value)? searchCountry,
    TResult Function(FetchCity value)? fetchCity,
    TResult Function(SearchCity value)? searchCity,
    TResult Function(FetchArea value)? fetchArea,
    TResult Function(SearchArea value)? searchArea,
    required TResult orElse(),
  }) {
    if (fetchArea != null) {
      return fetchArea(this);
    }
    return orElse();
  }
}

abstract class FetchArea implements AddressEvent {
  const factory FetchArea(
      {required final BuildContext context,
      required final int? cityId,
      final bool? isRefresh,
      final RefreshController? controller}) = _$FetchAreaImpl;

  @override
  BuildContext get context;
  int? get cityId;
  bool? get isRefresh;
  RefreshController? get controller;

  /// Create a copy of AddressEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FetchAreaImplCopyWith<_$FetchAreaImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SearchAreaImplCopyWith<$Res>
    implements $AddressEventCopyWith<$Res> {
  factory _$$SearchAreaImplCopyWith(
          _$SearchAreaImpl value, $Res Function(_$SearchAreaImpl) then) =
      __$$SearchAreaImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({BuildContext context, int? cityId, String? search});
}

/// @nodoc
class __$$SearchAreaImplCopyWithImpl<$Res>
    extends _$AddressEventCopyWithImpl<$Res, _$SearchAreaImpl>
    implements _$$SearchAreaImplCopyWith<$Res> {
  __$$SearchAreaImplCopyWithImpl(
      _$SearchAreaImpl _value, $Res Function(_$SearchAreaImpl) _then)
      : super(_value, _then);

  /// Create a copy of AddressEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? context = null,
    Object? cityId = freezed,
    Object? search = freezed,
  }) {
    return _then(_$SearchAreaImpl(
      context: null == context
          ? _value.context
          : context // ignore: cast_nullable_to_non_nullable
              as BuildContext,
      cityId: freezed == cityId
          ? _value.cityId
          : cityId // ignore: cast_nullable_to_non_nullable
              as int?,
      search: freezed == search
          ? _value.search
          : search // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$SearchAreaImpl implements SearchArea {
  const _$SearchAreaImpl(
      {required this.context, required this.cityId, this.search});

  @override
  final BuildContext context;
  @override
  final int? cityId;
  @override
  final String? search;

  @override
  String toString() {
    return 'AddressEvent.searchArea(context: $context, cityId: $cityId, search: $search)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SearchAreaImpl &&
            (identical(other.context, context) || other.context == context) &&
            (identical(other.cityId, cityId) || other.cityId == cityId) &&
            (identical(other.search, search) || other.search == search));
  }

  @override
  int get hashCode => Object.hash(runtimeType, context, cityId, search);

  /// Create a copy of AddressEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SearchAreaImplCopyWith<_$SearchAreaImpl> get copyWith =>
      __$$SearchAreaImplCopyWithImpl<_$SearchAreaImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(BuildContext context, bool? isRefresh,
            RefreshController? controller)
        fetchCountry,
    required TResult Function(BuildContext context, String? search)
        searchCountry,
    required TResult Function(BuildContext context, int? countyId,
            bool? isRefresh, RefreshController? controller)
        fetchCity,
    required TResult Function(
            BuildContext context, int? countyId, String? search)
        searchCity,
    required TResult Function(BuildContext context, int? cityId,
            bool? isRefresh, RefreshController? controller)
        fetchArea,
    required TResult Function(BuildContext context, int? cityId, String? search)
        searchArea,
  }) {
    return searchArea(context, cityId, search);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(BuildContext context, bool? isRefresh,
            RefreshController? controller)?
        fetchCountry,
    TResult? Function(BuildContext context, String? search)? searchCountry,
    TResult? Function(BuildContext context, int? countyId, bool? isRefresh,
            RefreshController? controller)?
        fetchCity,
    TResult? Function(BuildContext context, int? countyId, String? search)?
        searchCity,
    TResult? Function(BuildContext context, int? cityId, bool? isRefresh,
            RefreshController? controller)?
        fetchArea,
    TResult? Function(BuildContext context, int? cityId, String? search)?
        searchArea,
  }) {
    return searchArea?.call(context, cityId, search);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(BuildContext context, bool? isRefresh,
            RefreshController? controller)?
        fetchCountry,
    TResult Function(BuildContext context, String? search)? searchCountry,
    TResult Function(BuildContext context, int? countyId, bool? isRefresh,
            RefreshController? controller)?
        fetchCity,
    TResult Function(BuildContext context, int? countyId, String? search)?
        searchCity,
    TResult Function(BuildContext context, int? cityId, bool? isRefresh,
            RefreshController? controller)?
        fetchArea,
    TResult Function(BuildContext context, int? cityId, String? search)?
        searchArea,
    required TResult orElse(),
  }) {
    if (searchArea != null) {
      return searchArea(context, cityId, search);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(FetchCountry value) fetchCountry,
    required TResult Function(SearchCountry value) searchCountry,
    required TResult Function(FetchCity value) fetchCity,
    required TResult Function(SearchCity value) searchCity,
    required TResult Function(FetchArea value) fetchArea,
    required TResult Function(SearchArea value) searchArea,
  }) {
    return searchArea(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(FetchCountry value)? fetchCountry,
    TResult? Function(SearchCountry value)? searchCountry,
    TResult? Function(FetchCity value)? fetchCity,
    TResult? Function(SearchCity value)? searchCity,
    TResult? Function(FetchArea value)? fetchArea,
    TResult? Function(SearchArea value)? searchArea,
  }) {
    return searchArea?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FetchCountry value)? fetchCountry,
    TResult Function(SearchCountry value)? searchCountry,
    TResult Function(FetchCity value)? fetchCity,
    TResult Function(SearchCity value)? searchCity,
    TResult Function(FetchArea value)? fetchArea,
    TResult Function(SearchArea value)? searchArea,
    required TResult orElse(),
  }) {
    if (searchArea != null) {
      return searchArea(this);
    }
    return orElse();
  }
}

abstract class SearchArea implements AddressEvent {
  const factory SearchArea(
      {required final BuildContext context,
      required final int? cityId,
      final String? search}) = _$SearchAreaImpl;

  @override
  BuildContext get context;
  int? get cityId;
  String? get search;

  /// Create a copy of AddressEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SearchAreaImplCopyWith<_$SearchAreaImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$AddressState {
  List<CountryModel> get countries => throw _privateConstructorUsedError;
  List<CityModel> get cities => throw _privateConstructorUsedError;
  List<AreaModel> get areas => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;
  bool get isCityLoading => throw _privateConstructorUsedError;
  bool get isAreaLoading => throw _privateConstructorUsedError;

  /// Create a copy of AddressState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AddressStateCopyWith<AddressState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AddressStateCopyWith<$Res> {
  factory $AddressStateCopyWith(
          AddressState value, $Res Function(AddressState) then) =
      _$AddressStateCopyWithImpl<$Res, AddressState>;
  @useResult
  $Res call(
      {List<CountryModel> countries,
      List<CityModel> cities,
      List<AreaModel> areas,
      bool isLoading,
      bool isCityLoading,
      bool isAreaLoading});
}

/// @nodoc
class _$AddressStateCopyWithImpl<$Res, $Val extends AddressState>
    implements $AddressStateCopyWith<$Res> {
  _$AddressStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AddressState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? countries = null,
    Object? cities = null,
    Object? areas = null,
    Object? isLoading = null,
    Object? isCityLoading = null,
    Object? isAreaLoading = null,
  }) {
    return _then(_value.copyWith(
      countries: null == countries
          ? _value.countries
          : countries // ignore: cast_nullable_to_non_nullable
              as List<CountryModel>,
      cities: null == cities
          ? _value.cities
          : cities // ignore: cast_nullable_to_non_nullable
              as List<CityModel>,
      areas: null == areas
          ? _value.areas
          : areas // ignore: cast_nullable_to_non_nullable
              as List<AreaModel>,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isCityLoading: null == isCityLoading
          ? _value.isCityLoading
          : isCityLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isAreaLoading: null == isAreaLoading
          ? _value.isAreaLoading
          : isAreaLoading // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AddressStateImplCopyWith<$Res>
    implements $AddressStateCopyWith<$Res> {
  factory _$$AddressStateImplCopyWith(
          _$AddressStateImpl value, $Res Function(_$AddressStateImpl) then) =
      __$$AddressStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<CountryModel> countries,
      List<CityModel> cities,
      List<AreaModel> areas,
      bool isLoading,
      bool isCityLoading,
      bool isAreaLoading});
}

/// @nodoc
class __$$AddressStateImplCopyWithImpl<$Res>
    extends _$AddressStateCopyWithImpl<$Res, _$AddressStateImpl>
    implements _$$AddressStateImplCopyWith<$Res> {
  __$$AddressStateImplCopyWithImpl(
      _$AddressStateImpl _value, $Res Function(_$AddressStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of AddressState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? countries = null,
    Object? cities = null,
    Object? areas = null,
    Object? isLoading = null,
    Object? isCityLoading = null,
    Object? isAreaLoading = null,
  }) {
    return _then(_$AddressStateImpl(
      countries: null == countries
          ? _value._countries
          : countries // ignore: cast_nullable_to_non_nullable
              as List<CountryModel>,
      cities: null == cities
          ? _value._cities
          : cities // ignore: cast_nullable_to_non_nullable
              as List<CityModel>,
      areas: null == areas
          ? _value._areas
          : areas // ignore: cast_nullable_to_non_nullable
              as List<AreaModel>,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isCityLoading: null == isCityLoading
          ? _value.isCityLoading
          : isCityLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isAreaLoading: null == isAreaLoading
          ? _value.isAreaLoading
          : isAreaLoading // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$AddressStateImpl implements _AddressState {
  const _$AddressStateImpl(
      {final List<CountryModel> countries = const [],
      final List<CityModel> cities = const [],
      final List<AreaModel> areas = const [],
      this.isLoading = true,
      this.isCityLoading = true,
      this.isAreaLoading = true})
      : _countries = countries,
        _cities = cities,
        _areas = areas;

  final List<CountryModel> _countries;
  @override
  @JsonKey()
  List<CountryModel> get countries {
    if (_countries is EqualUnmodifiableListView) return _countries;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_countries);
  }

  final List<CityModel> _cities;
  @override
  @JsonKey()
  List<CityModel> get cities {
    if (_cities is EqualUnmodifiableListView) return _cities;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_cities);
  }

  final List<AreaModel> _areas;
  @override
  @JsonKey()
  List<AreaModel> get areas {
    if (_areas is EqualUnmodifiableListView) return _areas;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_areas);
  }

  @override
  @JsonKey()
  final bool isLoading;
  @override
  @JsonKey()
  final bool isCityLoading;
  @override
  @JsonKey()
  final bool isAreaLoading;

  @override
  String toString() {
    return 'AddressState(countries: $countries, cities: $cities, areas: $areas, isLoading: $isLoading, isCityLoading: $isCityLoading, isAreaLoading: $isAreaLoading)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AddressStateImpl &&
            const DeepCollectionEquality()
                .equals(other._countries, _countries) &&
            const DeepCollectionEquality().equals(other._cities, _cities) &&
            const DeepCollectionEquality().equals(other._areas, _areas) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.isCityLoading, isCityLoading) ||
                other.isCityLoading == isCityLoading) &&
            (identical(other.isAreaLoading, isAreaLoading) ||
                other.isAreaLoading == isAreaLoading));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_countries),
      const DeepCollectionEquality().hash(_cities),
      const DeepCollectionEquality().hash(_areas),
      isLoading,
      isCityLoading,
      isAreaLoading);

  /// Create a copy of AddressState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AddressStateImplCopyWith<_$AddressStateImpl> get copyWith =>
      __$$AddressStateImplCopyWithImpl<_$AddressStateImpl>(this, _$identity);
}

abstract class _AddressState implements AddressState {
  const factory _AddressState(
      {final List<CountryModel> countries,
      final List<CityModel> cities,
      final List<AreaModel> areas,
      final bool isLoading,
      final bool isCityLoading,
      final bool isAreaLoading}) = _$AddressStateImpl;

  @override
  List<CountryModel> get countries;
  @override
  List<CityModel> get cities;
  @override
  List<AreaModel> get areas;
  @override
  bool get isLoading;
  @override
  bool get isCityLoading;
  @override
  bool get isAreaLoading;

  /// Create a copy of AddressState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AddressStateImplCopyWith<_$AddressStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
