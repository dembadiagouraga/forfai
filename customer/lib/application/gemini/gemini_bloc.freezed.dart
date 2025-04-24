// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'gemini_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$GeminiEvent {
  BuildContext get context => throw _privateConstructorUsedError;
  List<String> get images => throw _privateConstructorUsedError;
  List<String> get networkImages => throw _privateConstructorUsedError;
  ValueChanged<String> get onSuccess => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(BuildContext context, List<String> images,
            List<String> networkImages, ValueChanged<String> onSuccess)
        imageDescribe,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(BuildContext context, List<String> images,
            List<String> networkImages, ValueChanged<String> onSuccess)?
        imageDescribe,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(BuildContext context, List<String> images,
            List<String> networkImages, ValueChanged<String> onSuccess)?
        imageDescribe,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ImageDescribe value) imageDescribe,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ImageDescribe value)? imageDescribe,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ImageDescribe value)? imageDescribe,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  /// Create a copy of GeminiEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GeminiEventCopyWith<GeminiEvent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GeminiEventCopyWith<$Res> {
  factory $GeminiEventCopyWith(
          GeminiEvent value, $Res Function(GeminiEvent) then) =
      _$GeminiEventCopyWithImpl<$Res, GeminiEvent>;
  @useResult
  $Res call(
      {BuildContext context,
      List<String> images,
      List<String> networkImages,
      ValueChanged<String> onSuccess});
}

/// @nodoc
class _$GeminiEventCopyWithImpl<$Res, $Val extends GeminiEvent>
    implements $GeminiEventCopyWith<$Res> {
  _$GeminiEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GeminiEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? context = null,
    Object? images = null,
    Object? networkImages = null,
    Object? onSuccess = null,
  }) {
    return _then(_value.copyWith(
      context: null == context
          ? _value.context
          : context // ignore: cast_nullable_to_non_nullable
              as BuildContext,
      images: null == images
          ? _value.images
          : images // ignore: cast_nullable_to_non_nullable
              as List<String>,
      networkImages: null == networkImages
          ? _value.networkImages
          : networkImages // ignore: cast_nullable_to_non_nullable
              as List<String>,
      onSuccess: null == onSuccess
          ? _value.onSuccess
          : onSuccess // ignore: cast_nullable_to_non_nullable
              as ValueChanged<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ImageDescribeImplCopyWith<$Res>
    implements $GeminiEventCopyWith<$Res> {
  factory _$$ImageDescribeImplCopyWith(
          _$ImageDescribeImpl value, $Res Function(_$ImageDescribeImpl) then) =
      __$$ImageDescribeImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {BuildContext context,
      List<String> images,
      List<String> networkImages,
      ValueChanged<String> onSuccess});
}

/// @nodoc
class __$$ImageDescribeImplCopyWithImpl<$Res>
    extends _$GeminiEventCopyWithImpl<$Res, _$ImageDescribeImpl>
    implements _$$ImageDescribeImplCopyWith<$Res> {
  __$$ImageDescribeImplCopyWithImpl(
      _$ImageDescribeImpl _value, $Res Function(_$ImageDescribeImpl) _then)
      : super(_value, _then);

  /// Create a copy of GeminiEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? context = null,
    Object? images = null,
    Object? networkImages = null,
    Object? onSuccess = null,
  }) {
    return _then(_$ImageDescribeImpl(
      context: null == context
          ? _value.context
          : context // ignore: cast_nullable_to_non_nullable
              as BuildContext,
      images: null == images
          ? _value._images
          : images // ignore: cast_nullable_to_non_nullable
              as List<String>,
      networkImages: null == networkImages
          ? _value._networkImages
          : networkImages // ignore: cast_nullable_to_non_nullable
              as List<String>,
      onSuccess: null == onSuccess
          ? _value.onSuccess
          : onSuccess // ignore: cast_nullable_to_non_nullable
              as ValueChanged<String>,
    ));
  }
}

/// @nodoc

class _$ImageDescribeImpl implements ImageDescribe {
  const _$ImageDescribeImpl(
      {required this.context,
      required final List<String> images,
      required final List<String> networkImages,
      required this.onSuccess})
      : _images = images,
        _networkImages = networkImages;

  @override
  final BuildContext context;
  final List<String> _images;
  @override
  List<String> get images {
    if (_images is EqualUnmodifiableListView) return _images;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_images);
  }

  final List<String> _networkImages;
  @override
  List<String> get networkImages {
    if (_networkImages is EqualUnmodifiableListView) return _networkImages;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_networkImages);
  }

  @override
  final ValueChanged<String> onSuccess;

  @override
  String toString() {
    return 'GeminiEvent.imageDescribe(context: $context, images: $images, networkImages: $networkImages, onSuccess: $onSuccess)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ImageDescribeImpl &&
            (identical(other.context, context) || other.context == context) &&
            const DeepCollectionEquality().equals(other._images, _images) &&
            const DeepCollectionEquality()
                .equals(other._networkImages, _networkImages) &&
            (identical(other.onSuccess, onSuccess) ||
                other.onSuccess == onSuccess));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      context,
      const DeepCollectionEquality().hash(_images),
      const DeepCollectionEquality().hash(_networkImages),
      onSuccess);

  /// Create a copy of GeminiEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ImageDescribeImplCopyWith<_$ImageDescribeImpl> get copyWith =>
      __$$ImageDescribeImplCopyWithImpl<_$ImageDescribeImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(BuildContext context, List<String> images,
            List<String> networkImages, ValueChanged<String> onSuccess)
        imageDescribe,
  }) {
    return imageDescribe(context, images, networkImages, onSuccess);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(BuildContext context, List<String> images,
            List<String> networkImages, ValueChanged<String> onSuccess)?
        imageDescribe,
  }) {
    return imageDescribe?.call(context, images, networkImages, onSuccess);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(BuildContext context, List<String> images,
            List<String> networkImages, ValueChanged<String> onSuccess)?
        imageDescribe,
    required TResult orElse(),
  }) {
    if (imageDescribe != null) {
      return imageDescribe(context, images, networkImages, onSuccess);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ImageDescribe value) imageDescribe,
  }) {
    return imageDescribe(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ImageDescribe value)? imageDescribe,
  }) {
    return imageDescribe?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ImageDescribe value)? imageDescribe,
    required TResult orElse(),
  }) {
    if (imageDescribe != null) {
      return imageDescribe(this);
    }
    return orElse();
  }
}

abstract class ImageDescribe implements GeminiEvent {
  const factory ImageDescribe(
      {required final BuildContext context,
      required final List<String> images,
      required final List<String> networkImages,
      required final ValueChanged<String> onSuccess}) = _$ImageDescribeImpl;

  @override
  BuildContext get context;
  @override
  List<String> get images;
  @override
  List<String> get networkImages;
  @override
  ValueChanged<String> get onSuccess;

  /// Create a copy of GeminiEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ImageDescribeImplCopyWith<_$ImageDescribeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$GeminiState {
  String? get text => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;

  /// Create a copy of GeminiState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GeminiStateCopyWith<GeminiState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GeminiStateCopyWith<$Res> {
  factory $GeminiStateCopyWith(
          GeminiState value, $Res Function(GeminiState) then) =
      _$GeminiStateCopyWithImpl<$Res, GeminiState>;
  @useResult
  $Res call({String? text, bool isLoading});
}

/// @nodoc
class _$GeminiStateCopyWithImpl<$Res, $Val extends GeminiState>
    implements $GeminiStateCopyWith<$Res> {
  _$GeminiStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GeminiState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? text = freezed,
    Object? isLoading = null,
  }) {
    return _then(_value.copyWith(
      text: freezed == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String?,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$GeminiStateImplCopyWith<$Res>
    implements $GeminiStateCopyWith<$Res> {
  factory _$$GeminiStateImplCopyWith(
          _$GeminiStateImpl value, $Res Function(_$GeminiStateImpl) then) =
      __$$GeminiStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? text, bool isLoading});
}

/// @nodoc
class __$$GeminiStateImplCopyWithImpl<$Res>
    extends _$GeminiStateCopyWithImpl<$Res, _$GeminiStateImpl>
    implements _$$GeminiStateImplCopyWith<$Res> {
  __$$GeminiStateImplCopyWithImpl(
      _$GeminiStateImpl _value, $Res Function(_$GeminiStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of GeminiState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? text = freezed,
    Object? isLoading = null,
  }) {
    return _then(_$GeminiStateImpl(
      text: freezed == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String?,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$GeminiStateImpl implements _GeminiState {
  const _$GeminiStateImpl({this.text = null, this.isLoading = false});

  @override
  @JsonKey()
  final String? text;
  @override
  @JsonKey()
  final bool isLoading;

  @override
  String toString() {
    return 'GeminiState(text: $text, isLoading: $isLoading)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GeminiStateImpl &&
            (identical(other.text, text) || other.text == text) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading));
  }

  @override
  int get hashCode => Object.hash(runtimeType, text, isLoading);

  /// Create a copy of GeminiState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GeminiStateImplCopyWith<_$GeminiStateImpl> get copyWith =>
      __$$GeminiStateImplCopyWithImpl<_$GeminiStateImpl>(this, _$identity);
}

abstract class _GeminiState implements GeminiState {
  const factory _GeminiState({final String? text, final bool isLoading}) =
      _$GeminiStateImpl;

  @override
  String? get text;
  @override
  bool get isLoading;

  /// Create a copy of GeminiState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GeminiStateImplCopyWith<_$GeminiStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
