// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'select_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$SelectEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int selectIndex) changeIndex,
    required TResult Function(List<Value> ids) selectIds,
    required TResult Function(Value? value) selectValue,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int selectIndex)? changeIndex,
    TResult? Function(List<Value> ids)? selectIds,
    TResult? Function(Value? value)? selectValue,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int selectIndex)? changeIndex,
    TResult Function(List<Value> ids)? selectIds,
    TResult Function(Value? value)? selectValue,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ChangeIndex value) changeIndex,
    required TResult Function(SelectIds value) selectIds,
    required TResult Function(SelectValue value) selectValue,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ChangeIndex value)? changeIndex,
    TResult? Function(SelectIds value)? selectIds,
    TResult? Function(SelectValue value)? selectValue,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ChangeIndex value)? changeIndex,
    TResult Function(SelectIds value)? selectIds,
    TResult Function(SelectValue value)? selectValue,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SelectEventCopyWith<$Res> {
  factory $SelectEventCopyWith(
          SelectEvent value, $Res Function(SelectEvent) then) =
      _$SelectEventCopyWithImpl<$Res, SelectEvent>;
}

/// @nodoc
class _$SelectEventCopyWithImpl<$Res, $Val extends SelectEvent>
    implements $SelectEventCopyWith<$Res> {
  _$SelectEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SelectEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$ChangeIndexImplCopyWith<$Res> {
  factory _$$ChangeIndexImplCopyWith(
          _$ChangeIndexImpl value, $Res Function(_$ChangeIndexImpl) then) =
      __$$ChangeIndexImplCopyWithImpl<$Res>;
  @useResult
  $Res call({int selectIndex});
}

/// @nodoc
class __$$ChangeIndexImplCopyWithImpl<$Res>
    extends _$SelectEventCopyWithImpl<$Res, _$ChangeIndexImpl>
    implements _$$ChangeIndexImplCopyWith<$Res> {
  __$$ChangeIndexImplCopyWithImpl(
      _$ChangeIndexImpl _value, $Res Function(_$ChangeIndexImpl) _then)
      : super(_value, _then);

  /// Create a copy of SelectEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? selectIndex = null,
  }) {
    return _then(_$ChangeIndexImpl(
      selectIndex: null == selectIndex
          ? _value.selectIndex
          : selectIndex // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$ChangeIndexImpl implements ChangeIndex {
  const _$ChangeIndexImpl({required this.selectIndex});

  @override
  final int selectIndex;

  @override
  String toString() {
    return 'SelectEvent.changeIndex(selectIndex: $selectIndex)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChangeIndexImpl &&
            (identical(other.selectIndex, selectIndex) ||
                other.selectIndex == selectIndex));
  }

  @override
  int get hashCode => Object.hash(runtimeType, selectIndex);

  /// Create a copy of SelectEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ChangeIndexImplCopyWith<_$ChangeIndexImpl> get copyWith =>
      __$$ChangeIndexImplCopyWithImpl<_$ChangeIndexImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int selectIndex) changeIndex,
    required TResult Function(List<Value> ids) selectIds,
    required TResult Function(Value? value) selectValue,
  }) {
    return changeIndex(selectIndex);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int selectIndex)? changeIndex,
    TResult? Function(List<Value> ids)? selectIds,
    TResult? Function(Value? value)? selectValue,
  }) {
    return changeIndex?.call(selectIndex);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int selectIndex)? changeIndex,
    TResult Function(List<Value> ids)? selectIds,
    TResult Function(Value? value)? selectValue,
    required TResult orElse(),
  }) {
    if (changeIndex != null) {
      return changeIndex(selectIndex);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ChangeIndex value) changeIndex,
    required TResult Function(SelectIds value) selectIds,
    required TResult Function(SelectValue value) selectValue,
  }) {
    return changeIndex(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ChangeIndex value)? changeIndex,
    TResult? Function(SelectIds value)? selectIds,
    TResult? Function(SelectValue value)? selectValue,
  }) {
    return changeIndex?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ChangeIndex value)? changeIndex,
    TResult Function(SelectIds value)? selectIds,
    TResult Function(SelectValue value)? selectValue,
    required TResult orElse(),
  }) {
    if (changeIndex != null) {
      return changeIndex(this);
    }
    return orElse();
  }
}

abstract class ChangeIndex implements SelectEvent {
  const factory ChangeIndex({required final int selectIndex}) =
      _$ChangeIndexImpl;

  int get selectIndex;

  /// Create a copy of SelectEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ChangeIndexImplCopyWith<_$ChangeIndexImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SelectIdsImplCopyWith<$Res> {
  factory _$$SelectIdsImplCopyWith(
          _$SelectIdsImpl value, $Res Function(_$SelectIdsImpl) then) =
      __$$SelectIdsImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<Value> ids});
}

/// @nodoc
class __$$SelectIdsImplCopyWithImpl<$Res>
    extends _$SelectEventCopyWithImpl<$Res, _$SelectIdsImpl>
    implements _$$SelectIdsImplCopyWith<$Res> {
  __$$SelectIdsImplCopyWithImpl(
      _$SelectIdsImpl _value, $Res Function(_$SelectIdsImpl) _then)
      : super(_value, _then);

  /// Create a copy of SelectEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? ids = null,
  }) {
    return _then(_$SelectIdsImpl(
      ids: null == ids
          ? _value._ids
          : ids // ignore: cast_nullable_to_non_nullable
              as List<Value>,
    ));
  }
}

/// @nodoc

class _$SelectIdsImpl implements SelectIds {
  const _$SelectIdsImpl({required final List<Value> ids}) : _ids = ids;

  final List<Value> _ids;
  @override
  List<Value> get ids {
    if (_ids is EqualUnmodifiableListView) return _ids;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_ids);
  }

  @override
  String toString() {
    return 'SelectEvent.selectIds(ids: $ids)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SelectIdsImpl &&
            const DeepCollectionEquality().equals(other._ids, _ids));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_ids));

  /// Create a copy of SelectEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SelectIdsImplCopyWith<_$SelectIdsImpl> get copyWith =>
      __$$SelectIdsImplCopyWithImpl<_$SelectIdsImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int selectIndex) changeIndex,
    required TResult Function(List<Value> ids) selectIds,
    required TResult Function(Value? value) selectValue,
  }) {
    return selectIds(ids);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int selectIndex)? changeIndex,
    TResult? Function(List<Value> ids)? selectIds,
    TResult? Function(Value? value)? selectValue,
  }) {
    return selectIds?.call(ids);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int selectIndex)? changeIndex,
    TResult Function(List<Value> ids)? selectIds,
    TResult Function(Value? value)? selectValue,
    required TResult orElse(),
  }) {
    if (selectIds != null) {
      return selectIds(ids);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ChangeIndex value) changeIndex,
    required TResult Function(SelectIds value) selectIds,
    required TResult Function(SelectValue value) selectValue,
  }) {
    return selectIds(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ChangeIndex value)? changeIndex,
    TResult? Function(SelectIds value)? selectIds,
    TResult? Function(SelectValue value)? selectValue,
  }) {
    return selectIds?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ChangeIndex value)? changeIndex,
    TResult Function(SelectIds value)? selectIds,
    TResult Function(SelectValue value)? selectValue,
    required TResult orElse(),
  }) {
    if (selectIds != null) {
      return selectIds(this);
    }
    return orElse();
  }
}

abstract class SelectIds implements SelectEvent {
  const factory SelectIds({required final List<Value> ids}) = _$SelectIdsImpl;

  List<Value> get ids;

  /// Create a copy of SelectEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SelectIdsImplCopyWith<_$SelectIdsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SelectValueImplCopyWith<$Res> {
  factory _$$SelectValueImplCopyWith(
          _$SelectValueImpl value, $Res Function(_$SelectValueImpl) then) =
      __$$SelectValueImplCopyWithImpl<$Res>;
  @useResult
  $Res call({Value? value});
}

/// @nodoc
class __$$SelectValueImplCopyWithImpl<$Res>
    extends _$SelectEventCopyWithImpl<$Res, _$SelectValueImpl>
    implements _$$SelectValueImplCopyWith<$Res> {
  __$$SelectValueImplCopyWithImpl(
      _$SelectValueImpl _value, $Res Function(_$SelectValueImpl) _then)
      : super(_value, _then);

  /// Create a copy of SelectEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = freezed,
  }) {
    return _then(_$SelectValueImpl(
      value: freezed == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as Value?,
    ));
  }
}

/// @nodoc

class _$SelectValueImpl implements SelectValue {
  const _$SelectValueImpl({required this.value});

  @override
  final Value? value;

  @override
  String toString() {
    return 'SelectEvent.selectValue(value: $value)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SelectValueImpl &&
            (identical(other.value, value) || other.value == value));
  }

  @override
  int get hashCode => Object.hash(runtimeType, value);

  /// Create a copy of SelectEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SelectValueImplCopyWith<_$SelectValueImpl> get copyWith =>
      __$$SelectValueImplCopyWithImpl<_$SelectValueImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int selectIndex) changeIndex,
    required TResult Function(List<Value> ids) selectIds,
    required TResult Function(Value? value) selectValue,
  }) {
    return selectValue(value);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int selectIndex)? changeIndex,
    TResult? Function(List<Value> ids)? selectIds,
    TResult? Function(Value? value)? selectValue,
  }) {
    return selectValue?.call(value);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int selectIndex)? changeIndex,
    TResult Function(List<Value> ids)? selectIds,
    TResult Function(Value? value)? selectValue,
    required TResult orElse(),
  }) {
    if (selectValue != null) {
      return selectValue(value);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ChangeIndex value) changeIndex,
    required TResult Function(SelectIds value) selectIds,
    required TResult Function(SelectValue value) selectValue,
  }) {
    return selectValue(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ChangeIndex value)? changeIndex,
    TResult? Function(SelectIds value)? selectIds,
    TResult? Function(SelectValue value)? selectValue,
  }) {
    return selectValue?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ChangeIndex value)? changeIndex,
    TResult Function(SelectIds value)? selectIds,
    TResult Function(SelectValue value)? selectValue,
    required TResult orElse(),
  }) {
    if (selectValue != null) {
      return selectValue(this);
    }
    return orElse();
  }
}

abstract class SelectValue implements SelectEvent {
  const factory SelectValue({required final Value? value}) = _$SelectValueImpl;

  Value? get value;

  /// Create a copy of SelectEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SelectValueImplCopyWith<_$SelectValueImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$SelectState {
  int get selectIndex => throw _privateConstructorUsedError;
  List<Value> get selectIds => throw _privateConstructorUsedError;

  /// Create a copy of SelectState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SelectStateCopyWith<SelectState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SelectStateCopyWith<$Res> {
  factory $SelectStateCopyWith(
          SelectState value, $Res Function(SelectState) then) =
      _$SelectStateCopyWithImpl<$Res, SelectState>;
  @useResult
  $Res call({int selectIndex, List<Value> selectIds});
}

/// @nodoc
class _$SelectStateCopyWithImpl<$Res, $Val extends SelectState>
    implements $SelectStateCopyWith<$Res> {
  _$SelectStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SelectState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? selectIndex = null,
    Object? selectIds = null,
  }) {
    return _then(_value.copyWith(
      selectIndex: null == selectIndex
          ? _value.selectIndex
          : selectIndex // ignore: cast_nullable_to_non_nullable
              as int,
      selectIds: null == selectIds
          ? _value.selectIds
          : selectIds // ignore: cast_nullable_to_non_nullable
              as List<Value>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SelectStateImplCopyWith<$Res>
    implements $SelectStateCopyWith<$Res> {
  factory _$$SelectStateImplCopyWith(
          _$SelectStateImpl value, $Res Function(_$SelectStateImpl) then) =
      __$$SelectStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int selectIndex, List<Value> selectIds});
}

/// @nodoc
class __$$SelectStateImplCopyWithImpl<$Res>
    extends _$SelectStateCopyWithImpl<$Res, _$SelectStateImpl>
    implements _$$SelectStateImplCopyWith<$Res> {
  __$$SelectStateImplCopyWithImpl(
      _$SelectStateImpl _value, $Res Function(_$SelectStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of SelectState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? selectIndex = null,
    Object? selectIds = null,
  }) {
    return _then(_$SelectStateImpl(
      selectIndex: null == selectIndex
          ? _value.selectIndex
          : selectIndex // ignore: cast_nullable_to_non_nullable
              as int,
      selectIds: null == selectIds
          ? _value._selectIds
          : selectIds // ignore: cast_nullable_to_non_nullable
              as List<Value>,
    ));
  }
}

/// @nodoc

class _$SelectStateImpl implements _SelectState {
  const _$SelectStateImpl(
      {this.selectIndex = 0, final List<Value> selectIds = const []})
      : _selectIds = selectIds;

  @override
  @JsonKey()
  final int selectIndex;
  final List<Value> _selectIds;
  @override
  @JsonKey()
  List<Value> get selectIds {
    if (_selectIds is EqualUnmodifiableListView) return _selectIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_selectIds);
  }

  @override
  String toString() {
    return 'SelectState(selectIndex: $selectIndex, selectIds: $selectIds)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SelectStateImpl &&
            (identical(other.selectIndex, selectIndex) ||
                other.selectIndex == selectIndex) &&
            const DeepCollectionEquality()
                .equals(other._selectIds, _selectIds));
  }

  @override
  int get hashCode => Object.hash(runtimeType, selectIndex,
      const DeepCollectionEquality().hash(_selectIds));

  /// Create a copy of SelectState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SelectStateImplCopyWith<_$SelectStateImpl> get copyWith =>
      __$$SelectStateImplCopyWithImpl<_$SelectStateImpl>(this, _$identity);
}

abstract class _SelectState implements SelectState {
  const factory _SelectState(
      {final int selectIndex, final List<Value> selectIds}) = _$SelectStateImpl;

  @override
  int get selectIndex;
  @override
  List<Value> get selectIds;

  /// Create a copy of SelectState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SelectStateImplCopyWith<_$SelectStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
