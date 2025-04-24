// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'review_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ReviewEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(double review) setReview,
    required TResult Function(
            BuildContext context,
            String comment,
            int? userId,
            String? productSlug,
            int? blogId,
            int? orderId,
            VoidCallback onSuccess)
        sendReview,
    required TResult Function(BuildContext context, int? userId, int? blogId,
            int? driverId, int? productId)
        fetchReview,
    required TResult Function(String imagePath) setImage,
    required TResult Function(
            BuildContext context,
            int? userId,
            int? blogId,
            int? driverId,
            String? productSlug,
            bool? isRefresh,
            RefreshController? controller)
        fetchReviewList,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(double review)? setReview,
    TResult? Function(
            BuildContext context,
            String comment,
            int? userId,
            String? productSlug,
            int? blogId,
            int? orderId,
            VoidCallback onSuccess)?
        sendReview,
    TResult? Function(BuildContext context, int? userId, int? blogId,
            int? driverId, int? productId)?
        fetchReview,
    TResult? Function(String imagePath)? setImage,
    TResult? Function(
            BuildContext context,
            int? userId,
            int? blogId,
            int? driverId,
            String? productSlug,
            bool? isRefresh,
            RefreshController? controller)?
        fetchReviewList,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(double review)? setReview,
    TResult Function(
            BuildContext context,
            String comment,
            int? userId,
            String? productSlug,
            int? blogId,
            int? orderId,
            VoidCallback onSuccess)?
        sendReview,
    TResult Function(BuildContext context, int? userId, int? blogId,
            int? driverId, int? productId)?
        fetchReview,
    TResult Function(String imagePath)? setImage,
    TResult Function(
            BuildContext context,
            int? userId,
            int? blogId,
            int? driverId,
            String? productSlug,
            bool? isRefresh,
            RefreshController? controller)?
        fetchReviewList,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SetReview value) setReview,
    required TResult Function(SendReview value) sendReview,
    required TResult Function(FetchReview value) fetchReview,
    required TResult Function(SetImage value) setImage,
    required TResult Function(FetchReviewList value) fetchReviewList,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SetReview value)? setReview,
    TResult? Function(SendReview value)? sendReview,
    TResult? Function(FetchReview value)? fetchReview,
    TResult? Function(SetImage value)? setImage,
    TResult? Function(FetchReviewList value)? fetchReviewList,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SetReview value)? setReview,
    TResult Function(SendReview value)? sendReview,
    TResult Function(FetchReview value)? fetchReview,
    TResult Function(SetImage value)? setImage,
    TResult Function(FetchReviewList value)? fetchReviewList,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReviewEventCopyWith<$Res> {
  factory $ReviewEventCopyWith(
          ReviewEvent value, $Res Function(ReviewEvent) then) =
      _$ReviewEventCopyWithImpl<$Res, ReviewEvent>;
}

/// @nodoc
class _$ReviewEventCopyWithImpl<$Res, $Val extends ReviewEvent>
    implements $ReviewEventCopyWith<$Res> {
  _$ReviewEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ReviewEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$SetReviewImplCopyWith<$Res> {
  factory _$$SetReviewImplCopyWith(
          _$SetReviewImpl value, $Res Function(_$SetReviewImpl) then) =
      __$$SetReviewImplCopyWithImpl<$Res>;
  @useResult
  $Res call({double review});
}

/// @nodoc
class __$$SetReviewImplCopyWithImpl<$Res>
    extends _$ReviewEventCopyWithImpl<$Res, _$SetReviewImpl>
    implements _$$SetReviewImplCopyWith<$Res> {
  __$$SetReviewImplCopyWithImpl(
      _$SetReviewImpl _value, $Res Function(_$SetReviewImpl) _then)
      : super(_value, _then);

  /// Create a copy of ReviewEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? review = null,
  }) {
    return _then(_$SetReviewImpl(
      review: null == review
          ? _value.review
          : review // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc

class _$SetReviewImpl implements SetReview {
  const _$SetReviewImpl({required this.review});

  @override
  final double review;

  @override
  String toString() {
    return 'ReviewEvent.setReview(review: $review)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SetReviewImpl &&
            (identical(other.review, review) || other.review == review));
  }

  @override
  int get hashCode => Object.hash(runtimeType, review);

  /// Create a copy of ReviewEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SetReviewImplCopyWith<_$SetReviewImpl> get copyWith =>
      __$$SetReviewImplCopyWithImpl<_$SetReviewImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(double review) setReview,
    required TResult Function(
            BuildContext context,
            String comment,
            int? userId,
            String? productSlug,
            int? blogId,
            int? orderId,
            VoidCallback onSuccess)
        sendReview,
    required TResult Function(BuildContext context, int? userId, int? blogId,
            int? driverId, int? productId)
        fetchReview,
    required TResult Function(String imagePath) setImage,
    required TResult Function(
            BuildContext context,
            int? userId,
            int? blogId,
            int? driverId,
            String? productSlug,
            bool? isRefresh,
            RefreshController? controller)
        fetchReviewList,
  }) {
    return setReview(review);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(double review)? setReview,
    TResult? Function(
            BuildContext context,
            String comment,
            int? userId,
            String? productSlug,
            int? blogId,
            int? orderId,
            VoidCallback onSuccess)?
        sendReview,
    TResult? Function(BuildContext context, int? userId, int? blogId,
            int? driverId, int? productId)?
        fetchReview,
    TResult? Function(String imagePath)? setImage,
    TResult? Function(
            BuildContext context,
            int? userId,
            int? blogId,
            int? driverId,
            String? productSlug,
            bool? isRefresh,
            RefreshController? controller)?
        fetchReviewList,
  }) {
    return setReview?.call(review);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(double review)? setReview,
    TResult Function(
            BuildContext context,
            String comment,
            int? userId,
            String? productSlug,
            int? blogId,
            int? orderId,
            VoidCallback onSuccess)?
        sendReview,
    TResult Function(BuildContext context, int? userId, int? blogId,
            int? driverId, int? productId)?
        fetchReview,
    TResult Function(String imagePath)? setImage,
    TResult Function(
            BuildContext context,
            int? userId,
            int? blogId,
            int? driverId,
            String? productSlug,
            bool? isRefresh,
            RefreshController? controller)?
        fetchReviewList,
    required TResult orElse(),
  }) {
    if (setReview != null) {
      return setReview(review);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SetReview value) setReview,
    required TResult Function(SendReview value) sendReview,
    required TResult Function(FetchReview value) fetchReview,
    required TResult Function(SetImage value) setImage,
    required TResult Function(FetchReviewList value) fetchReviewList,
  }) {
    return setReview(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SetReview value)? setReview,
    TResult? Function(SendReview value)? sendReview,
    TResult? Function(FetchReview value)? fetchReview,
    TResult? Function(SetImage value)? setImage,
    TResult? Function(FetchReviewList value)? fetchReviewList,
  }) {
    return setReview?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SetReview value)? setReview,
    TResult Function(SendReview value)? sendReview,
    TResult Function(FetchReview value)? fetchReview,
    TResult Function(SetImage value)? setImage,
    TResult Function(FetchReviewList value)? fetchReviewList,
    required TResult orElse(),
  }) {
    if (setReview != null) {
      return setReview(this);
    }
    return orElse();
  }
}

abstract class SetReview implements ReviewEvent {
  const factory SetReview({required final double review}) = _$SetReviewImpl;

  double get review;

  /// Create a copy of ReviewEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SetReviewImplCopyWith<_$SetReviewImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SendReviewImplCopyWith<$Res> {
  factory _$$SendReviewImplCopyWith(
          _$SendReviewImpl value, $Res Function(_$SendReviewImpl) then) =
      __$$SendReviewImplCopyWithImpl<$Res>;
  @useResult
  $Res call(
      {BuildContext context,
      String comment,
      int? userId,
      String? productSlug,
      int? blogId,
      int? orderId,
      VoidCallback onSuccess});
}

/// @nodoc
class __$$SendReviewImplCopyWithImpl<$Res>
    extends _$ReviewEventCopyWithImpl<$Res, _$SendReviewImpl>
    implements _$$SendReviewImplCopyWith<$Res> {
  __$$SendReviewImplCopyWithImpl(
      _$SendReviewImpl _value, $Res Function(_$SendReviewImpl) _then)
      : super(_value, _then);

  /// Create a copy of ReviewEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? context = null,
    Object? comment = null,
    Object? userId = freezed,
    Object? productSlug = freezed,
    Object? blogId = freezed,
    Object? orderId = freezed,
    Object? onSuccess = null,
  }) {
    return _then(_$SendReviewImpl(
      context: null == context
          ? _value.context
          : context // ignore: cast_nullable_to_non_nullable
              as BuildContext,
      comment: null == comment
          ? _value.comment
          : comment // ignore: cast_nullable_to_non_nullable
              as String,
      userId: freezed == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as int?,
      productSlug: freezed == productSlug
          ? _value.productSlug
          : productSlug // ignore: cast_nullable_to_non_nullable
              as String?,
      blogId: freezed == blogId
          ? _value.blogId
          : blogId // ignore: cast_nullable_to_non_nullable
              as int?,
      orderId: freezed == orderId
          ? _value.orderId
          : orderId // ignore: cast_nullable_to_non_nullable
              as int?,
      onSuccess: null == onSuccess
          ? _value.onSuccess
          : onSuccess // ignore: cast_nullable_to_non_nullable
              as VoidCallback,
    ));
  }
}

/// @nodoc

class _$SendReviewImpl implements SendReview {
  const _$SendReviewImpl(
      {required this.context,
      required this.comment,
      this.userId,
      this.productSlug,
      this.blogId,
      this.orderId,
      required this.onSuccess});

  @override
  final BuildContext context;
  @override
  final String comment;
  @override
  final int? userId;
  @override
  final String? productSlug;
  @override
  final int? blogId;
  @override
  final int? orderId;
  @override
  final VoidCallback onSuccess;

  @override
  String toString() {
    return 'ReviewEvent.sendReview(context: $context, comment: $comment, userId: $userId, productSlug: $productSlug, blogId: $blogId, orderId: $orderId, onSuccess: $onSuccess)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SendReviewImpl &&
            (identical(other.context, context) || other.context == context) &&
            (identical(other.comment, comment) || other.comment == comment) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.productSlug, productSlug) ||
                other.productSlug == productSlug) &&
            (identical(other.blogId, blogId) || other.blogId == blogId) &&
            (identical(other.orderId, orderId) || other.orderId == orderId) &&
            (identical(other.onSuccess, onSuccess) ||
                other.onSuccess == onSuccess));
  }

  @override
  int get hashCode => Object.hash(runtimeType, context, comment, userId,
      productSlug, blogId, orderId, onSuccess);

  /// Create a copy of ReviewEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SendReviewImplCopyWith<_$SendReviewImpl> get copyWith =>
      __$$SendReviewImplCopyWithImpl<_$SendReviewImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(double review) setReview,
    required TResult Function(
            BuildContext context,
            String comment,
            int? userId,
            String? productSlug,
            int? blogId,
            int? orderId,
            VoidCallback onSuccess)
        sendReview,
    required TResult Function(BuildContext context, int? userId, int? blogId,
            int? driverId, int? productId)
        fetchReview,
    required TResult Function(String imagePath) setImage,
    required TResult Function(
            BuildContext context,
            int? userId,
            int? blogId,
            int? driverId,
            String? productSlug,
            bool? isRefresh,
            RefreshController? controller)
        fetchReviewList,
  }) {
    return sendReview(
        context, comment, userId, productSlug, blogId, orderId, onSuccess);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(double review)? setReview,
    TResult? Function(
            BuildContext context,
            String comment,
            int? userId,
            String? productSlug,
            int? blogId,
            int? orderId,
            VoidCallback onSuccess)?
        sendReview,
    TResult? Function(BuildContext context, int? userId, int? blogId,
            int? driverId, int? productId)?
        fetchReview,
    TResult? Function(String imagePath)? setImage,
    TResult? Function(
            BuildContext context,
            int? userId,
            int? blogId,
            int? driverId,
            String? productSlug,
            bool? isRefresh,
            RefreshController? controller)?
        fetchReviewList,
  }) {
    return sendReview?.call(
        context, comment, userId, productSlug, blogId, orderId, onSuccess);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(double review)? setReview,
    TResult Function(
            BuildContext context,
            String comment,
            int? userId,
            String? productSlug,
            int? blogId,
            int? orderId,
            VoidCallback onSuccess)?
        sendReview,
    TResult Function(BuildContext context, int? userId, int? blogId,
            int? driverId, int? productId)?
        fetchReview,
    TResult Function(String imagePath)? setImage,
    TResult Function(
            BuildContext context,
            int? userId,
            int? blogId,
            int? driverId,
            String? productSlug,
            bool? isRefresh,
            RefreshController? controller)?
        fetchReviewList,
    required TResult orElse(),
  }) {
    if (sendReview != null) {
      return sendReview(
          context, comment, userId, productSlug, blogId, orderId, onSuccess);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SetReview value) setReview,
    required TResult Function(SendReview value) sendReview,
    required TResult Function(FetchReview value) fetchReview,
    required TResult Function(SetImage value) setImage,
    required TResult Function(FetchReviewList value) fetchReviewList,
  }) {
    return sendReview(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SetReview value)? setReview,
    TResult? Function(SendReview value)? sendReview,
    TResult? Function(FetchReview value)? fetchReview,
    TResult? Function(SetImage value)? setImage,
    TResult? Function(FetchReviewList value)? fetchReviewList,
  }) {
    return sendReview?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SetReview value)? setReview,
    TResult Function(SendReview value)? sendReview,
    TResult Function(FetchReview value)? fetchReview,
    TResult Function(SetImage value)? setImage,
    TResult Function(FetchReviewList value)? fetchReviewList,
    required TResult orElse(),
  }) {
    if (sendReview != null) {
      return sendReview(this);
    }
    return orElse();
  }
}

abstract class SendReview implements ReviewEvent {
  const factory SendReview(
      {required final BuildContext context,
      required final String comment,
      final int? userId,
      final String? productSlug,
      final int? blogId,
      final int? orderId,
      required final VoidCallback onSuccess}) = _$SendReviewImpl;

  BuildContext get context;
  String get comment;
  int? get userId;
  String? get productSlug;
  int? get blogId;
  int? get orderId;
  VoidCallback get onSuccess;

  /// Create a copy of ReviewEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SendReviewImplCopyWith<_$SendReviewImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$FetchReviewImplCopyWith<$Res> {
  factory _$$FetchReviewImplCopyWith(
          _$FetchReviewImpl value, $Res Function(_$FetchReviewImpl) then) =
      __$$FetchReviewImplCopyWithImpl<$Res>;
  @useResult
  $Res call(
      {BuildContext context,
      int? userId,
      int? blogId,
      int? driverId,
      int? productId});
}

/// @nodoc
class __$$FetchReviewImplCopyWithImpl<$Res>
    extends _$ReviewEventCopyWithImpl<$Res, _$FetchReviewImpl>
    implements _$$FetchReviewImplCopyWith<$Res> {
  __$$FetchReviewImplCopyWithImpl(
      _$FetchReviewImpl _value, $Res Function(_$FetchReviewImpl) _then)
      : super(_value, _then);

  /// Create a copy of ReviewEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? context = null,
    Object? userId = freezed,
    Object? blogId = freezed,
    Object? driverId = freezed,
    Object? productId = freezed,
  }) {
    return _then(_$FetchReviewImpl(
      context: null == context
          ? _value.context
          : context // ignore: cast_nullable_to_non_nullable
              as BuildContext,
      userId: freezed == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as int?,
      blogId: freezed == blogId
          ? _value.blogId
          : blogId // ignore: cast_nullable_to_non_nullable
              as int?,
      driverId: freezed == driverId
          ? _value.driverId
          : driverId // ignore: cast_nullable_to_non_nullable
              as int?,
      productId: freezed == productId
          ? _value.productId
          : productId // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc

class _$FetchReviewImpl implements FetchReview {
  const _$FetchReviewImpl(
      {required this.context,
      this.userId,
      this.blogId,
      this.driverId,
      this.productId});

  @override
  final BuildContext context;
  @override
  final int? userId;
  @override
  final int? blogId;
  @override
  final int? driverId;
  @override
  final int? productId;

  @override
  String toString() {
    return 'ReviewEvent.fetchReview(context: $context, userId: $userId, blogId: $blogId, driverId: $driverId, productId: $productId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FetchReviewImpl &&
            (identical(other.context, context) || other.context == context) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.blogId, blogId) || other.blogId == blogId) &&
            (identical(other.driverId, driverId) ||
                other.driverId == driverId) &&
            (identical(other.productId, productId) ||
                other.productId == productId));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, context, userId, blogId, driverId, productId);

  /// Create a copy of ReviewEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FetchReviewImplCopyWith<_$FetchReviewImpl> get copyWith =>
      __$$FetchReviewImplCopyWithImpl<_$FetchReviewImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(double review) setReview,
    required TResult Function(
            BuildContext context,
            String comment,
            int? userId,
            String? productSlug,
            int? blogId,
            int? orderId,
            VoidCallback onSuccess)
        sendReview,
    required TResult Function(BuildContext context, int? userId, int? blogId,
            int? driverId, int? productId)
        fetchReview,
    required TResult Function(String imagePath) setImage,
    required TResult Function(
            BuildContext context,
            int? userId,
            int? blogId,
            int? driverId,
            String? productSlug,
            bool? isRefresh,
            RefreshController? controller)
        fetchReviewList,
  }) {
    return fetchReview(context, userId, blogId, driverId, productId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(double review)? setReview,
    TResult? Function(
            BuildContext context,
            String comment,
            int? userId,
            String? productSlug,
            int? blogId,
            int? orderId,
            VoidCallback onSuccess)?
        sendReview,
    TResult? Function(BuildContext context, int? userId, int? blogId,
            int? driverId, int? productId)?
        fetchReview,
    TResult? Function(String imagePath)? setImage,
    TResult? Function(
            BuildContext context,
            int? userId,
            int? blogId,
            int? driverId,
            String? productSlug,
            bool? isRefresh,
            RefreshController? controller)?
        fetchReviewList,
  }) {
    return fetchReview?.call(context, userId, blogId, driverId, productId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(double review)? setReview,
    TResult Function(
            BuildContext context,
            String comment,
            int? userId,
            String? productSlug,
            int? blogId,
            int? orderId,
            VoidCallback onSuccess)?
        sendReview,
    TResult Function(BuildContext context, int? userId, int? blogId,
            int? driverId, int? productId)?
        fetchReview,
    TResult Function(String imagePath)? setImage,
    TResult Function(
            BuildContext context,
            int? userId,
            int? blogId,
            int? driverId,
            String? productSlug,
            bool? isRefresh,
            RefreshController? controller)?
        fetchReviewList,
    required TResult orElse(),
  }) {
    if (fetchReview != null) {
      return fetchReview(context, userId, blogId, driverId, productId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SetReview value) setReview,
    required TResult Function(SendReview value) sendReview,
    required TResult Function(FetchReview value) fetchReview,
    required TResult Function(SetImage value) setImage,
    required TResult Function(FetchReviewList value) fetchReviewList,
  }) {
    return fetchReview(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SetReview value)? setReview,
    TResult? Function(SendReview value)? sendReview,
    TResult? Function(FetchReview value)? fetchReview,
    TResult? Function(SetImage value)? setImage,
    TResult? Function(FetchReviewList value)? fetchReviewList,
  }) {
    return fetchReview?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SetReview value)? setReview,
    TResult Function(SendReview value)? sendReview,
    TResult Function(FetchReview value)? fetchReview,
    TResult Function(SetImage value)? setImage,
    TResult Function(FetchReviewList value)? fetchReviewList,
    required TResult orElse(),
  }) {
    if (fetchReview != null) {
      return fetchReview(this);
    }
    return orElse();
  }
}

abstract class FetchReview implements ReviewEvent {
  const factory FetchReview(
      {required final BuildContext context,
      final int? userId,
      final int? blogId,
      final int? driverId,
      final int? productId}) = _$FetchReviewImpl;

  BuildContext get context;
  int? get userId;
  int? get blogId;
  int? get driverId;
  int? get productId;

  /// Create a copy of ReviewEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FetchReviewImplCopyWith<_$FetchReviewImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SetImageImplCopyWith<$Res> {
  factory _$$SetImageImplCopyWith(
          _$SetImageImpl value, $Res Function(_$SetImageImpl) then) =
      __$$SetImageImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String imagePath});
}

/// @nodoc
class __$$SetImageImplCopyWithImpl<$Res>
    extends _$ReviewEventCopyWithImpl<$Res, _$SetImageImpl>
    implements _$$SetImageImplCopyWith<$Res> {
  __$$SetImageImplCopyWithImpl(
      _$SetImageImpl _value, $Res Function(_$SetImageImpl) _then)
      : super(_value, _then);

  /// Create a copy of ReviewEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? imagePath = null,
  }) {
    return _then(_$SetImageImpl(
      imagePath: null == imagePath
          ? _value.imagePath
          : imagePath // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$SetImageImpl implements SetImage {
  const _$SetImageImpl({required this.imagePath});

  @override
  final String imagePath;

  @override
  String toString() {
    return 'ReviewEvent.setImage(imagePath: $imagePath)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SetImageImpl &&
            (identical(other.imagePath, imagePath) ||
                other.imagePath == imagePath));
  }

  @override
  int get hashCode => Object.hash(runtimeType, imagePath);

  /// Create a copy of ReviewEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SetImageImplCopyWith<_$SetImageImpl> get copyWith =>
      __$$SetImageImplCopyWithImpl<_$SetImageImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(double review) setReview,
    required TResult Function(
            BuildContext context,
            String comment,
            int? userId,
            String? productSlug,
            int? blogId,
            int? orderId,
            VoidCallback onSuccess)
        sendReview,
    required TResult Function(BuildContext context, int? userId, int? blogId,
            int? driverId, int? productId)
        fetchReview,
    required TResult Function(String imagePath) setImage,
    required TResult Function(
            BuildContext context,
            int? userId,
            int? blogId,
            int? driverId,
            String? productSlug,
            bool? isRefresh,
            RefreshController? controller)
        fetchReviewList,
  }) {
    return setImage(imagePath);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(double review)? setReview,
    TResult? Function(
            BuildContext context,
            String comment,
            int? userId,
            String? productSlug,
            int? blogId,
            int? orderId,
            VoidCallback onSuccess)?
        sendReview,
    TResult? Function(BuildContext context, int? userId, int? blogId,
            int? driverId, int? productId)?
        fetchReview,
    TResult? Function(String imagePath)? setImage,
    TResult? Function(
            BuildContext context,
            int? userId,
            int? blogId,
            int? driverId,
            String? productSlug,
            bool? isRefresh,
            RefreshController? controller)?
        fetchReviewList,
  }) {
    return setImage?.call(imagePath);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(double review)? setReview,
    TResult Function(
            BuildContext context,
            String comment,
            int? userId,
            String? productSlug,
            int? blogId,
            int? orderId,
            VoidCallback onSuccess)?
        sendReview,
    TResult Function(BuildContext context, int? userId, int? blogId,
            int? driverId, int? productId)?
        fetchReview,
    TResult Function(String imagePath)? setImage,
    TResult Function(
            BuildContext context,
            int? userId,
            int? blogId,
            int? driverId,
            String? productSlug,
            bool? isRefresh,
            RefreshController? controller)?
        fetchReviewList,
    required TResult orElse(),
  }) {
    if (setImage != null) {
      return setImage(imagePath);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SetReview value) setReview,
    required TResult Function(SendReview value) sendReview,
    required TResult Function(FetchReview value) fetchReview,
    required TResult Function(SetImage value) setImage,
    required TResult Function(FetchReviewList value) fetchReviewList,
  }) {
    return setImage(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SetReview value)? setReview,
    TResult? Function(SendReview value)? sendReview,
    TResult? Function(FetchReview value)? fetchReview,
    TResult? Function(SetImage value)? setImage,
    TResult? Function(FetchReviewList value)? fetchReviewList,
  }) {
    return setImage?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SetReview value)? setReview,
    TResult Function(SendReview value)? sendReview,
    TResult Function(FetchReview value)? fetchReview,
    TResult Function(SetImage value)? setImage,
    TResult Function(FetchReviewList value)? fetchReviewList,
    required TResult orElse(),
  }) {
    if (setImage != null) {
      return setImage(this);
    }
    return orElse();
  }
}

abstract class SetImage implements ReviewEvent {
  const factory SetImage({required final String imagePath}) = _$SetImageImpl;

  String get imagePath;

  /// Create a copy of ReviewEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SetImageImplCopyWith<_$SetImageImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$FetchReviewListImplCopyWith<$Res> {
  factory _$$FetchReviewListImplCopyWith(_$FetchReviewListImpl value,
          $Res Function(_$FetchReviewListImpl) then) =
      __$$FetchReviewListImplCopyWithImpl<$Res>;
  @useResult
  $Res call(
      {BuildContext context,
      int? userId,
      int? blogId,
      int? driverId,
      String? productSlug,
      bool? isRefresh,
      RefreshController? controller});
}

/// @nodoc
class __$$FetchReviewListImplCopyWithImpl<$Res>
    extends _$ReviewEventCopyWithImpl<$Res, _$FetchReviewListImpl>
    implements _$$FetchReviewListImplCopyWith<$Res> {
  __$$FetchReviewListImplCopyWithImpl(
      _$FetchReviewListImpl _value, $Res Function(_$FetchReviewListImpl) _then)
      : super(_value, _then);

  /// Create a copy of ReviewEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? context = null,
    Object? userId = freezed,
    Object? blogId = freezed,
    Object? driverId = freezed,
    Object? productSlug = freezed,
    Object? isRefresh = freezed,
    Object? controller = freezed,
  }) {
    return _then(_$FetchReviewListImpl(
      context: null == context
          ? _value.context
          : context // ignore: cast_nullable_to_non_nullable
              as BuildContext,
      userId: freezed == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as int?,
      blogId: freezed == blogId
          ? _value.blogId
          : blogId // ignore: cast_nullable_to_non_nullable
              as int?,
      driverId: freezed == driverId
          ? _value.driverId
          : driverId // ignore: cast_nullable_to_non_nullable
              as int?,
      productSlug: freezed == productSlug
          ? _value.productSlug
          : productSlug // ignore: cast_nullable_to_non_nullable
              as String?,
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

class _$FetchReviewListImpl implements FetchReviewList {
  const _$FetchReviewListImpl(
      {required this.context,
      this.userId,
      this.blogId,
      this.driverId,
      this.productSlug,
      this.isRefresh,
      this.controller});

  @override
  final BuildContext context;
  @override
  final int? userId;
  @override
  final int? blogId;
  @override
  final int? driverId;
  @override
  final String? productSlug;
  @override
  final bool? isRefresh;
  @override
  final RefreshController? controller;

  @override
  String toString() {
    return 'ReviewEvent.fetchReviewList(context: $context, userId: $userId, blogId: $blogId, driverId: $driverId, productSlug: $productSlug, isRefresh: $isRefresh, controller: $controller)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FetchReviewListImpl &&
            (identical(other.context, context) || other.context == context) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.blogId, blogId) || other.blogId == blogId) &&
            (identical(other.driverId, driverId) ||
                other.driverId == driverId) &&
            (identical(other.productSlug, productSlug) ||
                other.productSlug == productSlug) &&
            (identical(other.isRefresh, isRefresh) ||
                other.isRefresh == isRefresh) &&
            (identical(other.controller, controller) ||
                other.controller == controller));
  }

  @override
  int get hashCode => Object.hash(runtimeType, context, userId, blogId,
      driverId, productSlug, isRefresh, controller);

  /// Create a copy of ReviewEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FetchReviewListImplCopyWith<_$FetchReviewListImpl> get copyWith =>
      __$$FetchReviewListImplCopyWithImpl<_$FetchReviewListImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(double review) setReview,
    required TResult Function(
            BuildContext context,
            String comment,
            int? userId,
            String? productSlug,
            int? blogId,
            int? orderId,
            VoidCallback onSuccess)
        sendReview,
    required TResult Function(BuildContext context, int? userId, int? blogId,
            int? driverId, int? productId)
        fetchReview,
    required TResult Function(String imagePath) setImage,
    required TResult Function(
            BuildContext context,
            int? userId,
            int? blogId,
            int? driverId,
            String? productSlug,
            bool? isRefresh,
            RefreshController? controller)
        fetchReviewList,
  }) {
    return fetchReviewList(
        context, userId, blogId, driverId, productSlug, isRefresh, controller);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(double review)? setReview,
    TResult? Function(
            BuildContext context,
            String comment,
            int? userId,
            String? productSlug,
            int? blogId,
            int? orderId,
            VoidCallback onSuccess)?
        sendReview,
    TResult? Function(BuildContext context, int? userId, int? blogId,
            int? driverId, int? productId)?
        fetchReview,
    TResult? Function(String imagePath)? setImage,
    TResult? Function(
            BuildContext context,
            int? userId,
            int? blogId,
            int? driverId,
            String? productSlug,
            bool? isRefresh,
            RefreshController? controller)?
        fetchReviewList,
  }) {
    return fetchReviewList?.call(
        context, userId, blogId, driverId, productSlug, isRefresh, controller);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(double review)? setReview,
    TResult Function(
            BuildContext context,
            String comment,
            int? userId,
            String? productSlug,
            int? blogId,
            int? orderId,
            VoidCallback onSuccess)?
        sendReview,
    TResult Function(BuildContext context, int? userId, int? blogId,
            int? driverId, int? productId)?
        fetchReview,
    TResult Function(String imagePath)? setImage,
    TResult Function(
            BuildContext context,
            int? userId,
            int? blogId,
            int? driverId,
            String? productSlug,
            bool? isRefresh,
            RefreshController? controller)?
        fetchReviewList,
    required TResult orElse(),
  }) {
    if (fetchReviewList != null) {
      return fetchReviewList(context, userId, blogId, driverId, productSlug,
          isRefresh, controller);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SetReview value) setReview,
    required TResult Function(SendReview value) sendReview,
    required TResult Function(FetchReview value) fetchReview,
    required TResult Function(SetImage value) setImage,
    required TResult Function(FetchReviewList value) fetchReviewList,
  }) {
    return fetchReviewList(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SetReview value)? setReview,
    TResult? Function(SendReview value)? sendReview,
    TResult? Function(FetchReview value)? fetchReview,
    TResult? Function(SetImage value)? setImage,
    TResult? Function(FetchReviewList value)? fetchReviewList,
  }) {
    return fetchReviewList?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SetReview value)? setReview,
    TResult Function(SendReview value)? sendReview,
    TResult Function(FetchReview value)? fetchReview,
    TResult Function(SetImage value)? setImage,
    TResult Function(FetchReviewList value)? fetchReviewList,
    required TResult orElse(),
  }) {
    if (fetchReviewList != null) {
      return fetchReviewList(this);
    }
    return orElse();
  }
}

abstract class FetchReviewList implements ReviewEvent {
  const factory FetchReviewList(
      {required final BuildContext context,
      final int? userId,
      final int? blogId,
      final int? driverId,
      final String? productSlug,
      final bool? isRefresh,
      final RefreshController? controller}) = _$FetchReviewListImpl;

  BuildContext get context;
  int? get userId;
  int? get blogId;
  int? get driverId;
  String? get productSlug;
  bool? get isRefresh;
  RefreshController? get controller;

  /// Create a copy of ReviewEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FetchReviewListImplCopyWith<_$FetchReviewListImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$ReviewState {
  double get review => throw _privateConstructorUsedError;
  bool get isAddButton => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;
  bool get isButtonLoading => throw _privateConstructorUsedError;
  List<ReviewModel> get list => throw _privateConstructorUsedError;
  List<String> get listOfImage => throw _privateConstructorUsedError;
  ReviewCountModel? get reviewCount => throw _privateConstructorUsedError;

  /// Create a copy of ReviewState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ReviewStateCopyWith<ReviewState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReviewStateCopyWith<$Res> {
  factory $ReviewStateCopyWith(
          ReviewState value, $Res Function(ReviewState) then) =
      _$ReviewStateCopyWithImpl<$Res, ReviewState>;
  @useResult
  $Res call(
      {double review,
      bool isAddButton,
      bool isLoading,
      bool isButtonLoading,
      List<ReviewModel> list,
      List<String> listOfImage,
      ReviewCountModel? reviewCount});
}

/// @nodoc
class _$ReviewStateCopyWithImpl<$Res, $Val extends ReviewState>
    implements $ReviewStateCopyWith<$Res> {
  _$ReviewStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ReviewState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? review = null,
    Object? isAddButton = null,
    Object? isLoading = null,
    Object? isButtonLoading = null,
    Object? list = null,
    Object? listOfImage = null,
    Object? reviewCount = freezed,
  }) {
    return _then(_value.copyWith(
      review: null == review
          ? _value.review
          : review // ignore: cast_nullable_to_non_nullable
              as double,
      isAddButton: null == isAddButton
          ? _value.isAddButton
          : isAddButton // ignore: cast_nullable_to_non_nullable
              as bool,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isButtonLoading: null == isButtonLoading
          ? _value.isButtonLoading
          : isButtonLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      list: null == list
          ? _value.list
          : list // ignore: cast_nullable_to_non_nullable
              as List<ReviewModel>,
      listOfImage: null == listOfImage
          ? _value.listOfImage
          : listOfImage // ignore: cast_nullable_to_non_nullable
              as List<String>,
      reviewCount: freezed == reviewCount
          ? _value.reviewCount
          : reviewCount // ignore: cast_nullable_to_non_nullable
              as ReviewCountModel?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ReviewStateImplCopyWith<$Res>
    implements $ReviewStateCopyWith<$Res> {
  factory _$$ReviewStateImplCopyWith(
          _$ReviewStateImpl value, $Res Function(_$ReviewStateImpl) then) =
      __$$ReviewStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {double review,
      bool isAddButton,
      bool isLoading,
      bool isButtonLoading,
      List<ReviewModel> list,
      List<String> listOfImage,
      ReviewCountModel? reviewCount});
}

/// @nodoc
class __$$ReviewStateImplCopyWithImpl<$Res>
    extends _$ReviewStateCopyWithImpl<$Res, _$ReviewStateImpl>
    implements _$$ReviewStateImplCopyWith<$Res> {
  __$$ReviewStateImplCopyWithImpl(
      _$ReviewStateImpl _value, $Res Function(_$ReviewStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of ReviewState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? review = null,
    Object? isAddButton = null,
    Object? isLoading = null,
    Object? isButtonLoading = null,
    Object? list = null,
    Object? listOfImage = null,
    Object? reviewCount = freezed,
  }) {
    return _then(_$ReviewStateImpl(
      review: null == review
          ? _value.review
          : review // ignore: cast_nullable_to_non_nullable
              as double,
      isAddButton: null == isAddButton
          ? _value.isAddButton
          : isAddButton // ignore: cast_nullable_to_non_nullable
              as bool,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isButtonLoading: null == isButtonLoading
          ? _value.isButtonLoading
          : isButtonLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      list: null == list
          ? _value._list
          : list // ignore: cast_nullable_to_non_nullable
              as List<ReviewModel>,
      listOfImage: null == listOfImage
          ? _value._listOfImage
          : listOfImage // ignore: cast_nullable_to_non_nullable
              as List<String>,
      reviewCount: freezed == reviewCount
          ? _value.reviewCount
          : reviewCount // ignore: cast_nullable_to_non_nullable
              as ReviewCountModel?,
    ));
  }
}

/// @nodoc

class _$ReviewStateImpl implements _ReviewState {
  const _$ReviewStateImpl(
      {this.review = 3,
      this.isAddButton = false,
      this.isLoading = false,
      this.isButtonLoading = false,
      final List<ReviewModel> list = const [],
      final List<String> listOfImage = const [],
      this.reviewCount = null})
      : _list = list,
        _listOfImage = listOfImage;

  @override
  @JsonKey()
  final double review;
  @override
  @JsonKey()
  final bool isAddButton;
  @override
  @JsonKey()
  final bool isLoading;
  @override
  @JsonKey()
  final bool isButtonLoading;
  final List<ReviewModel> _list;
  @override
  @JsonKey()
  List<ReviewModel> get list {
    if (_list is EqualUnmodifiableListView) return _list;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_list);
  }

  final List<String> _listOfImage;
  @override
  @JsonKey()
  List<String> get listOfImage {
    if (_listOfImage is EqualUnmodifiableListView) return _listOfImage;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_listOfImage);
  }

  @override
  @JsonKey()
  final ReviewCountModel? reviewCount;

  @override
  String toString() {
    return 'ReviewState(review: $review, isAddButton: $isAddButton, isLoading: $isLoading, isButtonLoading: $isButtonLoading, list: $list, listOfImage: $listOfImage, reviewCount: $reviewCount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ReviewStateImpl &&
            (identical(other.review, review) || other.review == review) &&
            (identical(other.isAddButton, isAddButton) ||
                other.isAddButton == isAddButton) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.isButtonLoading, isButtonLoading) ||
                other.isButtonLoading == isButtonLoading) &&
            const DeepCollectionEquality().equals(other._list, _list) &&
            const DeepCollectionEquality()
                .equals(other._listOfImage, _listOfImage) &&
            (identical(other.reviewCount, reviewCount) ||
                other.reviewCount == reviewCount));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      review,
      isAddButton,
      isLoading,
      isButtonLoading,
      const DeepCollectionEquality().hash(_list),
      const DeepCollectionEquality().hash(_listOfImage),
      reviewCount);

  /// Create a copy of ReviewState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ReviewStateImplCopyWith<_$ReviewStateImpl> get copyWith =>
      __$$ReviewStateImplCopyWithImpl<_$ReviewStateImpl>(this, _$identity);
}

abstract class _ReviewState implements ReviewState {
  const factory _ReviewState(
      {final double review,
      final bool isAddButton,
      final bool isLoading,
      final bool isButtonLoading,
      final List<ReviewModel> list,
      final List<String> listOfImage,
      final ReviewCountModel? reviewCount}) = _$ReviewStateImpl;

  @override
  double get review;
  @override
  bool get isAddButton;
  @override
  bool get isLoading;
  @override
  bool get isButtonLoading;
  @override
  List<ReviewModel> get list;
  @override
  List<String> get listOfImage;
  @override
  ReviewCountModel? get reviewCount;

  /// Create a copy of ReviewState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ReviewStateImplCopyWith<_$ReviewStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
