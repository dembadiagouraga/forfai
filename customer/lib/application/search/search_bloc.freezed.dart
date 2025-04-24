// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'search_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$SearchEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String query, int? userId, int? categoryId)
        setQuery,
    required TResult Function(BuildContext context) searchProduct,
    required TResult Function(BuildContext context) searchCategory,
    required TResult Function(BuildContext context) searchBrand,
    required TResult Function() updateRecently,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String query, int? userId, int? categoryId)? setQuery,
    TResult? Function(BuildContext context)? searchProduct,
    TResult? Function(BuildContext context)? searchCategory,
    TResult? Function(BuildContext context)? searchBrand,
    TResult? Function()? updateRecently,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String query, int? userId, int? categoryId)? setQuery,
    TResult Function(BuildContext context)? searchProduct,
    TResult Function(BuildContext context)? searchCategory,
    TResult Function(BuildContext context)? searchBrand,
    TResult Function()? updateRecently,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SetQuery value) setQuery,
    required TResult Function(SearchProduct value) searchProduct,
    required TResult Function(SearchCategory value) searchCategory,
    required TResult Function(SearchBrand value) searchBrand,
    required TResult Function(UpdateRecently value) updateRecently,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SetQuery value)? setQuery,
    TResult? Function(SearchProduct value)? searchProduct,
    TResult? Function(SearchCategory value)? searchCategory,
    TResult? Function(SearchBrand value)? searchBrand,
    TResult? Function(UpdateRecently value)? updateRecently,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SetQuery value)? setQuery,
    TResult Function(SearchProduct value)? searchProduct,
    TResult Function(SearchCategory value)? searchCategory,
    TResult Function(SearchBrand value)? searchBrand,
    TResult Function(UpdateRecently value)? updateRecently,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SearchEventCopyWith<$Res> {
  factory $SearchEventCopyWith(
          SearchEvent value, $Res Function(SearchEvent) then) =
      _$SearchEventCopyWithImpl<$Res, SearchEvent>;
}

/// @nodoc
class _$SearchEventCopyWithImpl<$Res, $Val extends SearchEvent>
    implements $SearchEventCopyWith<$Res> {
  _$SearchEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SearchEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$SetQueryImplCopyWith<$Res> {
  factory _$$SetQueryImplCopyWith(
          _$SetQueryImpl value, $Res Function(_$SetQueryImpl) then) =
      __$$SetQueryImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String query, int? userId, int? categoryId});
}

/// @nodoc
class __$$SetQueryImplCopyWithImpl<$Res>
    extends _$SearchEventCopyWithImpl<$Res, _$SetQueryImpl>
    implements _$$SetQueryImplCopyWith<$Res> {
  __$$SetQueryImplCopyWithImpl(
      _$SetQueryImpl _value, $Res Function(_$SetQueryImpl) _then)
      : super(_value, _then);

  /// Create a copy of SearchEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? query = null,
    Object? userId = freezed,
    Object? categoryId = freezed,
  }) {
    return _then(_$SetQueryImpl(
      query: null == query
          ? _value.query
          : query // ignore: cast_nullable_to_non_nullable
              as String,
      userId: freezed == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as int?,
      categoryId: freezed == categoryId
          ? _value.categoryId
          : categoryId // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc

class _$SetQueryImpl implements SetQuery {
  const _$SetQueryImpl({required this.query, this.userId, this.categoryId});

  @override
  final String query;
  @override
  final int? userId;
  @override
  final int? categoryId;

  @override
  String toString() {
    return 'SearchEvent.setQuery(query: $query, userId: $userId, categoryId: $categoryId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SetQueryImpl &&
            (identical(other.query, query) || other.query == query) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.categoryId, categoryId) ||
                other.categoryId == categoryId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, query, userId, categoryId);

  /// Create a copy of SearchEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SetQueryImplCopyWith<_$SetQueryImpl> get copyWith =>
      __$$SetQueryImplCopyWithImpl<_$SetQueryImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String query, int? userId, int? categoryId)
        setQuery,
    required TResult Function(BuildContext context) searchProduct,
    required TResult Function(BuildContext context) searchCategory,
    required TResult Function(BuildContext context) searchBrand,
    required TResult Function() updateRecently,
  }) {
    return setQuery(query, userId, categoryId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String query, int? userId, int? categoryId)? setQuery,
    TResult? Function(BuildContext context)? searchProduct,
    TResult? Function(BuildContext context)? searchCategory,
    TResult? Function(BuildContext context)? searchBrand,
    TResult? Function()? updateRecently,
  }) {
    return setQuery?.call(query, userId, categoryId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String query, int? userId, int? categoryId)? setQuery,
    TResult Function(BuildContext context)? searchProduct,
    TResult Function(BuildContext context)? searchCategory,
    TResult Function(BuildContext context)? searchBrand,
    TResult Function()? updateRecently,
    required TResult orElse(),
  }) {
    if (setQuery != null) {
      return setQuery(query, userId, categoryId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SetQuery value) setQuery,
    required TResult Function(SearchProduct value) searchProduct,
    required TResult Function(SearchCategory value) searchCategory,
    required TResult Function(SearchBrand value) searchBrand,
    required TResult Function(UpdateRecently value) updateRecently,
  }) {
    return setQuery(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SetQuery value)? setQuery,
    TResult? Function(SearchProduct value)? searchProduct,
    TResult? Function(SearchCategory value)? searchCategory,
    TResult? Function(SearchBrand value)? searchBrand,
    TResult? Function(UpdateRecently value)? updateRecently,
  }) {
    return setQuery?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SetQuery value)? setQuery,
    TResult Function(SearchProduct value)? searchProduct,
    TResult Function(SearchCategory value)? searchCategory,
    TResult Function(SearchBrand value)? searchBrand,
    TResult Function(UpdateRecently value)? updateRecently,
    required TResult orElse(),
  }) {
    if (setQuery != null) {
      return setQuery(this);
    }
    return orElse();
  }
}

abstract class SetQuery implements SearchEvent {
  const factory SetQuery(
      {required final String query,
      final int? userId,
      final int? categoryId}) = _$SetQueryImpl;

  String get query;
  int? get userId;
  int? get categoryId;

  /// Create a copy of SearchEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SetQueryImplCopyWith<_$SetQueryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SearchProductImplCopyWith<$Res> {
  factory _$$SearchProductImplCopyWith(
          _$SearchProductImpl value, $Res Function(_$SearchProductImpl) then) =
      __$$SearchProductImplCopyWithImpl<$Res>;
  @useResult
  $Res call({BuildContext context});
}

/// @nodoc
class __$$SearchProductImplCopyWithImpl<$Res>
    extends _$SearchEventCopyWithImpl<$Res, _$SearchProductImpl>
    implements _$$SearchProductImplCopyWith<$Res> {
  __$$SearchProductImplCopyWithImpl(
      _$SearchProductImpl _value, $Res Function(_$SearchProductImpl) _then)
      : super(_value, _then);

  /// Create a copy of SearchEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? context = null,
  }) {
    return _then(_$SearchProductImpl(
      context: null == context
          ? _value.context
          : context // ignore: cast_nullable_to_non_nullable
              as BuildContext,
    ));
  }
}

/// @nodoc

class _$SearchProductImpl implements SearchProduct {
  const _$SearchProductImpl({required this.context});

  @override
  final BuildContext context;

  @override
  String toString() {
    return 'SearchEvent.searchProduct(context: $context)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SearchProductImpl &&
            (identical(other.context, context) || other.context == context));
  }

  @override
  int get hashCode => Object.hash(runtimeType, context);

  /// Create a copy of SearchEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SearchProductImplCopyWith<_$SearchProductImpl> get copyWith =>
      __$$SearchProductImplCopyWithImpl<_$SearchProductImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String query, int? userId, int? categoryId)
        setQuery,
    required TResult Function(BuildContext context) searchProduct,
    required TResult Function(BuildContext context) searchCategory,
    required TResult Function(BuildContext context) searchBrand,
    required TResult Function() updateRecently,
  }) {
    return searchProduct(context);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String query, int? userId, int? categoryId)? setQuery,
    TResult? Function(BuildContext context)? searchProduct,
    TResult? Function(BuildContext context)? searchCategory,
    TResult? Function(BuildContext context)? searchBrand,
    TResult? Function()? updateRecently,
  }) {
    return searchProduct?.call(context);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String query, int? userId, int? categoryId)? setQuery,
    TResult Function(BuildContext context)? searchProduct,
    TResult Function(BuildContext context)? searchCategory,
    TResult Function(BuildContext context)? searchBrand,
    TResult Function()? updateRecently,
    required TResult orElse(),
  }) {
    if (searchProduct != null) {
      return searchProduct(context);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SetQuery value) setQuery,
    required TResult Function(SearchProduct value) searchProduct,
    required TResult Function(SearchCategory value) searchCategory,
    required TResult Function(SearchBrand value) searchBrand,
    required TResult Function(UpdateRecently value) updateRecently,
  }) {
    return searchProduct(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SetQuery value)? setQuery,
    TResult? Function(SearchProduct value)? searchProduct,
    TResult? Function(SearchCategory value)? searchCategory,
    TResult? Function(SearchBrand value)? searchBrand,
    TResult? Function(UpdateRecently value)? updateRecently,
  }) {
    return searchProduct?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SetQuery value)? setQuery,
    TResult Function(SearchProduct value)? searchProduct,
    TResult Function(SearchCategory value)? searchCategory,
    TResult Function(SearchBrand value)? searchBrand,
    TResult Function(UpdateRecently value)? updateRecently,
    required TResult orElse(),
  }) {
    if (searchProduct != null) {
      return searchProduct(this);
    }
    return orElse();
  }
}

abstract class SearchProduct implements SearchEvent {
  const factory SearchProduct({required final BuildContext context}) =
      _$SearchProductImpl;

  BuildContext get context;

  /// Create a copy of SearchEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SearchProductImplCopyWith<_$SearchProductImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SearchCategoryImplCopyWith<$Res> {
  factory _$$SearchCategoryImplCopyWith(_$SearchCategoryImpl value,
          $Res Function(_$SearchCategoryImpl) then) =
      __$$SearchCategoryImplCopyWithImpl<$Res>;
  @useResult
  $Res call({BuildContext context});
}

/// @nodoc
class __$$SearchCategoryImplCopyWithImpl<$Res>
    extends _$SearchEventCopyWithImpl<$Res, _$SearchCategoryImpl>
    implements _$$SearchCategoryImplCopyWith<$Res> {
  __$$SearchCategoryImplCopyWithImpl(
      _$SearchCategoryImpl _value, $Res Function(_$SearchCategoryImpl) _then)
      : super(_value, _then);

  /// Create a copy of SearchEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? context = null,
  }) {
    return _then(_$SearchCategoryImpl(
      context: null == context
          ? _value.context
          : context // ignore: cast_nullable_to_non_nullable
              as BuildContext,
    ));
  }
}

/// @nodoc

class _$SearchCategoryImpl implements SearchCategory {
  const _$SearchCategoryImpl({required this.context});

  @override
  final BuildContext context;

  @override
  String toString() {
    return 'SearchEvent.searchCategory(context: $context)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SearchCategoryImpl &&
            (identical(other.context, context) || other.context == context));
  }

  @override
  int get hashCode => Object.hash(runtimeType, context);

  /// Create a copy of SearchEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SearchCategoryImplCopyWith<_$SearchCategoryImpl> get copyWith =>
      __$$SearchCategoryImplCopyWithImpl<_$SearchCategoryImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String query, int? userId, int? categoryId)
        setQuery,
    required TResult Function(BuildContext context) searchProduct,
    required TResult Function(BuildContext context) searchCategory,
    required TResult Function(BuildContext context) searchBrand,
    required TResult Function() updateRecently,
  }) {
    return searchCategory(context);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String query, int? userId, int? categoryId)? setQuery,
    TResult? Function(BuildContext context)? searchProduct,
    TResult? Function(BuildContext context)? searchCategory,
    TResult? Function(BuildContext context)? searchBrand,
    TResult? Function()? updateRecently,
  }) {
    return searchCategory?.call(context);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String query, int? userId, int? categoryId)? setQuery,
    TResult Function(BuildContext context)? searchProduct,
    TResult Function(BuildContext context)? searchCategory,
    TResult Function(BuildContext context)? searchBrand,
    TResult Function()? updateRecently,
    required TResult orElse(),
  }) {
    if (searchCategory != null) {
      return searchCategory(context);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SetQuery value) setQuery,
    required TResult Function(SearchProduct value) searchProduct,
    required TResult Function(SearchCategory value) searchCategory,
    required TResult Function(SearchBrand value) searchBrand,
    required TResult Function(UpdateRecently value) updateRecently,
  }) {
    return searchCategory(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SetQuery value)? setQuery,
    TResult? Function(SearchProduct value)? searchProduct,
    TResult? Function(SearchCategory value)? searchCategory,
    TResult? Function(SearchBrand value)? searchBrand,
    TResult? Function(UpdateRecently value)? updateRecently,
  }) {
    return searchCategory?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SetQuery value)? setQuery,
    TResult Function(SearchProduct value)? searchProduct,
    TResult Function(SearchCategory value)? searchCategory,
    TResult Function(SearchBrand value)? searchBrand,
    TResult Function(UpdateRecently value)? updateRecently,
    required TResult orElse(),
  }) {
    if (searchCategory != null) {
      return searchCategory(this);
    }
    return orElse();
  }
}

abstract class SearchCategory implements SearchEvent {
  const factory SearchCategory({required final BuildContext context}) =
      _$SearchCategoryImpl;

  BuildContext get context;

  /// Create a copy of SearchEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SearchCategoryImplCopyWith<_$SearchCategoryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SearchBrandImplCopyWith<$Res> {
  factory _$$SearchBrandImplCopyWith(
          _$SearchBrandImpl value, $Res Function(_$SearchBrandImpl) then) =
      __$$SearchBrandImplCopyWithImpl<$Res>;
  @useResult
  $Res call({BuildContext context});
}

/// @nodoc
class __$$SearchBrandImplCopyWithImpl<$Res>
    extends _$SearchEventCopyWithImpl<$Res, _$SearchBrandImpl>
    implements _$$SearchBrandImplCopyWith<$Res> {
  __$$SearchBrandImplCopyWithImpl(
      _$SearchBrandImpl _value, $Res Function(_$SearchBrandImpl) _then)
      : super(_value, _then);

  /// Create a copy of SearchEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? context = null,
  }) {
    return _then(_$SearchBrandImpl(
      context: null == context
          ? _value.context
          : context // ignore: cast_nullable_to_non_nullable
              as BuildContext,
    ));
  }
}

/// @nodoc

class _$SearchBrandImpl implements SearchBrand {
  const _$SearchBrandImpl({required this.context});

  @override
  final BuildContext context;

  @override
  String toString() {
    return 'SearchEvent.searchBrand(context: $context)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SearchBrandImpl &&
            (identical(other.context, context) || other.context == context));
  }

  @override
  int get hashCode => Object.hash(runtimeType, context);

  /// Create a copy of SearchEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SearchBrandImplCopyWith<_$SearchBrandImpl> get copyWith =>
      __$$SearchBrandImplCopyWithImpl<_$SearchBrandImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String query, int? userId, int? categoryId)
        setQuery,
    required TResult Function(BuildContext context) searchProduct,
    required TResult Function(BuildContext context) searchCategory,
    required TResult Function(BuildContext context) searchBrand,
    required TResult Function() updateRecently,
  }) {
    return searchBrand(context);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String query, int? userId, int? categoryId)? setQuery,
    TResult? Function(BuildContext context)? searchProduct,
    TResult? Function(BuildContext context)? searchCategory,
    TResult? Function(BuildContext context)? searchBrand,
    TResult? Function()? updateRecently,
  }) {
    return searchBrand?.call(context);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String query, int? userId, int? categoryId)? setQuery,
    TResult Function(BuildContext context)? searchProduct,
    TResult Function(BuildContext context)? searchCategory,
    TResult Function(BuildContext context)? searchBrand,
    TResult Function()? updateRecently,
    required TResult orElse(),
  }) {
    if (searchBrand != null) {
      return searchBrand(context);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SetQuery value) setQuery,
    required TResult Function(SearchProduct value) searchProduct,
    required TResult Function(SearchCategory value) searchCategory,
    required TResult Function(SearchBrand value) searchBrand,
    required TResult Function(UpdateRecently value) updateRecently,
  }) {
    return searchBrand(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SetQuery value)? setQuery,
    TResult? Function(SearchProduct value)? searchProduct,
    TResult? Function(SearchCategory value)? searchCategory,
    TResult? Function(SearchBrand value)? searchBrand,
    TResult? Function(UpdateRecently value)? updateRecently,
  }) {
    return searchBrand?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SetQuery value)? setQuery,
    TResult Function(SearchProduct value)? searchProduct,
    TResult Function(SearchCategory value)? searchCategory,
    TResult Function(SearchBrand value)? searchBrand,
    TResult Function(UpdateRecently value)? updateRecently,
    required TResult orElse(),
  }) {
    if (searchBrand != null) {
      return searchBrand(this);
    }
    return orElse();
  }
}

abstract class SearchBrand implements SearchEvent {
  const factory SearchBrand({required final BuildContext context}) =
      _$SearchBrandImpl;

  BuildContext get context;

  /// Create a copy of SearchEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SearchBrandImplCopyWith<_$SearchBrandImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$UpdateRecentlyImplCopyWith<$Res> {
  factory _$$UpdateRecentlyImplCopyWith(_$UpdateRecentlyImpl value,
          $Res Function(_$UpdateRecentlyImpl) then) =
      __$$UpdateRecentlyImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$UpdateRecentlyImplCopyWithImpl<$Res>
    extends _$SearchEventCopyWithImpl<$Res, _$UpdateRecentlyImpl>
    implements _$$UpdateRecentlyImplCopyWith<$Res> {
  __$$UpdateRecentlyImplCopyWithImpl(
      _$UpdateRecentlyImpl _value, $Res Function(_$UpdateRecentlyImpl) _then)
      : super(_value, _then);

  /// Create a copy of SearchEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$UpdateRecentlyImpl implements UpdateRecently {
  const _$UpdateRecentlyImpl();

  @override
  String toString() {
    return 'SearchEvent.updateRecently()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$UpdateRecentlyImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String query, int? userId, int? categoryId)
        setQuery,
    required TResult Function(BuildContext context) searchProduct,
    required TResult Function(BuildContext context) searchCategory,
    required TResult Function(BuildContext context) searchBrand,
    required TResult Function() updateRecently,
  }) {
    return updateRecently();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String query, int? userId, int? categoryId)? setQuery,
    TResult? Function(BuildContext context)? searchProduct,
    TResult? Function(BuildContext context)? searchCategory,
    TResult? Function(BuildContext context)? searchBrand,
    TResult? Function()? updateRecently,
  }) {
    return updateRecently?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String query, int? userId, int? categoryId)? setQuery,
    TResult Function(BuildContext context)? searchProduct,
    TResult Function(BuildContext context)? searchCategory,
    TResult Function(BuildContext context)? searchBrand,
    TResult Function()? updateRecently,
    required TResult orElse(),
  }) {
    if (updateRecently != null) {
      return updateRecently();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SetQuery value) setQuery,
    required TResult Function(SearchProduct value) searchProduct,
    required TResult Function(SearchCategory value) searchCategory,
    required TResult Function(SearchBrand value) searchBrand,
    required TResult Function(UpdateRecently value) updateRecently,
  }) {
    return updateRecently(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SetQuery value)? setQuery,
    TResult? Function(SearchProduct value)? searchProduct,
    TResult? Function(SearchCategory value)? searchCategory,
    TResult? Function(SearchBrand value)? searchBrand,
    TResult? Function(UpdateRecently value)? updateRecently,
  }) {
    return updateRecently?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SetQuery value)? setQuery,
    TResult Function(SearchProduct value)? searchProduct,
    TResult Function(SearchCategory value)? searchCategory,
    TResult Function(SearchBrand value)? searchBrand,
    TResult Function(UpdateRecently value)? updateRecently,
    required TResult orElse(),
  }) {
    if (updateRecently != null) {
      return updateRecently(this);
    }
    return orElse();
  }
}

abstract class UpdateRecently implements SearchEvent {
  const factory UpdateRecently() = _$UpdateRecentlyImpl;
}

/// @nodoc
mixin _$SearchState {
  List<ProductData> get products => throw _privateConstructorUsedError;
  List<CategoryData> get categories => throw _privateConstructorUsedError;
  List<BrandData> get brands => throw _privateConstructorUsedError;
  bool get isShopLoading => throw _privateConstructorUsedError;
  bool get isProductLoading => throw _privateConstructorUsedError;
  bool get isCategoryLoading => throw _privateConstructorUsedError;
  bool get isBrandLoading => throw _privateConstructorUsedError;
  String get query => throw _privateConstructorUsedError;

  /// Create a copy of SearchState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SearchStateCopyWith<SearchState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SearchStateCopyWith<$Res> {
  factory $SearchStateCopyWith(
          SearchState value, $Res Function(SearchState) then) =
      _$SearchStateCopyWithImpl<$Res, SearchState>;
  @useResult
  $Res call(
      {List<ProductData> products,
      List<CategoryData> categories,
      List<BrandData> brands,
      bool isShopLoading,
      bool isProductLoading,
      bool isCategoryLoading,
      bool isBrandLoading,
      String query});
}

/// @nodoc
class _$SearchStateCopyWithImpl<$Res, $Val extends SearchState>
    implements $SearchStateCopyWith<$Res> {
  _$SearchStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SearchState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? products = null,
    Object? categories = null,
    Object? brands = null,
    Object? isShopLoading = null,
    Object? isProductLoading = null,
    Object? isCategoryLoading = null,
    Object? isBrandLoading = null,
    Object? query = null,
  }) {
    return _then(_value.copyWith(
      products: null == products
          ? _value.products
          : products // ignore: cast_nullable_to_non_nullable
              as List<ProductData>,
      categories: null == categories
          ? _value.categories
          : categories // ignore: cast_nullable_to_non_nullable
              as List<CategoryData>,
      brands: null == brands
          ? _value.brands
          : brands // ignore: cast_nullable_to_non_nullable
              as List<BrandData>,
      isShopLoading: null == isShopLoading
          ? _value.isShopLoading
          : isShopLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isProductLoading: null == isProductLoading
          ? _value.isProductLoading
          : isProductLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isCategoryLoading: null == isCategoryLoading
          ? _value.isCategoryLoading
          : isCategoryLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isBrandLoading: null == isBrandLoading
          ? _value.isBrandLoading
          : isBrandLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      query: null == query
          ? _value.query
          : query // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SearchStateImplCopyWith<$Res>
    implements $SearchStateCopyWith<$Res> {
  factory _$$SearchStateImplCopyWith(
          _$SearchStateImpl value, $Res Function(_$SearchStateImpl) then) =
      __$$SearchStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<ProductData> products,
      List<CategoryData> categories,
      List<BrandData> brands,
      bool isShopLoading,
      bool isProductLoading,
      bool isCategoryLoading,
      bool isBrandLoading,
      String query});
}

/// @nodoc
class __$$SearchStateImplCopyWithImpl<$Res>
    extends _$SearchStateCopyWithImpl<$Res, _$SearchStateImpl>
    implements _$$SearchStateImplCopyWith<$Res> {
  __$$SearchStateImplCopyWithImpl(
      _$SearchStateImpl _value, $Res Function(_$SearchStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of SearchState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? products = null,
    Object? categories = null,
    Object? brands = null,
    Object? isShopLoading = null,
    Object? isProductLoading = null,
    Object? isCategoryLoading = null,
    Object? isBrandLoading = null,
    Object? query = null,
  }) {
    return _then(_$SearchStateImpl(
      products: null == products
          ? _value._products
          : products // ignore: cast_nullable_to_non_nullable
              as List<ProductData>,
      categories: null == categories
          ? _value._categories
          : categories // ignore: cast_nullable_to_non_nullable
              as List<CategoryData>,
      brands: null == brands
          ? _value._brands
          : brands // ignore: cast_nullable_to_non_nullable
              as List<BrandData>,
      isShopLoading: null == isShopLoading
          ? _value.isShopLoading
          : isShopLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isProductLoading: null == isProductLoading
          ? _value.isProductLoading
          : isProductLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isCategoryLoading: null == isCategoryLoading
          ? _value.isCategoryLoading
          : isCategoryLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isBrandLoading: null == isBrandLoading
          ? _value.isBrandLoading
          : isBrandLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      query: null == query
          ? _value.query
          : query // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$SearchStateImpl implements _SearchState {
  const _$SearchStateImpl(
      {final List<ProductData> products = const [],
      final List<CategoryData> categories = const [],
      final List<BrandData> brands = const [],
      this.isShopLoading = false,
      this.isProductLoading = false,
      this.isCategoryLoading = false,
      this.isBrandLoading = false,
      this.query = ""})
      : _products = products,
        _categories = categories,
        _brands = brands;

  final List<ProductData> _products;
  @override
  @JsonKey()
  List<ProductData> get products {
    if (_products is EqualUnmodifiableListView) return _products;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_products);
  }

  final List<CategoryData> _categories;
  @override
  @JsonKey()
  List<CategoryData> get categories {
    if (_categories is EqualUnmodifiableListView) return _categories;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_categories);
  }

  final List<BrandData> _brands;
  @override
  @JsonKey()
  List<BrandData> get brands {
    if (_brands is EqualUnmodifiableListView) return _brands;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_brands);
  }

  @override
  @JsonKey()
  final bool isShopLoading;
  @override
  @JsonKey()
  final bool isProductLoading;
  @override
  @JsonKey()
  final bool isCategoryLoading;
  @override
  @JsonKey()
  final bool isBrandLoading;
  @override
  @JsonKey()
  final String query;

  @override
  String toString() {
    return 'SearchState(products: $products, categories: $categories, brands: $brands, isShopLoading: $isShopLoading, isProductLoading: $isProductLoading, isCategoryLoading: $isCategoryLoading, isBrandLoading: $isBrandLoading, query: $query)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SearchStateImpl &&
            const DeepCollectionEquality().equals(other._products, _products) &&
            const DeepCollectionEquality()
                .equals(other._categories, _categories) &&
            const DeepCollectionEquality().equals(other._brands, _brands) &&
            (identical(other.isShopLoading, isShopLoading) ||
                other.isShopLoading == isShopLoading) &&
            (identical(other.isProductLoading, isProductLoading) ||
                other.isProductLoading == isProductLoading) &&
            (identical(other.isCategoryLoading, isCategoryLoading) ||
                other.isCategoryLoading == isCategoryLoading) &&
            (identical(other.isBrandLoading, isBrandLoading) ||
                other.isBrandLoading == isBrandLoading) &&
            (identical(other.query, query) || other.query == query));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_products),
      const DeepCollectionEquality().hash(_categories),
      const DeepCollectionEquality().hash(_brands),
      isShopLoading,
      isProductLoading,
      isCategoryLoading,
      isBrandLoading,
      query);

  /// Create a copy of SearchState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SearchStateImplCopyWith<_$SearchStateImpl> get copyWith =>
      __$$SearchStateImplCopyWithImpl<_$SearchStateImpl>(this, _$identity);
}

abstract class _SearchState implements SearchState {
  const factory _SearchState(
      {final List<ProductData> products,
      final List<CategoryData> categories,
      final List<BrandData> brands,
      final bool isShopLoading,
      final bool isProductLoading,
      final bool isCategoryLoading,
      final bool isBrandLoading,
      final String query}) = _$SearchStateImpl;

  @override
  List<ProductData> get products;
  @override
  List<CategoryData> get categories;
  @override
  List<BrandData> get brands;
  @override
  bool get isShopLoading;
  @override
  bool get isProductLoading;
  @override
  bool get isCategoryLoading;
  @override
  bool get isBrandLoading;
  @override
  String get query;

  /// Create a copy of SearchState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SearchStateImplCopyWith<_$SearchStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
