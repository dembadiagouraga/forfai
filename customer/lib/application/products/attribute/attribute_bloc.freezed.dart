// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'attribute_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$AttributeEvent {
  BuildContext get context => throw _privateConstructorUsedError;
  bool? get isRefresh => throw _privateConstructorUsedError;
  int? get categoryId => throw _privateConstructorUsedError;
  RefreshController? get controller => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(BuildContext context, bool? isRefresh,
            int? categoryId, RefreshController? controller)
        fetchAttributes,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(BuildContext context, bool? isRefresh, int? categoryId,
            RefreshController? controller)?
        fetchAttributes,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(BuildContext context, bool? isRefresh, int? categoryId,
            RefreshController? controller)?
        fetchAttributes,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(FetchAttributes value) fetchAttributes,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(FetchAttributes value)? fetchAttributes,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FetchAttributes value)? fetchAttributes,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  /// Create a copy of AttributeEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AttributeEventCopyWith<AttributeEvent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AttributeEventCopyWith<$Res> {
  factory $AttributeEventCopyWith(
          AttributeEvent value, $Res Function(AttributeEvent) then) =
      _$AttributeEventCopyWithImpl<$Res, AttributeEvent>;
  @useResult
  $Res call(
      {BuildContext context,
      bool? isRefresh,
      int? categoryId,
      RefreshController? controller});
}

/// @nodoc
class _$AttributeEventCopyWithImpl<$Res, $Val extends AttributeEvent>
    implements $AttributeEventCopyWith<$Res> {
  _$AttributeEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AttributeEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? context = null,
    Object? isRefresh = freezed,
    Object? categoryId = freezed,
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
      categoryId: freezed == categoryId
          ? _value.categoryId
          : categoryId // ignore: cast_nullable_to_non_nullable
              as int?,
      controller: freezed == controller
          ? _value.controller
          : controller // ignore: cast_nullable_to_non_nullable
              as RefreshController?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FetchAttributesImplCopyWith<$Res>
    implements $AttributeEventCopyWith<$Res> {
  factory _$$FetchAttributesImplCopyWith(_$FetchAttributesImpl value,
          $Res Function(_$FetchAttributesImpl) then) =
      __$$FetchAttributesImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {BuildContext context,
      bool? isRefresh,
      int? categoryId,
      RefreshController? controller});
}

/// @nodoc
class __$$FetchAttributesImplCopyWithImpl<$Res>
    extends _$AttributeEventCopyWithImpl<$Res, _$FetchAttributesImpl>
    implements _$$FetchAttributesImplCopyWith<$Res> {
  __$$FetchAttributesImplCopyWithImpl(
      _$FetchAttributesImpl _value, $Res Function(_$FetchAttributesImpl) _then)
      : super(_value, _then);

  /// Create a copy of AttributeEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? context = null,
    Object? isRefresh = freezed,
    Object? categoryId = freezed,
    Object? controller = freezed,
  }) {
    return _then(_$FetchAttributesImpl(
      context: null == context
          ? _value.context
          : context // ignore: cast_nullable_to_non_nullable
              as BuildContext,
      isRefresh: freezed == isRefresh
          ? _value.isRefresh
          : isRefresh // ignore: cast_nullable_to_non_nullable
              as bool?,
      categoryId: freezed == categoryId
          ? _value.categoryId
          : categoryId // ignore: cast_nullable_to_non_nullable
              as int?,
      controller: freezed == controller
          ? _value.controller
          : controller // ignore: cast_nullable_to_non_nullable
              as RefreshController?,
    ));
  }
}

/// @nodoc

class _$FetchAttributesImpl implements FetchAttributes {
  const _$FetchAttributesImpl(
      {required this.context,
      this.isRefresh,
      required this.categoryId,
      this.controller});

  @override
  final BuildContext context;
  @override
  final bool? isRefresh;
  @override
  final int? categoryId;
  @override
  final RefreshController? controller;

  @override
  String toString() {
    return 'AttributeEvent.fetchAttributes(context: $context, isRefresh: $isRefresh, categoryId: $categoryId, controller: $controller)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FetchAttributesImpl &&
            (identical(other.context, context) || other.context == context) &&
            (identical(other.isRefresh, isRefresh) ||
                other.isRefresh == isRefresh) &&
            (identical(other.categoryId, categoryId) ||
                other.categoryId == categoryId) &&
            (identical(other.controller, controller) ||
                other.controller == controller));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, context, isRefresh, categoryId, controller);

  /// Create a copy of AttributeEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FetchAttributesImplCopyWith<_$FetchAttributesImpl> get copyWith =>
      __$$FetchAttributesImplCopyWithImpl<_$FetchAttributesImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(BuildContext context, bool? isRefresh,
            int? categoryId, RefreshController? controller)
        fetchAttributes,
  }) {
    return fetchAttributes(context, isRefresh, categoryId, controller);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(BuildContext context, bool? isRefresh, int? categoryId,
            RefreshController? controller)?
        fetchAttributes,
  }) {
    return fetchAttributes?.call(context, isRefresh, categoryId, controller);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(BuildContext context, bool? isRefresh, int? categoryId,
            RefreshController? controller)?
        fetchAttributes,
    required TResult orElse(),
  }) {
    if (fetchAttributes != null) {
      return fetchAttributes(context, isRefresh, categoryId, controller);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(FetchAttributes value) fetchAttributes,
  }) {
    return fetchAttributes(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(FetchAttributes value)? fetchAttributes,
  }) {
    return fetchAttributes?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FetchAttributes value)? fetchAttributes,
    required TResult orElse(),
  }) {
    if (fetchAttributes != null) {
      return fetchAttributes(this);
    }
    return orElse();
  }
}

abstract class FetchAttributes implements AttributeEvent {
  const factory FetchAttributes(
      {required final BuildContext context,
      final bool? isRefresh,
      required final int? categoryId,
      final RefreshController? controller}) = _$FetchAttributesImpl;

  @override
  BuildContext get context;
  @override
  bool? get isRefresh;
  @override
  int? get categoryId;
  @override
  RefreshController? get controller;

  /// Create a copy of AttributeEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FetchAttributesImplCopyWith<_$FetchAttributesImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$AttributeState {
  List<AttributesData> get attribute => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;

  /// Create a copy of AttributeState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AttributeStateCopyWith<AttributeState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AttributeStateCopyWith<$Res> {
  factory $AttributeStateCopyWith(
          AttributeState value, $Res Function(AttributeState) then) =
      _$AttributeStateCopyWithImpl<$Res, AttributeState>;
  @useResult
  $Res call({List<AttributesData> attribute, bool isLoading});
}

/// @nodoc
class _$AttributeStateCopyWithImpl<$Res, $Val extends AttributeState>
    implements $AttributeStateCopyWith<$Res> {
  _$AttributeStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AttributeState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? attribute = null,
    Object? isLoading = null,
  }) {
    return _then(_value.copyWith(
      attribute: null == attribute
          ? _value.attribute
          : attribute // ignore: cast_nullable_to_non_nullable
              as List<AttributesData>,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AttributeStateImplCopyWith<$Res>
    implements $AttributeStateCopyWith<$Res> {
  factory _$$AttributeStateImplCopyWith(_$AttributeStateImpl value,
          $Res Function(_$AttributeStateImpl) then) =
      __$$AttributeStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<AttributesData> attribute, bool isLoading});
}

/// @nodoc
class __$$AttributeStateImplCopyWithImpl<$Res>
    extends _$AttributeStateCopyWithImpl<$Res, _$AttributeStateImpl>
    implements _$$AttributeStateImplCopyWith<$Res> {
  __$$AttributeStateImplCopyWithImpl(
      _$AttributeStateImpl _value, $Res Function(_$AttributeStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of AttributeState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? attribute = null,
    Object? isLoading = null,
  }) {
    return _then(_$AttributeStateImpl(
      attribute: null == attribute
          ? _value._attribute
          : attribute // ignore: cast_nullable_to_non_nullable
              as List<AttributesData>,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$AttributeStateImpl implements _AttributeState {
  const _$AttributeStateImpl(
      {final List<AttributesData> attribute = const [], this.isLoading = true})
      : _attribute = attribute;

  final List<AttributesData> _attribute;
  @override
  @JsonKey()
  List<AttributesData> get attribute {
    if (_attribute is EqualUnmodifiableListView) return _attribute;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_attribute);
  }

  @override
  @JsonKey()
  final bool isLoading;

  @override
  String toString() {
    return 'AttributeState(attribute: $attribute, isLoading: $isLoading)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AttributeStateImpl &&
            const DeepCollectionEquality()
                .equals(other._attribute, _attribute) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_attribute), isLoading);

  /// Create a copy of AttributeState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AttributeStateImplCopyWith<_$AttributeStateImpl> get copyWith =>
      __$$AttributeStateImplCopyWithImpl<_$AttributeStateImpl>(
          this, _$identity);
}

abstract class _AttributeState implements AttributeState {
  const factory _AttributeState(
      {final List<AttributesData> attribute,
      final bool isLoading}) = _$AttributeStateImpl;

  @override
  List<AttributesData> get attribute;
  @override
  bool get isLoading;

  /// Create a copy of AttributeState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AttributeStateImplCopyWith<_$AttributeStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
