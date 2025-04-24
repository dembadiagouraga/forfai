// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'filter_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$FilterEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(LayoutType selectType) selectType,
    required TResult Function(FilterType type) selectSort,
    required TResult Function(
            BuildContext context, String? type, bool isPrice, int? categoryId)
        fetchFilter,
    required TResult Function(List<Value> ids) setExtras,
    required TResult Function(RangeValues price) setRangePrice,
    required TResult Function(CategoryData category) setCategory,
    required TResult Function(List<int> ids) setBrands,
    required TResult Function() clearFilter,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(LayoutType selectType)? selectType,
    TResult? Function(FilterType type)? selectSort,
    TResult? Function(
            BuildContext context, String? type, bool isPrice, int? categoryId)?
        fetchFilter,
    TResult? Function(List<Value> ids)? setExtras,
    TResult? Function(RangeValues price)? setRangePrice,
    TResult? Function(CategoryData category)? setCategory,
    TResult? Function(List<int> ids)? setBrands,
    TResult? Function()? clearFilter,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(LayoutType selectType)? selectType,
    TResult Function(FilterType type)? selectSort,
    TResult Function(
            BuildContext context, String? type, bool isPrice, int? categoryId)?
        fetchFilter,
    TResult Function(List<Value> ids)? setExtras,
    TResult Function(RangeValues price)? setRangePrice,
    TResult Function(CategoryData category)? setCategory,
    TResult Function(List<int> ids)? setBrands,
    TResult Function()? clearFilter,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SelectType value) selectType,
    required TResult Function(SelectSort value) selectSort,
    required TResult Function(FetchExtras value) fetchFilter,
    required TResult Function(SetExtras value) setExtras,
    required TResult Function(SetRangePrice value) setRangePrice,
    required TResult Function(SetCategory value) setCategory,
    required TResult Function(SetBrands value) setBrands,
    required TResult Function(ClearFilter value) clearFilter,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SelectType value)? selectType,
    TResult? Function(SelectSort value)? selectSort,
    TResult? Function(FetchExtras value)? fetchFilter,
    TResult? Function(SetExtras value)? setExtras,
    TResult? Function(SetRangePrice value)? setRangePrice,
    TResult? Function(SetCategory value)? setCategory,
    TResult? Function(SetBrands value)? setBrands,
    TResult? Function(ClearFilter value)? clearFilter,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SelectType value)? selectType,
    TResult Function(SelectSort value)? selectSort,
    TResult Function(FetchExtras value)? fetchFilter,
    TResult Function(SetExtras value)? setExtras,
    TResult Function(SetRangePrice value)? setRangePrice,
    TResult Function(SetCategory value)? setCategory,
    TResult Function(SetBrands value)? setBrands,
    TResult Function(ClearFilter value)? clearFilter,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FilterEventCopyWith<$Res> {
  factory $FilterEventCopyWith(
          FilterEvent value, $Res Function(FilterEvent) then) =
      _$FilterEventCopyWithImpl<$Res, FilterEvent>;
}

/// @nodoc
class _$FilterEventCopyWithImpl<$Res, $Val extends FilterEvent>
    implements $FilterEventCopyWith<$Res> {
  _$FilterEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FilterEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$SelectTypeImplCopyWith<$Res> {
  factory _$$SelectTypeImplCopyWith(
          _$SelectTypeImpl value, $Res Function(_$SelectTypeImpl) then) =
      __$$SelectTypeImplCopyWithImpl<$Res>;
  @useResult
  $Res call({LayoutType selectType});
}

/// @nodoc
class __$$SelectTypeImplCopyWithImpl<$Res>
    extends _$FilterEventCopyWithImpl<$Res, _$SelectTypeImpl>
    implements _$$SelectTypeImplCopyWith<$Res> {
  __$$SelectTypeImplCopyWithImpl(
      _$SelectTypeImpl _value, $Res Function(_$SelectTypeImpl) _then)
      : super(_value, _then);

  /// Create a copy of FilterEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? selectType = null,
  }) {
    return _then(_$SelectTypeImpl(
      selectType: null == selectType
          ? _value.selectType
          : selectType // ignore: cast_nullable_to_non_nullable
              as LayoutType,
    ));
  }
}

/// @nodoc

class _$SelectTypeImpl implements SelectType {
  const _$SelectTypeImpl({required this.selectType});

  @override
  final LayoutType selectType;

  @override
  String toString() {
    return 'FilterEvent.selectType(selectType: $selectType)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SelectTypeImpl &&
            (identical(other.selectType, selectType) ||
                other.selectType == selectType));
  }

  @override
  int get hashCode => Object.hash(runtimeType, selectType);

  /// Create a copy of FilterEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SelectTypeImplCopyWith<_$SelectTypeImpl> get copyWith =>
      __$$SelectTypeImplCopyWithImpl<_$SelectTypeImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(LayoutType selectType) selectType,
    required TResult Function(FilterType type) selectSort,
    required TResult Function(
            BuildContext context, String? type, bool isPrice, int? categoryId)
        fetchFilter,
    required TResult Function(List<Value> ids) setExtras,
    required TResult Function(RangeValues price) setRangePrice,
    required TResult Function(CategoryData category) setCategory,
    required TResult Function(List<int> ids) setBrands,
    required TResult Function() clearFilter,
  }) {
    return selectType(this.selectType);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(LayoutType selectType)? selectType,
    TResult? Function(FilterType type)? selectSort,
    TResult? Function(
            BuildContext context, String? type, bool isPrice, int? categoryId)?
        fetchFilter,
    TResult? Function(List<Value> ids)? setExtras,
    TResult? Function(RangeValues price)? setRangePrice,
    TResult? Function(CategoryData category)? setCategory,
    TResult? Function(List<int> ids)? setBrands,
    TResult? Function()? clearFilter,
  }) {
    return selectType?.call(this.selectType);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(LayoutType selectType)? selectType,
    TResult Function(FilterType type)? selectSort,
    TResult Function(
            BuildContext context, String? type, bool isPrice, int? categoryId)?
        fetchFilter,
    TResult Function(List<Value> ids)? setExtras,
    TResult Function(RangeValues price)? setRangePrice,
    TResult Function(CategoryData category)? setCategory,
    TResult Function(List<int> ids)? setBrands,
    TResult Function()? clearFilter,
    required TResult orElse(),
  }) {
    if (selectType != null) {
      return selectType(this.selectType);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SelectType value) selectType,
    required TResult Function(SelectSort value) selectSort,
    required TResult Function(FetchExtras value) fetchFilter,
    required TResult Function(SetExtras value) setExtras,
    required TResult Function(SetRangePrice value) setRangePrice,
    required TResult Function(SetCategory value) setCategory,
    required TResult Function(SetBrands value) setBrands,
    required TResult Function(ClearFilter value) clearFilter,
  }) {
    return selectType(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SelectType value)? selectType,
    TResult? Function(SelectSort value)? selectSort,
    TResult? Function(FetchExtras value)? fetchFilter,
    TResult? Function(SetExtras value)? setExtras,
    TResult? Function(SetRangePrice value)? setRangePrice,
    TResult? Function(SetCategory value)? setCategory,
    TResult? Function(SetBrands value)? setBrands,
    TResult? Function(ClearFilter value)? clearFilter,
  }) {
    return selectType?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SelectType value)? selectType,
    TResult Function(SelectSort value)? selectSort,
    TResult Function(FetchExtras value)? fetchFilter,
    TResult Function(SetExtras value)? setExtras,
    TResult Function(SetRangePrice value)? setRangePrice,
    TResult Function(SetCategory value)? setCategory,
    TResult Function(SetBrands value)? setBrands,
    TResult Function(ClearFilter value)? clearFilter,
    required TResult orElse(),
  }) {
    if (selectType != null) {
      return selectType(this);
    }
    return orElse();
  }
}

abstract class SelectType implements FilterEvent {
  const factory SelectType({required final LayoutType selectType}) =
      _$SelectTypeImpl;

  LayoutType get selectType;

  /// Create a copy of FilterEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SelectTypeImplCopyWith<_$SelectTypeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SelectSortImplCopyWith<$Res> {
  factory _$$SelectSortImplCopyWith(
          _$SelectSortImpl value, $Res Function(_$SelectSortImpl) then) =
      __$$SelectSortImplCopyWithImpl<$Res>;
  @useResult
  $Res call({FilterType type});
}

/// @nodoc
class __$$SelectSortImplCopyWithImpl<$Res>
    extends _$FilterEventCopyWithImpl<$Res, _$SelectSortImpl>
    implements _$$SelectSortImplCopyWith<$Res> {
  __$$SelectSortImplCopyWithImpl(
      _$SelectSortImpl _value, $Res Function(_$SelectSortImpl) _then)
      : super(_value, _then);

  /// Create a copy of FilterEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
  }) {
    return _then(_$SelectSortImpl(
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as FilterType,
    ));
  }
}

/// @nodoc

class _$SelectSortImpl implements SelectSort {
  const _$SelectSortImpl({required this.type});

  @override
  final FilterType type;

  @override
  String toString() {
    return 'FilterEvent.selectSort(type: $type)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SelectSortImpl &&
            (identical(other.type, type) || other.type == type));
  }

  @override
  int get hashCode => Object.hash(runtimeType, type);

  /// Create a copy of FilterEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SelectSortImplCopyWith<_$SelectSortImpl> get copyWith =>
      __$$SelectSortImplCopyWithImpl<_$SelectSortImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(LayoutType selectType) selectType,
    required TResult Function(FilterType type) selectSort,
    required TResult Function(
            BuildContext context, String? type, bool isPrice, int? categoryId)
        fetchFilter,
    required TResult Function(List<Value> ids) setExtras,
    required TResult Function(RangeValues price) setRangePrice,
    required TResult Function(CategoryData category) setCategory,
    required TResult Function(List<int> ids) setBrands,
    required TResult Function() clearFilter,
  }) {
    return selectSort(type);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(LayoutType selectType)? selectType,
    TResult? Function(FilterType type)? selectSort,
    TResult? Function(
            BuildContext context, String? type, bool isPrice, int? categoryId)?
        fetchFilter,
    TResult? Function(List<Value> ids)? setExtras,
    TResult? Function(RangeValues price)? setRangePrice,
    TResult? Function(CategoryData category)? setCategory,
    TResult? Function(List<int> ids)? setBrands,
    TResult? Function()? clearFilter,
  }) {
    return selectSort?.call(type);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(LayoutType selectType)? selectType,
    TResult Function(FilterType type)? selectSort,
    TResult Function(
            BuildContext context, String? type, bool isPrice, int? categoryId)?
        fetchFilter,
    TResult Function(List<Value> ids)? setExtras,
    TResult Function(RangeValues price)? setRangePrice,
    TResult Function(CategoryData category)? setCategory,
    TResult Function(List<int> ids)? setBrands,
    TResult Function()? clearFilter,
    required TResult orElse(),
  }) {
    if (selectSort != null) {
      return selectSort(type);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SelectType value) selectType,
    required TResult Function(SelectSort value) selectSort,
    required TResult Function(FetchExtras value) fetchFilter,
    required TResult Function(SetExtras value) setExtras,
    required TResult Function(SetRangePrice value) setRangePrice,
    required TResult Function(SetCategory value) setCategory,
    required TResult Function(SetBrands value) setBrands,
    required TResult Function(ClearFilter value) clearFilter,
  }) {
    return selectSort(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SelectType value)? selectType,
    TResult? Function(SelectSort value)? selectSort,
    TResult? Function(FetchExtras value)? fetchFilter,
    TResult? Function(SetExtras value)? setExtras,
    TResult? Function(SetRangePrice value)? setRangePrice,
    TResult? Function(SetCategory value)? setCategory,
    TResult? Function(SetBrands value)? setBrands,
    TResult? Function(ClearFilter value)? clearFilter,
  }) {
    return selectSort?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SelectType value)? selectType,
    TResult Function(SelectSort value)? selectSort,
    TResult Function(FetchExtras value)? fetchFilter,
    TResult Function(SetExtras value)? setExtras,
    TResult Function(SetRangePrice value)? setRangePrice,
    TResult Function(SetCategory value)? setCategory,
    TResult Function(SetBrands value)? setBrands,
    TResult Function(ClearFilter value)? clearFilter,
    required TResult orElse(),
  }) {
    if (selectSort != null) {
      return selectSort(this);
    }
    return orElse();
  }
}

abstract class SelectSort implements FilterEvent {
  const factory SelectSort({required final FilterType type}) = _$SelectSortImpl;

  FilterType get type;

  /// Create a copy of FilterEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SelectSortImplCopyWith<_$SelectSortImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$FetchExtrasImplCopyWith<$Res> {
  factory _$$FetchExtrasImplCopyWith(
          _$FetchExtrasImpl value, $Res Function(_$FetchExtrasImpl) then) =
      __$$FetchExtrasImplCopyWithImpl<$Res>;
  @useResult
  $Res call(
      {BuildContext context, String? type, bool isPrice, int? categoryId});
}

/// @nodoc
class __$$FetchExtrasImplCopyWithImpl<$Res>
    extends _$FilterEventCopyWithImpl<$Res, _$FetchExtrasImpl>
    implements _$$FetchExtrasImplCopyWith<$Res> {
  __$$FetchExtrasImplCopyWithImpl(
      _$FetchExtrasImpl _value, $Res Function(_$FetchExtrasImpl) _then)
      : super(_value, _then);

  /// Create a copy of FilterEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? context = null,
    Object? type = freezed,
    Object? isPrice = null,
    Object? categoryId = freezed,
  }) {
    return _then(_$FetchExtrasImpl(
      context: null == context
          ? _value.context
          : context // ignore: cast_nullable_to_non_nullable
              as BuildContext,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String?,
      isPrice: null == isPrice
          ? _value.isPrice
          : isPrice // ignore: cast_nullable_to_non_nullable
              as bool,
      categoryId: freezed == categoryId
          ? _value.categoryId
          : categoryId // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc

class _$FetchExtrasImpl implements FetchExtras {
  const _$FetchExtrasImpl(
      {required this.context,
      this.type,
      required this.isPrice,
      this.categoryId});

  @override
  final BuildContext context;
  @override
  final String? type;
  @override
  final bool isPrice;
  @override
  final int? categoryId;

  @override
  String toString() {
    return 'FilterEvent.fetchFilter(context: $context, type: $type, isPrice: $isPrice, categoryId: $categoryId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FetchExtrasImpl &&
            (identical(other.context, context) || other.context == context) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.isPrice, isPrice) || other.isPrice == isPrice) &&
            (identical(other.categoryId, categoryId) ||
                other.categoryId == categoryId));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, context, type, isPrice, categoryId);

  /// Create a copy of FilterEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FetchExtrasImplCopyWith<_$FetchExtrasImpl> get copyWith =>
      __$$FetchExtrasImplCopyWithImpl<_$FetchExtrasImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(LayoutType selectType) selectType,
    required TResult Function(FilterType type) selectSort,
    required TResult Function(
            BuildContext context, String? type, bool isPrice, int? categoryId)
        fetchFilter,
    required TResult Function(List<Value> ids) setExtras,
    required TResult Function(RangeValues price) setRangePrice,
    required TResult Function(CategoryData category) setCategory,
    required TResult Function(List<int> ids) setBrands,
    required TResult Function() clearFilter,
  }) {
    return fetchFilter(context, type, isPrice, categoryId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(LayoutType selectType)? selectType,
    TResult? Function(FilterType type)? selectSort,
    TResult? Function(
            BuildContext context, String? type, bool isPrice, int? categoryId)?
        fetchFilter,
    TResult? Function(List<Value> ids)? setExtras,
    TResult? Function(RangeValues price)? setRangePrice,
    TResult? Function(CategoryData category)? setCategory,
    TResult? Function(List<int> ids)? setBrands,
    TResult? Function()? clearFilter,
  }) {
    return fetchFilter?.call(context, type, isPrice, categoryId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(LayoutType selectType)? selectType,
    TResult Function(FilterType type)? selectSort,
    TResult Function(
            BuildContext context, String? type, bool isPrice, int? categoryId)?
        fetchFilter,
    TResult Function(List<Value> ids)? setExtras,
    TResult Function(RangeValues price)? setRangePrice,
    TResult Function(CategoryData category)? setCategory,
    TResult Function(List<int> ids)? setBrands,
    TResult Function()? clearFilter,
    required TResult orElse(),
  }) {
    if (fetchFilter != null) {
      return fetchFilter(context, type, isPrice, categoryId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SelectType value) selectType,
    required TResult Function(SelectSort value) selectSort,
    required TResult Function(FetchExtras value) fetchFilter,
    required TResult Function(SetExtras value) setExtras,
    required TResult Function(SetRangePrice value) setRangePrice,
    required TResult Function(SetCategory value) setCategory,
    required TResult Function(SetBrands value) setBrands,
    required TResult Function(ClearFilter value) clearFilter,
  }) {
    return fetchFilter(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SelectType value)? selectType,
    TResult? Function(SelectSort value)? selectSort,
    TResult? Function(FetchExtras value)? fetchFilter,
    TResult? Function(SetExtras value)? setExtras,
    TResult? Function(SetRangePrice value)? setRangePrice,
    TResult? Function(SetCategory value)? setCategory,
    TResult? Function(SetBrands value)? setBrands,
    TResult? Function(ClearFilter value)? clearFilter,
  }) {
    return fetchFilter?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SelectType value)? selectType,
    TResult Function(SelectSort value)? selectSort,
    TResult Function(FetchExtras value)? fetchFilter,
    TResult Function(SetExtras value)? setExtras,
    TResult Function(SetRangePrice value)? setRangePrice,
    TResult Function(SetCategory value)? setCategory,
    TResult Function(SetBrands value)? setBrands,
    TResult Function(ClearFilter value)? clearFilter,
    required TResult orElse(),
  }) {
    if (fetchFilter != null) {
      return fetchFilter(this);
    }
    return orElse();
  }
}

abstract class FetchExtras implements FilterEvent {
  const factory FetchExtras(
      {required final BuildContext context,
      final String? type,
      required final bool isPrice,
      final int? categoryId}) = _$FetchExtrasImpl;

  BuildContext get context;
  String? get type;
  bool get isPrice;
  int? get categoryId;

  /// Create a copy of FilterEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FetchExtrasImplCopyWith<_$FetchExtrasImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SetExtrasImplCopyWith<$Res> {
  factory _$$SetExtrasImplCopyWith(
          _$SetExtrasImpl value, $Res Function(_$SetExtrasImpl) then) =
      __$$SetExtrasImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<Value> ids});
}

/// @nodoc
class __$$SetExtrasImplCopyWithImpl<$Res>
    extends _$FilterEventCopyWithImpl<$Res, _$SetExtrasImpl>
    implements _$$SetExtrasImplCopyWith<$Res> {
  __$$SetExtrasImplCopyWithImpl(
      _$SetExtrasImpl _value, $Res Function(_$SetExtrasImpl) _then)
      : super(_value, _then);

  /// Create a copy of FilterEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? ids = null,
  }) {
    return _then(_$SetExtrasImpl(
      ids: null == ids
          ? _value._ids
          : ids // ignore: cast_nullable_to_non_nullable
              as List<Value>,
    ));
  }
}

/// @nodoc

class _$SetExtrasImpl implements SetExtras {
  const _$SetExtrasImpl({required final List<Value> ids}) : _ids = ids;

  final List<Value> _ids;
  @override
  List<Value> get ids {
    if (_ids is EqualUnmodifiableListView) return _ids;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_ids);
  }

  @override
  String toString() {
    return 'FilterEvent.setExtras(ids: $ids)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SetExtrasImpl &&
            const DeepCollectionEquality().equals(other._ids, _ids));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_ids));

  /// Create a copy of FilterEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SetExtrasImplCopyWith<_$SetExtrasImpl> get copyWith =>
      __$$SetExtrasImplCopyWithImpl<_$SetExtrasImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(LayoutType selectType) selectType,
    required TResult Function(FilterType type) selectSort,
    required TResult Function(
            BuildContext context, String? type, bool isPrice, int? categoryId)
        fetchFilter,
    required TResult Function(List<Value> ids) setExtras,
    required TResult Function(RangeValues price) setRangePrice,
    required TResult Function(CategoryData category) setCategory,
    required TResult Function(List<int> ids) setBrands,
    required TResult Function() clearFilter,
  }) {
    return setExtras(ids);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(LayoutType selectType)? selectType,
    TResult? Function(FilterType type)? selectSort,
    TResult? Function(
            BuildContext context, String? type, bool isPrice, int? categoryId)?
        fetchFilter,
    TResult? Function(List<Value> ids)? setExtras,
    TResult? Function(RangeValues price)? setRangePrice,
    TResult? Function(CategoryData category)? setCategory,
    TResult? Function(List<int> ids)? setBrands,
    TResult? Function()? clearFilter,
  }) {
    return setExtras?.call(ids);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(LayoutType selectType)? selectType,
    TResult Function(FilterType type)? selectSort,
    TResult Function(
            BuildContext context, String? type, bool isPrice, int? categoryId)?
        fetchFilter,
    TResult Function(List<Value> ids)? setExtras,
    TResult Function(RangeValues price)? setRangePrice,
    TResult Function(CategoryData category)? setCategory,
    TResult Function(List<int> ids)? setBrands,
    TResult Function()? clearFilter,
    required TResult orElse(),
  }) {
    if (setExtras != null) {
      return setExtras(ids);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SelectType value) selectType,
    required TResult Function(SelectSort value) selectSort,
    required TResult Function(FetchExtras value) fetchFilter,
    required TResult Function(SetExtras value) setExtras,
    required TResult Function(SetRangePrice value) setRangePrice,
    required TResult Function(SetCategory value) setCategory,
    required TResult Function(SetBrands value) setBrands,
    required TResult Function(ClearFilter value) clearFilter,
  }) {
    return setExtras(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SelectType value)? selectType,
    TResult? Function(SelectSort value)? selectSort,
    TResult? Function(FetchExtras value)? fetchFilter,
    TResult? Function(SetExtras value)? setExtras,
    TResult? Function(SetRangePrice value)? setRangePrice,
    TResult? Function(SetCategory value)? setCategory,
    TResult? Function(SetBrands value)? setBrands,
    TResult? Function(ClearFilter value)? clearFilter,
  }) {
    return setExtras?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SelectType value)? selectType,
    TResult Function(SelectSort value)? selectSort,
    TResult Function(FetchExtras value)? fetchFilter,
    TResult Function(SetExtras value)? setExtras,
    TResult Function(SetRangePrice value)? setRangePrice,
    TResult Function(SetCategory value)? setCategory,
    TResult Function(SetBrands value)? setBrands,
    TResult Function(ClearFilter value)? clearFilter,
    required TResult orElse(),
  }) {
    if (setExtras != null) {
      return setExtras(this);
    }
    return orElse();
  }
}

abstract class SetExtras implements FilterEvent {
  const factory SetExtras({required final List<Value> ids}) = _$SetExtrasImpl;

  List<Value> get ids;

  /// Create a copy of FilterEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SetExtrasImplCopyWith<_$SetExtrasImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SetRangePriceImplCopyWith<$Res> {
  factory _$$SetRangePriceImplCopyWith(
          _$SetRangePriceImpl value, $Res Function(_$SetRangePriceImpl) then) =
      __$$SetRangePriceImplCopyWithImpl<$Res>;
  @useResult
  $Res call({RangeValues price});
}

/// @nodoc
class __$$SetRangePriceImplCopyWithImpl<$Res>
    extends _$FilterEventCopyWithImpl<$Res, _$SetRangePriceImpl>
    implements _$$SetRangePriceImplCopyWith<$Res> {
  __$$SetRangePriceImplCopyWithImpl(
      _$SetRangePriceImpl _value, $Res Function(_$SetRangePriceImpl) _then)
      : super(_value, _then);

  /// Create a copy of FilterEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? price = null,
  }) {
    return _then(_$SetRangePriceImpl(
      price: null == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as RangeValues,
    ));
  }
}

/// @nodoc

class _$SetRangePriceImpl implements SetRangePrice {
  const _$SetRangePriceImpl({required this.price});

  @override
  final RangeValues price;

  @override
  String toString() {
    return 'FilterEvent.setRangePrice(price: $price)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SetRangePriceImpl &&
            (identical(other.price, price) || other.price == price));
  }

  @override
  int get hashCode => Object.hash(runtimeType, price);

  /// Create a copy of FilterEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SetRangePriceImplCopyWith<_$SetRangePriceImpl> get copyWith =>
      __$$SetRangePriceImplCopyWithImpl<_$SetRangePriceImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(LayoutType selectType) selectType,
    required TResult Function(FilterType type) selectSort,
    required TResult Function(
            BuildContext context, String? type, bool isPrice, int? categoryId)
        fetchFilter,
    required TResult Function(List<Value> ids) setExtras,
    required TResult Function(RangeValues price) setRangePrice,
    required TResult Function(CategoryData category) setCategory,
    required TResult Function(List<int> ids) setBrands,
    required TResult Function() clearFilter,
  }) {
    return setRangePrice(price);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(LayoutType selectType)? selectType,
    TResult? Function(FilterType type)? selectSort,
    TResult? Function(
            BuildContext context, String? type, bool isPrice, int? categoryId)?
        fetchFilter,
    TResult? Function(List<Value> ids)? setExtras,
    TResult? Function(RangeValues price)? setRangePrice,
    TResult? Function(CategoryData category)? setCategory,
    TResult? Function(List<int> ids)? setBrands,
    TResult? Function()? clearFilter,
  }) {
    return setRangePrice?.call(price);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(LayoutType selectType)? selectType,
    TResult Function(FilterType type)? selectSort,
    TResult Function(
            BuildContext context, String? type, bool isPrice, int? categoryId)?
        fetchFilter,
    TResult Function(List<Value> ids)? setExtras,
    TResult Function(RangeValues price)? setRangePrice,
    TResult Function(CategoryData category)? setCategory,
    TResult Function(List<int> ids)? setBrands,
    TResult Function()? clearFilter,
    required TResult orElse(),
  }) {
    if (setRangePrice != null) {
      return setRangePrice(price);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SelectType value) selectType,
    required TResult Function(SelectSort value) selectSort,
    required TResult Function(FetchExtras value) fetchFilter,
    required TResult Function(SetExtras value) setExtras,
    required TResult Function(SetRangePrice value) setRangePrice,
    required TResult Function(SetCategory value) setCategory,
    required TResult Function(SetBrands value) setBrands,
    required TResult Function(ClearFilter value) clearFilter,
  }) {
    return setRangePrice(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SelectType value)? selectType,
    TResult? Function(SelectSort value)? selectSort,
    TResult? Function(FetchExtras value)? fetchFilter,
    TResult? Function(SetExtras value)? setExtras,
    TResult? Function(SetRangePrice value)? setRangePrice,
    TResult? Function(SetCategory value)? setCategory,
    TResult? Function(SetBrands value)? setBrands,
    TResult? Function(ClearFilter value)? clearFilter,
  }) {
    return setRangePrice?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SelectType value)? selectType,
    TResult Function(SelectSort value)? selectSort,
    TResult Function(FetchExtras value)? fetchFilter,
    TResult Function(SetExtras value)? setExtras,
    TResult Function(SetRangePrice value)? setRangePrice,
    TResult Function(SetCategory value)? setCategory,
    TResult Function(SetBrands value)? setBrands,
    TResult Function(ClearFilter value)? clearFilter,
    required TResult orElse(),
  }) {
    if (setRangePrice != null) {
      return setRangePrice(this);
    }
    return orElse();
  }
}

abstract class SetRangePrice implements FilterEvent {
  const factory SetRangePrice({required final RangeValues price}) =
      _$SetRangePriceImpl;

  RangeValues get price;

  /// Create a copy of FilterEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SetRangePriceImplCopyWith<_$SetRangePriceImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SetCategoryImplCopyWith<$Res> {
  factory _$$SetCategoryImplCopyWith(
          _$SetCategoryImpl value, $Res Function(_$SetCategoryImpl) then) =
      __$$SetCategoryImplCopyWithImpl<$Res>;
  @useResult
  $Res call({CategoryData category});
}

/// @nodoc
class __$$SetCategoryImplCopyWithImpl<$Res>
    extends _$FilterEventCopyWithImpl<$Res, _$SetCategoryImpl>
    implements _$$SetCategoryImplCopyWith<$Res> {
  __$$SetCategoryImplCopyWithImpl(
      _$SetCategoryImpl _value, $Res Function(_$SetCategoryImpl) _then)
      : super(_value, _then);

  /// Create a copy of FilterEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? category = null,
  }) {
    return _then(_$SetCategoryImpl(
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as CategoryData,
    ));
  }
}

/// @nodoc

class _$SetCategoryImpl implements SetCategory {
  const _$SetCategoryImpl({required this.category});

  @override
  final CategoryData category;

  @override
  String toString() {
    return 'FilterEvent.setCategory(category: $category)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SetCategoryImpl &&
            (identical(other.category, category) ||
                other.category == category));
  }

  @override
  int get hashCode => Object.hash(runtimeType, category);

  /// Create a copy of FilterEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SetCategoryImplCopyWith<_$SetCategoryImpl> get copyWith =>
      __$$SetCategoryImplCopyWithImpl<_$SetCategoryImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(LayoutType selectType) selectType,
    required TResult Function(FilterType type) selectSort,
    required TResult Function(
            BuildContext context, String? type, bool isPrice, int? categoryId)
        fetchFilter,
    required TResult Function(List<Value> ids) setExtras,
    required TResult Function(RangeValues price) setRangePrice,
    required TResult Function(CategoryData category) setCategory,
    required TResult Function(List<int> ids) setBrands,
    required TResult Function() clearFilter,
  }) {
    return setCategory(category);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(LayoutType selectType)? selectType,
    TResult? Function(FilterType type)? selectSort,
    TResult? Function(
            BuildContext context, String? type, bool isPrice, int? categoryId)?
        fetchFilter,
    TResult? Function(List<Value> ids)? setExtras,
    TResult? Function(RangeValues price)? setRangePrice,
    TResult? Function(CategoryData category)? setCategory,
    TResult? Function(List<int> ids)? setBrands,
    TResult? Function()? clearFilter,
  }) {
    return setCategory?.call(category);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(LayoutType selectType)? selectType,
    TResult Function(FilterType type)? selectSort,
    TResult Function(
            BuildContext context, String? type, bool isPrice, int? categoryId)?
        fetchFilter,
    TResult Function(List<Value> ids)? setExtras,
    TResult Function(RangeValues price)? setRangePrice,
    TResult Function(CategoryData category)? setCategory,
    TResult Function(List<int> ids)? setBrands,
    TResult Function()? clearFilter,
    required TResult orElse(),
  }) {
    if (setCategory != null) {
      return setCategory(category);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SelectType value) selectType,
    required TResult Function(SelectSort value) selectSort,
    required TResult Function(FetchExtras value) fetchFilter,
    required TResult Function(SetExtras value) setExtras,
    required TResult Function(SetRangePrice value) setRangePrice,
    required TResult Function(SetCategory value) setCategory,
    required TResult Function(SetBrands value) setBrands,
    required TResult Function(ClearFilter value) clearFilter,
  }) {
    return setCategory(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SelectType value)? selectType,
    TResult? Function(SelectSort value)? selectSort,
    TResult? Function(FetchExtras value)? fetchFilter,
    TResult? Function(SetExtras value)? setExtras,
    TResult? Function(SetRangePrice value)? setRangePrice,
    TResult? Function(SetCategory value)? setCategory,
    TResult? Function(SetBrands value)? setBrands,
    TResult? Function(ClearFilter value)? clearFilter,
  }) {
    return setCategory?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SelectType value)? selectType,
    TResult Function(SelectSort value)? selectSort,
    TResult Function(FetchExtras value)? fetchFilter,
    TResult Function(SetExtras value)? setExtras,
    TResult Function(SetRangePrice value)? setRangePrice,
    TResult Function(SetCategory value)? setCategory,
    TResult Function(SetBrands value)? setBrands,
    TResult Function(ClearFilter value)? clearFilter,
    required TResult orElse(),
  }) {
    if (setCategory != null) {
      return setCategory(this);
    }
    return orElse();
  }
}

abstract class SetCategory implements FilterEvent {
  const factory SetCategory({required final CategoryData category}) =
      _$SetCategoryImpl;

  CategoryData get category;

  /// Create a copy of FilterEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SetCategoryImplCopyWith<_$SetCategoryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SetBrandsImplCopyWith<$Res> {
  factory _$$SetBrandsImplCopyWith(
          _$SetBrandsImpl value, $Res Function(_$SetBrandsImpl) then) =
      __$$SetBrandsImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<int> ids});
}

/// @nodoc
class __$$SetBrandsImplCopyWithImpl<$Res>
    extends _$FilterEventCopyWithImpl<$Res, _$SetBrandsImpl>
    implements _$$SetBrandsImplCopyWith<$Res> {
  __$$SetBrandsImplCopyWithImpl(
      _$SetBrandsImpl _value, $Res Function(_$SetBrandsImpl) _then)
      : super(_value, _then);

  /// Create a copy of FilterEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? ids = null,
  }) {
    return _then(_$SetBrandsImpl(
      ids: null == ids
          ? _value._ids
          : ids // ignore: cast_nullable_to_non_nullable
              as List<int>,
    ));
  }
}

/// @nodoc

class _$SetBrandsImpl implements SetBrands {
  const _$SetBrandsImpl({required final List<int> ids}) : _ids = ids;

  final List<int> _ids;
  @override
  List<int> get ids {
    if (_ids is EqualUnmodifiableListView) return _ids;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_ids);
  }

  @override
  String toString() {
    return 'FilterEvent.setBrands(ids: $ids)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SetBrandsImpl &&
            const DeepCollectionEquality().equals(other._ids, _ids));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_ids));

  /// Create a copy of FilterEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SetBrandsImplCopyWith<_$SetBrandsImpl> get copyWith =>
      __$$SetBrandsImplCopyWithImpl<_$SetBrandsImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(LayoutType selectType) selectType,
    required TResult Function(FilterType type) selectSort,
    required TResult Function(
            BuildContext context, String? type, bool isPrice, int? categoryId)
        fetchFilter,
    required TResult Function(List<Value> ids) setExtras,
    required TResult Function(RangeValues price) setRangePrice,
    required TResult Function(CategoryData category) setCategory,
    required TResult Function(List<int> ids) setBrands,
    required TResult Function() clearFilter,
  }) {
    return setBrands(ids);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(LayoutType selectType)? selectType,
    TResult? Function(FilterType type)? selectSort,
    TResult? Function(
            BuildContext context, String? type, bool isPrice, int? categoryId)?
        fetchFilter,
    TResult? Function(List<Value> ids)? setExtras,
    TResult? Function(RangeValues price)? setRangePrice,
    TResult? Function(CategoryData category)? setCategory,
    TResult? Function(List<int> ids)? setBrands,
    TResult? Function()? clearFilter,
  }) {
    return setBrands?.call(ids);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(LayoutType selectType)? selectType,
    TResult Function(FilterType type)? selectSort,
    TResult Function(
            BuildContext context, String? type, bool isPrice, int? categoryId)?
        fetchFilter,
    TResult Function(List<Value> ids)? setExtras,
    TResult Function(RangeValues price)? setRangePrice,
    TResult Function(CategoryData category)? setCategory,
    TResult Function(List<int> ids)? setBrands,
    TResult Function()? clearFilter,
    required TResult orElse(),
  }) {
    if (setBrands != null) {
      return setBrands(ids);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SelectType value) selectType,
    required TResult Function(SelectSort value) selectSort,
    required TResult Function(FetchExtras value) fetchFilter,
    required TResult Function(SetExtras value) setExtras,
    required TResult Function(SetRangePrice value) setRangePrice,
    required TResult Function(SetCategory value) setCategory,
    required TResult Function(SetBrands value) setBrands,
    required TResult Function(ClearFilter value) clearFilter,
  }) {
    return setBrands(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SelectType value)? selectType,
    TResult? Function(SelectSort value)? selectSort,
    TResult? Function(FetchExtras value)? fetchFilter,
    TResult? Function(SetExtras value)? setExtras,
    TResult? Function(SetRangePrice value)? setRangePrice,
    TResult? Function(SetCategory value)? setCategory,
    TResult? Function(SetBrands value)? setBrands,
    TResult? Function(ClearFilter value)? clearFilter,
  }) {
    return setBrands?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SelectType value)? selectType,
    TResult Function(SelectSort value)? selectSort,
    TResult Function(FetchExtras value)? fetchFilter,
    TResult Function(SetExtras value)? setExtras,
    TResult Function(SetRangePrice value)? setRangePrice,
    TResult Function(SetCategory value)? setCategory,
    TResult Function(SetBrands value)? setBrands,
    TResult Function(ClearFilter value)? clearFilter,
    required TResult orElse(),
  }) {
    if (setBrands != null) {
      return setBrands(this);
    }
    return orElse();
  }
}

abstract class SetBrands implements FilterEvent {
  const factory SetBrands({required final List<int> ids}) = _$SetBrandsImpl;

  List<int> get ids;

  /// Create a copy of FilterEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SetBrandsImplCopyWith<_$SetBrandsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ClearFilterImplCopyWith<$Res> {
  factory _$$ClearFilterImplCopyWith(
          _$ClearFilterImpl value, $Res Function(_$ClearFilterImpl) then) =
      __$$ClearFilterImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ClearFilterImplCopyWithImpl<$Res>
    extends _$FilterEventCopyWithImpl<$Res, _$ClearFilterImpl>
    implements _$$ClearFilterImplCopyWith<$Res> {
  __$$ClearFilterImplCopyWithImpl(
      _$ClearFilterImpl _value, $Res Function(_$ClearFilterImpl) _then)
      : super(_value, _then);

  /// Create a copy of FilterEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$ClearFilterImpl implements ClearFilter {
  const _$ClearFilterImpl();

  @override
  String toString() {
    return 'FilterEvent.clearFilter()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ClearFilterImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(LayoutType selectType) selectType,
    required TResult Function(FilterType type) selectSort,
    required TResult Function(
            BuildContext context, String? type, bool isPrice, int? categoryId)
        fetchFilter,
    required TResult Function(List<Value> ids) setExtras,
    required TResult Function(RangeValues price) setRangePrice,
    required TResult Function(CategoryData category) setCategory,
    required TResult Function(List<int> ids) setBrands,
    required TResult Function() clearFilter,
  }) {
    return clearFilter();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(LayoutType selectType)? selectType,
    TResult? Function(FilterType type)? selectSort,
    TResult? Function(
            BuildContext context, String? type, bool isPrice, int? categoryId)?
        fetchFilter,
    TResult? Function(List<Value> ids)? setExtras,
    TResult? Function(RangeValues price)? setRangePrice,
    TResult? Function(CategoryData category)? setCategory,
    TResult? Function(List<int> ids)? setBrands,
    TResult? Function()? clearFilter,
  }) {
    return clearFilter?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(LayoutType selectType)? selectType,
    TResult Function(FilterType type)? selectSort,
    TResult Function(
            BuildContext context, String? type, bool isPrice, int? categoryId)?
        fetchFilter,
    TResult Function(List<Value> ids)? setExtras,
    TResult Function(RangeValues price)? setRangePrice,
    TResult Function(CategoryData category)? setCategory,
    TResult Function(List<int> ids)? setBrands,
    TResult Function()? clearFilter,
    required TResult orElse(),
  }) {
    if (clearFilter != null) {
      return clearFilter();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SelectType value) selectType,
    required TResult Function(SelectSort value) selectSort,
    required TResult Function(FetchExtras value) fetchFilter,
    required TResult Function(SetExtras value) setExtras,
    required TResult Function(SetRangePrice value) setRangePrice,
    required TResult Function(SetCategory value) setCategory,
    required TResult Function(SetBrands value) setBrands,
    required TResult Function(ClearFilter value) clearFilter,
  }) {
    return clearFilter(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SelectType value)? selectType,
    TResult? Function(SelectSort value)? selectSort,
    TResult? Function(FetchExtras value)? fetchFilter,
    TResult? Function(SetExtras value)? setExtras,
    TResult? Function(SetRangePrice value)? setRangePrice,
    TResult? Function(SetCategory value)? setCategory,
    TResult? Function(SetBrands value)? setBrands,
    TResult? Function(ClearFilter value)? clearFilter,
  }) {
    return clearFilter?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SelectType value)? selectType,
    TResult Function(SelectSort value)? selectSort,
    TResult Function(FetchExtras value)? fetchFilter,
    TResult Function(SetExtras value)? setExtras,
    TResult Function(SetRangePrice value)? setRangePrice,
    TResult Function(SetCategory value)? setCategory,
    TResult Function(SetBrands value)? setBrands,
    TResult Function(ClearFilter value)? clearFilter,
    required TResult orElse(),
  }) {
    if (clearFilter != null) {
      return clearFilter(this);
    }
    return orElse();
  }
}

abstract class ClearFilter implements FilterEvent {
  const factory ClearFilter() = _$ClearFilterImpl;
}

/// @nodoc
mixin _$FilterState {
  LayoutType get selectType => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;
  FilterType get type => throw _privateConstructorUsedError;
  FilterResponse? get filter => throw _privateConstructorUsedError;
  Price? get filterPrices => throw _privateConstructorUsedError;
  List<Value> get attributes => throw _privateConstructorUsedError;
  List<int> get categories => throw _privateConstructorUsedError;
  List<int> get brands => throw _privateConstructorUsedError;
  List<int> get prices => throw _privateConstructorUsedError;
  RangeValues? get rangeValues => throw _privateConstructorUsedError;
  CategoryData? get category => throw _privateConstructorUsedError;

  /// Create a copy of FilterState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FilterStateCopyWith<FilterState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FilterStateCopyWith<$Res> {
  factory $FilterStateCopyWith(
          FilterState value, $Res Function(FilterState) then) =
      _$FilterStateCopyWithImpl<$Res, FilterState>;
  @useResult
  $Res call(
      {LayoutType selectType,
      bool isLoading,
      FilterType type,
      FilterResponse? filter,
      Price? filterPrices,
      List<Value> attributes,
      List<int> categories,
      List<int> brands,
      List<int> prices,
      RangeValues? rangeValues,
      CategoryData? category});
}

/// @nodoc
class _$FilterStateCopyWithImpl<$Res, $Val extends FilterState>
    implements $FilterStateCopyWith<$Res> {
  _$FilterStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FilterState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? selectType = null,
    Object? isLoading = null,
    Object? type = null,
    Object? filter = freezed,
    Object? filterPrices = freezed,
    Object? attributes = null,
    Object? categories = null,
    Object? brands = null,
    Object? prices = null,
    Object? rangeValues = freezed,
    Object? category = freezed,
  }) {
    return _then(_value.copyWith(
      selectType: null == selectType
          ? _value.selectType
          : selectType // ignore: cast_nullable_to_non_nullable
              as LayoutType,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as FilterType,
      filter: freezed == filter
          ? _value.filter
          : filter // ignore: cast_nullable_to_non_nullable
              as FilterResponse?,
      filterPrices: freezed == filterPrices
          ? _value.filterPrices
          : filterPrices // ignore: cast_nullable_to_non_nullable
              as Price?,
      attributes: null == attributes
          ? _value.attributes
          : attributes // ignore: cast_nullable_to_non_nullable
              as List<Value>,
      categories: null == categories
          ? _value.categories
          : categories // ignore: cast_nullable_to_non_nullable
              as List<int>,
      brands: null == brands
          ? _value.brands
          : brands // ignore: cast_nullable_to_non_nullable
              as List<int>,
      prices: null == prices
          ? _value.prices
          : prices // ignore: cast_nullable_to_non_nullable
              as List<int>,
      rangeValues: freezed == rangeValues
          ? _value.rangeValues
          : rangeValues // ignore: cast_nullable_to_non_nullable
              as RangeValues?,
      category: freezed == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as CategoryData?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FilterStateImplCopyWith<$Res>
    implements $FilterStateCopyWith<$Res> {
  factory _$$FilterStateImplCopyWith(
          _$FilterStateImpl value, $Res Function(_$FilterStateImpl) then) =
      __$$FilterStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {LayoutType selectType,
      bool isLoading,
      FilterType type,
      FilterResponse? filter,
      Price? filterPrices,
      List<Value> attributes,
      List<int> categories,
      List<int> brands,
      List<int> prices,
      RangeValues? rangeValues,
      CategoryData? category});
}

/// @nodoc
class __$$FilterStateImplCopyWithImpl<$Res>
    extends _$FilterStateCopyWithImpl<$Res, _$FilterStateImpl>
    implements _$$FilterStateImplCopyWith<$Res> {
  __$$FilterStateImplCopyWithImpl(
      _$FilterStateImpl _value, $Res Function(_$FilterStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of FilterState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? selectType = null,
    Object? isLoading = null,
    Object? type = null,
    Object? filter = freezed,
    Object? filterPrices = freezed,
    Object? attributes = null,
    Object? categories = null,
    Object? brands = null,
    Object? prices = null,
    Object? rangeValues = freezed,
    Object? category = freezed,
  }) {
    return _then(_$FilterStateImpl(
      selectType: null == selectType
          ? _value.selectType
          : selectType // ignore: cast_nullable_to_non_nullable
              as LayoutType,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as FilterType,
      filter: freezed == filter
          ? _value.filter
          : filter // ignore: cast_nullable_to_non_nullable
              as FilterResponse?,
      filterPrices: freezed == filterPrices
          ? _value.filterPrices
          : filterPrices // ignore: cast_nullable_to_non_nullable
              as Price?,
      attributes: null == attributes
          ? _value._attributes
          : attributes // ignore: cast_nullable_to_non_nullable
              as List<Value>,
      categories: null == categories
          ? _value._categories
          : categories // ignore: cast_nullable_to_non_nullable
              as List<int>,
      brands: null == brands
          ? _value._brands
          : brands // ignore: cast_nullable_to_non_nullable
              as List<int>,
      prices: null == prices
          ? _value._prices
          : prices // ignore: cast_nullable_to_non_nullable
              as List<int>,
      rangeValues: freezed == rangeValues
          ? _value.rangeValues
          : rangeValues // ignore: cast_nullable_to_non_nullable
              as RangeValues?,
      category: freezed == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as CategoryData?,
    ));
  }
}

/// @nodoc

class _$FilterStateImpl implements _FilterState {
  const _$FilterStateImpl(
      {this.selectType = LayoutType.twoH,
      this.isLoading = true,
      this.type = FilterType.news,
      this.filter = null,
      this.filterPrices = null,
      final List<Value> attributes = const [],
      final List<int> categories = const [],
      final List<int> brands = const [],
      final List<int> prices = const [],
      this.rangeValues = null,
      this.category = null})
      : _attributes = attributes,
        _categories = categories,
        _brands = brands,
        _prices = prices;

  @override
  @JsonKey()
  final LayoutType selectType;
  @override
  @JsonKey()
  final bool isLoading;
  @override
  @JsonKey()
  final FilterType type;
  @override
  @JsonKey()
  final FilterResponse? filter;
  @override
  @JsonKey()
  final Price? filterPrices;
  final List<Value> _attributes;
  @override
  @JsonKey()
  List<Value> get attributes {
    if (_attributes is EqualUnmodifiableListView) return _attributes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_attributes);
  }

  final List<int> _categories;
  @override
  @JsonKey()
  List<int> get categories {
    if (_categories is EqualUnmodifiableListView) return _categories;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_categories);
  }

  final List<int> _brands;
  @override
  @JsonKey()
  List<int> get brands {
    if (_brands is EqualUnmodifiableListView) return _brands;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_brands);
  }

  final List<int> _prices;
  @override
  @JsonKey()
  List<int> get prices {
    if (_prices is EqualUnmodifiableListView) return _prices;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_prices);
  }

  @override
  @JsonKey()
  final RangeValues? rangeValues;
  @override
  @JsonKey()
  final CategoryData? category;

  @override
  String toString() {
    return 'FilterState(selectType: $selectType, isLoading: $isLoading, type: $type, filter: $filter, filterPrices: $filterPrices, attributes: $attributes, categories: $categories, brands: $brands, prices: $prices, rangeValues: $rangeValues, category: $category)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FilterStateImpl &&
            (identical(other.selectType, selectType) ||
                other.selectType == selectType) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.filter, filter) || other.filter == filter) &&
            (identical(other.filterPrices, filterPrices) ||
                other.filterPrices == filterPrices) &&
            const DeepCollectionEquality()
                .equals(other._attributes, _attributes) &&
            const DeepCollectionEquality()
                .equals(other._categories, _categories) &&
            const DeepCollectionEquality().equals(other._brands, _brands) &&
            const DeepCollectionEquality().equals(other._prices, _prices) &&
            (identical(other.rangeValues, rangeValues) ||
                other.rangeValues == rangeValues) &&
            (identical(other.category, category) ||
                other.category == category));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      selectType,
      isLoading,
      type,
      filter,
      filterPrices,
      const DeepCollectionEquality().hash(_attributes),
      const DeepCollectionEquality().hash(_categories),
      const DeepCollectionEquality().hash(_brands),
      const DeepCollectionEquality().hash(_prices),
      rangeValues,
      category);

  /// Create a copy of FilterState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FilterStateImplCopyWith<_$FilterStateImpl> get copyWith =>
      __$$FilterStateImplCopyWithImpl<_$FilterStateImpl>(this, _$identity);
}

abstract class _FilterState implements FilterState {
  const factory _FilterState(
      {final LayoutType selectType,
      final bool isLoading,
      final FilterType type,
      final FilterResponse? filter,
      final Price? filterPrices,
      final List<Value> attributes,
      final List<int> categories,
      final List<int> brands,
      final List<int> prices,
      final RangeValues? rangeValues,
      final CategoryData? category}) = _$FilterStateImpl;

  @override
  LayoutType get selectType;
  @override
  bool get isLoading;
  @override
  FilterType get type;
  @override
  FilterResponse? get filter;
  @override
  Price? get filterPrices;
  @override
  List<Value> get attributes;
  @override
  List<int> get categories;
  @override
  List<int> get brands;
  @override
  List<int> get prices;
  @override
  RangeValues? get rangeValues;
  @override
  CategoryData? get category;

  /// Create a copy of FilterState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FilterStateImplCopyWith<_$FilterStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
