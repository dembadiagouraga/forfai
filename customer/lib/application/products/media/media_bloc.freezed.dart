// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'media_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$MediaEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String path) setVideo,
    required TResult Function(String path) setPreview,
    required TResult Function() deletePreview,
    required TResult Function(
            BuildContext context, ValueChanged<String> onSuccess)
        uploadImage,
    required TResult Function(
            BuildContext context, ValueChanged<String> onSuccess)
        uploadVideo,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String path)? setVideo,
    TResult? Function(String path)? setPreview,
    TResult? Function()? deletePreview,
    TResult? Function(BuildContext context, ValueChanged<String> onSuccess)?
        uploadImage,
    TResult? Function(BuildContext context, ValueChanged<String> onSuccess)?
        uploadVideo,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String path)? setVideo,
    TResult Function(String path)? setPreview,
    TResult Function()? deletePreview,
    TResult Function(BuildContext context, ValueChanged<String> onSuccess)?
        uploadImage,
    TResult Function(BuildContext context, ValueChanged<String> onSuccess)?
        uploadVideo,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SetVideo value) setVideo,
    required TResult Function(SetPreview value) setPreview,
    required TResult Function(DeletePreview value) deletePreview,
    required TResult Function(UploadImage value) uploadImage,
    required TResult Function(UploadVideo value) uploadVideo,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SetVideo value)? setVideo,
    TResult? Function(SetPreview value)? setPreview,
    TResult? Function(DeletePreview value)? deletePreview,
    TResult? Function(UploadImage value)? uploadImage,
    TResult? Function(UploadVideo value)? uploadVideo,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SetVideo value)? setVideo,
    TResult Function(SetPreview value)? setPreview,
    TResult Function(DeletePreview value)? deletePreview,
    TResult Function(UploadImage value)? uploadImage,
    TResult Function(UploadVideo value)? uploadVideo,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MediaEventCopyWith<$Res> {
  factory $MediaEventCopyWith(
          MediaEvent value, $Res Function(MediaEvent) then) =
      _$MediaEventCopyWithImpl<$Res, MediaEvent>;
}

/// @nodoc
class _$MediaEventCopyWithImpl<$Res, $Val extends MediaEvent>
    implements $MediaEventCopyWith<$Res> {
  _$MediaEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MediaEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$SetVideoImplCopyWith<$Res> {
  factory _$$SetVideoImplCopyWith(
          _$SetVideoImpl value, $Res Function(_$SetVideoImpl) then) =
      __$$SetVideoImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String path});
}

/// @nodoc
class __$$SetVideoImplCopyWithImpl<$Res>
    extends _$MediaEventCopyWithImpl<$Res, _$SetVideoImpl>
    implements _$$SetVideoImplCopyWith<$Res> {
  __$$SetVideoImplCopyWithImpl(
      _$SetVideoImpl _value, $Res Function(_$SetVideoImpl) _then)
      : super(_value, _then);

  /// Create a copy of MediaEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? path = null,
  }) {
    return _then(_$SetVideoImpl(
      path: null == path
          ? _value.path
          : path // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$SetVideoImpl implements SetVideo {
  const _$SetVideoImpl({required this.path});

  @override
  final String path;

  @override
  String toString() {
    return 'MediaEvent.setVideo(path: $path)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SetVideoImpl &&
            (identical(other.path, path) || other.path == path));
  }

  @override
  int get hashCode => Object.hash(runtimeType, path);

  /// Create a copy of MediaEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SetVideoImplCopyWith<_$SetVideoImpl> get copyWith =>
      __$$SetVideoImplCopyWithImpl<_$SetVideoImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String path) setVideo,
    required TResult Function(String path) setPreview,
    required TResult Function() deletePreview,
    required TResult Function(
            BuildContext context, ValueChanged<String> onSuccess)
        uploadImage,
    required TResult Function(
            BuildContext context, ValueChanged<String> onSuccess)
        uploadVideo,
  }) {
    return setVideo(path);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String path)? setVideo,
    TResult? Function(String path)? setPreview,
    TResult? Function()? deletePreview,
    TResult? Function(BuildContext context, ValueChanged<String> onSuccess)?
        uploadImage,
    TResult? Function(BuildContext context, ValueChanged<String> onSuccess)?
        uploadVideo,
  }) {
    return setVideo?.call(path);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String path)? setVideo,
    TResult Function(String path)? setPreview,
    TResult Function()? deletePreview,
    TResult Function(BuildContext context, ValueChanged<String> onSuccess)?
        uploadImage,
    TResult Function(BuildContext context, ValueChanged<String> onSuccess)?
        uploadVideo,
    required TResult orElse(),
  }) {
    if (setVideo != null) {
      return setVideo(path);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SetVideo value) setVideo,
    required TResult Function(SetPreview value) setPreview,
    required TResult Function(DeletePreview value) deletePreview,
    required TResult Function(UploadImage value) uploadImage,
    required TResult Function(UploadVideo value) uploadVideo,
  }) {
    return setVideo(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SetVideo value)? setVideo,
    TResult? Function(SetPreview value)? setPreview,
    TResult? Function(DeletePreview value)? deletePreview,
    TResult? Function(UploadImage value)? uploadImage,
    TResult? Function(UploadVideo value)? uploadVideo,
  }) {
    return setVideo?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SetVideo value)? setVideo,
    TResult Function(SetPreview value)? setPreview,
    TResult Function(DeletePreview value)? deletePreview,
    TResult Function(UploadImage value)? uploadImage,
    TResult Function(UploadVideo value)? uploadVideo,
    required TResult orElse(),
  }) {
    if (setVideo != null) {
      return setVideo(this);
    }
    return orElse();
  }
}

abstract class SetVideo implements MediaEvent {
  const factory SetVideo({required final String path}) = _$SetVideoImpl;

  String get path;

  /// Create a copy of MediaEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SetVideoImplCopyWith<_$SetVideoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SetPreviewImplCopyWith<$Res> {
  factory _$$SetPreviewImplCopyWith(
          _$SetPreviewImpl value, $Res Function(_$SetPreviewImpl) then) =
      __$$SetPreviewImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String path});
}

/// @nodoc
class __$$SetPreviewImplCopyWithImpl<$Res>
    extends _$MediaEventCopyWithImpl<$Res, _$SetPreviewImpl>
    implements _$$SetPreviewImplCopyWith<$Res> {
  __$$SetPreviewImplCopyWithImpl(
      _$SetPreviewImpl _value, $Res Function(_$SetPreviewImpl) _then)
      : super(_value, _then);

  /// Create a copy of MediaEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? path = null,
  }) {
    return _then(_$SetPreviewImpl(
      path: null == path
          ? _value.path
          : path // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$SetPreviewImpl implements SetPreview {
  const _$SetPreviewImpl({required this.path});

  @override
  final String path;

  @override
  String toString() {
    return 'MediaEvent.setPreview(path: $path)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SetPreviewImpl &&
            (identical(other.path, path) || other.path == path));
  }

  @override
  int get hashCode => Object.hash(runtimeType, path);

  /// Create a copy of MediaEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SetPreviewImplCopyWith<_$SetPreviewImpl> get copyWith =>
      __$$SetPreviewImplCopyWithImpl<_$SetPreviewImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String path) setVideo,
    required TResult Function(String path) setPreview,
    required TResult Function() deletePreview,
    required TResult Function(
            BuildContext context, ValueChanged<String> onSuccess)
        uploadImage,
    required TResult Function(
            BuildContext context, ValueChanged<String> onSuccess)
        uploadVideo,
  }) {
    return setPreview(path);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String path)? setVideo,
    TResult? Function(String path)? setPreview,
    TResult? Function()? deletePreview,
    TResult? Function(BuildContext context, ValueChanged<String> onSuccess)?
        uploadImage,
    TResult? Function(BuildContext context, ValueChanged<String> onSuccess)?
        uploadVideo,
  }) {
    return setPreview?.call(path);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String path)? setVideo,
    TResult Function(String path)? setPreview,
    TResult Function()? deletePreview,
    TResult Function(BuildContext context, ValueChanged<String> onSuccess)?
        uploadImage,
    TResult Function(BuildContext context, ValueChanged<String> onSuccess)?
        uploadVideo,
    required TResult orElse(),
  }) {
    if (setPreview != null) {
      return setPreview(path);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SetVideo value) setVideo,
    required TResult Function(SetPreview value) setPreview,
    required TResult Function(DeletePreview value) deletePreview,
    required TResult Function(UploadImage value) uploadImage,
    required TResult Function(UploadVideo value) uploadVideo,
  }) {
    return setPreview(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SetVideo value)? setVideo,
    TResult? Function(SetPreview value)? setPreview,
    TResult? Function(DeletePreview value)? deletePreview,
    TResult? Function(UploadImage value)? uploadImage,
    TResult? Function(UploadVideo value)? uploadVideo,
  }) {
    return setPreview?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SetVideo value)? setVideo,
    TResult Function(SetPreview value)? setPreview,
    TResult Function(DeletePreview value)? deletePreview,
    TResult Function(UploadImage value)? uploadImage,
    TResult Function(UploadVideo value)? uploadVideo,
    required TResult orElse(),
  }) {
    if (setPreview != null) {
      return setPreview(this);
    }
    return orElse();
  }
}

abstract class SetPreview implements MediaEvent {
  const factory SetPreview({required final String path}) = _$SetPreviewImpl;

  String get path;

  /// Create a copy of MediaEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SetPreviewImplCopyWith<_$SetPreviewImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$DeletePreviewImplCopyWith<$Res> {
  factory _$$DeletePreviewImplCopyWith(
          _$DeletePreviewImpl value, $Res Function(_$DeletePreviewImpl) then) =
      __$$DeletePreviewImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$DeletePreviewImplCopyWithImpl<$Res>
    extends _$MediaEventCopyWithImpl<$Res, _$DeletePreviewImpl>
    implements _$$DeletePreviewImplCopyWith<$Res> {
  __$$DeletePreviewImplCopyWithImpl(
      _$DeletePreviewImpl _value, $Res Function(_$DeletePreviewImpl) _then)
      : super(_value, _then);

  /// Create a copy of MediaEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$DeletePreviewImpl implements DeletePreview {
  const _$DeletePreviewImpl();

  @override
  String toString() {
    return 'MediaEvent.deletePreview()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$DeletePreviewImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String path) setVideo,
    required TResult Function(String path) setPreview,
    required TResult Function() deletePreview,
    required TResult Function(
            BuildContext context, ValueChanged<String> onSuccess)
        uploadImage,
    required TResult Function(
            BuildContext context, ValueChanged<String> onSuccess)
        uploadVideo,
  }) {
    return deletePreview();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String path)? setVideo,
    TResult? Function(String path)? setPreview,
    TResult? Function()? deletePreview,
    TResult? Function(BuildContext context, ValueChanged<String> onSuccess)?
        uploadImage,
    TResult? Function(BuildContext context, ValueChanged<String> onSuccess)?
        uploadVideo,
  }) {
    return deletePreview?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String path)? setVideo,
    TResult Function(String path)? setPreview,
    TResult Function()? deletePreview,
    TResult Function(BuildContext context, ValueChanged<String> onSuccess)?
        uploadImage,
    TResult Function(BuildContext context, ValueChanged<String> onSuccess)?
        uploadVideo,
    required TResult orElse(),
  }) {
    if (deletePreview != null) {
      return deletePreview();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SetVideo value) setVideo,
    required TResult Function(SetPreview value) setPreview,
    required TResult Function(DeletePreview value) deletePreview,
    required TResult Function(UploadImage value) uploadImage,
    required TResult Function(UploadVideo value) uploadVideo,
  }) {
    return deletePreview(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SetVideo value)? setVideo,
    TResult? Function(SetPreview value)? setPreview,
    TResult? Function(DeletePreview value)? deletePreview,
    TResult? Function(UploadImage value)? uploadImage,
    TResult? Function(UploadVideo value)? uploadVideo,
  }) {
    return deletePreview?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SetVideo value)? setVideo,
    TResult Function(SetPreview value)? setPreview,
    TResult Function(DeletePreview value)? deletePreview,
    TResult Function(UploadImage value)? uploadImage,
    TResult Function(UploadVideo value)? uploadVideo,
    required TResult orElse(),
  }) {
    if (deletePreview != null) {
      return deletePreview(this);
    }
    return orElse();
  }
}

abstract class DeletePreview implements MediaEvent {
  const factory DeletePreview() = _$DeletePreviewImpl;
}

/// @nodoc
abstract class _$$UploadImageImplCopyWith<$Res> {
  factory _$$UploadImageImplCopyWith(
          _$UploadImageImpl value, $Res Function(_$UploadImageImpl) then) =
      __$$UploadImageImplCopyWithImpl<$Res>;
  @useResult
  $Res call({BuildContext context, ValueChanged<String> onSuccess});
}

/// @nodoc
class __$$UploadImageImplCopyWithImpl<$Res>
    extends _$MediaEventCopyWithImpl<$Res, _$UploadImageImpl>
    implements _$$UploadImageImplCopyWith<$Res> {
  __$$UploadImageImplCopyWithImpl(
      _$UploadImageImpl _value, $Res Function(_$UploadImageImpl) _then)
      : super(_value, _then);

  /// Create a copy of MediaEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? context = null,
    Object? onSuccess = null,
  }) {
    return _then(_$UploadImageImpl(
      context: null == context
          ? _value.context
          : context // ignore: cast_nullable_to_non_nullable
              as BuildContext,
      onSuccess: null == onSuccess
          ? _value.onSuccess
          : onSuccess // ignore: cast_nullable_to_non_nullable
              as ValueChanged<String>,
    ));
  }
}

/// @nodoc

class _$UploadImageImpl implements UploadImage {
  const _$UploadImageImpl({required this.context, required this.onSuccess});

  @override
  final BuildContext context;
  @override
  final ValueChanged<String> onSuccess;

  @override
  String toString() {
    return 'MediaEvent.uploadImage(context: $context, onSuccess: $onSuccess)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UploadImageImpl &&
            (identical(other.context, context) || other.context == context) &&
            (identical(other.onSuccess, onSuccess) ||
                other.onSuccess == onSuccess));
  }

  @override
  int get hashCode => Object.hash(runtimeType, context, onSuccess);

  /// Create a copy of MediaEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UploadImageImplCopyWith<_$UploadImageImpl> get copyWith =>
      __$$UploadImageImplCopyWithImpl<_$UploadImageImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String path) setVideo,
    required TResult Function(String path) setPreview,
    required TResult Function() deletePreview,
    required TResult Function(
            BuildContext context, ValueChanged<String> onSuccess)
        uploadImage,
    required TResult Function(
            BuildContext context, ValueChanged<String> onSuccess)
        uploadVideo,
  }) {
    return uploadImage(context, onSuccess);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String path)? setVideo,
    TResult? Function(String path)? setPreview,
    TResult? Function()? deletePreview,
    TResult? Function(BuildContext context, ValueChanged<String> onSuccess)?
        uploadImage,
    TResult? Function(BuildContext context, ValueChanged<String> onSuccess)?
        uploadVideo,
  }) {
    return uploadImage?.call(context, onSuccess);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String path)? setVideo,
    TResult Function(String path)? setPreview,
    TResult Function()? deletePreview,
    TResult Function(BuildContext context, ValueChanged<String> onSuccess)?
        uploadImage,
    TResult Function(BuildContext context, ValueChanged<String> onSuccess)?
        uploadVideo,
    required TResult orElse(),
  }) {
    if (uploadImage != null) {
      return uploadImage(context, onSuccess);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SetVideo value) setVideo,
    required TResult Function(SetPreview value) setPreview,
    required TResult Function(DeletePreview value) deletePreview,
    required TResult Function(UploadImage value) uploadImage,
    required TResult Function(UploadVideo value) uploadVideo,
  }) {
    return uploadImage(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SetVideo value)? setVideo,
    TResult? Function(SetPreview value)? setPreview,
    TResult? Function(DeletePreview value)? deletePreview,
    TResult? Function(UploadImage value)? uploadImage,
    TResult? Function(UploadVideo value)? uploadVideo,
  }) {
    return uploadImage?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SetVideo value)? setVideo,
    TResult Function(SetPreview value)? setPreview,
    TResult Function(DeletePreview value)? deletePreview,
    TResult Function(UploadImage value)? uploadImage,
    TResult Function(UploadVideo value)? uploadVideo,
    required TResult orElse(),
  }) {
    if (uploadImage != null) {
      return uploadImage(this);
    }
    return orElse();
  }
}

abstract class UploadImage implements MediaEvent {
  const factory UploadImage(
      {required final BuildContext context,
      required final ValueChanged<String> onSuccess}) = _$UploadImageImpl;

  BuildContext get context;
  ValueChanged<String> get onSuccess;

  /// Create a copy of MediaEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UploadImageImplCopyWith<_$UploadImageImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$UploadVideoImplCopyWith<$Res> {
  factory _$$UploadVideoImplCopyWith(
          _$UploadVideoImpl value, $Res Function(_$UploadVideoImpl) then) =
      __$$UploadVideoImplCopyWithImpl<$Res>;
  @useResult
  $Res call({BuildContext context, ValueChanged<String> onSuccess});
}

/// @nodoc
class __$$UploadVideoImplCopyWithImpl<$Res>
    extends _$MediaEventCopyWithImpl<$Res, _$UploadVideoImpl>
    implements _$$UploadVideoImplCopyWith<$Res> {
  __$$UploadVideoImplCopyWithImpl(
      _$UploadVideoImpl _value, $Res Function(_$UploadVideoImpl) _then)
      : super(_value, _then);

  /// Create a copy of MediaEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? context = null,
    Object? onSuccess = null,
  }) {
    return _then(_$UploadVideoImpl(
      context: null == context
          ? _value.context
          : context // ignore: cast_nullable_to_non_nullable
              as BuildContext,
      onSuccess: null == onSuccess
          ? _value.onSuccess
          : onSuccess // ignore: cast_nullable_to_non_nullable
              as ValueChanged<String>,
    ));
  }
}

/// @nodoc

class _$UploadVideoImpl implements UploadVideo {
  const _$UploadVideoImpl({required this.context, required this.onSuccess});

  @override
  final BuildContext context;
  @override
  final ValueChanged<String> onSuccess;

  @override
  String toString() {
    return 'MediaEvent.uploadVideo(context: $context, onSuccess: $onSuccess)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UploadVideoImpl &&
            (identical(other.context, context) || other.context == context) &&
            (identical(other.onSuccess, onSuccess) ||
                other.onSuccess == onSuccess));
  }

  @override
  int get hashCode => Object.hash(runtimeType, context, onSuccess);

  /// Create a copy of MediaEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UploadVideoImplCopyWith<_$UploadVideoImpl> get copyWith =>
      __$$UploadVideoImplCopyWithImpl<_$UploadVideoImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String path) setVideo,
    required TResult Function(String path) setPreview,
    required TResult Function() deletePreview,
    required TResult Function(
            BuildContext context, ValueChanged<String> onSuccess)
        uploadImage,
    required TResult Function(
            BuildContext context, ValueChanged<String> onSuccess)
        uploadVideo,
  }) {
    return uploadVideo(context, onSuccess);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String path)? setVideo,
    TResult? Function(String path)? setPreview,
    TResult? Function()? deletePreview,
    TResult? Function(BuildContext context, ValueChanged<String> onSuccess)?
        uploadImage,
    TResult? Function(BuildContext context, ValueChanged<String> onSuccess)?
        uploadVideo,
  }) {
    return uploadVideo?.call(context, onSuccess);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String path)? setVideo,
    TResult Function(String path)? setPreview,
    TResult Function()? deletePreview,
    TResult Function(BuildContext context, ValueChanged<String> onSuccess)?
        uploadImage,
    TResult Function(BuildContext context, ValueChanged<String> onSuccess)?
        uploadVideo,
    required TResult orElse(),
  }) {
    if (uploadVideo != null) {
      return uploadVideo(context, onSuccess);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SetVideo value) setVideo,
    required TResult Function(SetPreview value) setPreview,
    required TResult Function(DeletePreview value) deletePreview,
    required TResult Function(UploadImage value) uploadImage,
    required TResult Function(UploadVideo value) uploadVideo,
  }) {
    return uploadVideo(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SetVideo value)? setVideo,
    TResult? Function(SetPreview value)? setPreview,
    TResult? Function(DeletePreview value)? deletePreview,
    TResult? Function(UploadImage value)? uploadImage,
    TResult? Function(UploadVideo value)? uploadVideo,
  }) {
    return uploadVideo?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SetVideo value)? setVideo,
    TResult Function(SetPreview value)? setPreview,
    TResult Function(DeletePreview value)? deletePreview,
    TResult Function(UploadImage value)? uploadImage,
    TResult Function(UploadVideo value)? uploadVideo,
    required TResult orElse(),
  }) {
    if (uploadVideo != null) {
      return uploadVideo(this);
    }
    return orElse();
  }
}

abstract class UploadVideo implements MediaEvent {
  const factory UploadVideo(
      {required final BuildContext context,
      required final ValueChanged<String> onSuccess}) = _$UploadVideoImpl;

  BuildContext get context;
  ValueChanged<String> get onSuccess;

  /// Create a copy of MediaEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UploadVideoImplCopyWith<_$UploadVideoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$MediaState {
  bool get isLoading => throw _privateConstructorUsedError;
  String? get videoPath => throw _privateConstructorUsedError;
  String? get imagePath => throw _privateConstructorUsedError;

  /// Create a copy of MediaState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MediaStateCopyWith<MediaState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MediaStateCopyWith<$Res> {
  factory $MediaStateCopyWith(
          MediaState value, $Res Function(MediaState) then) =
      _$MediaStateCopyWithImpl<$Res, MediaState>;
  @useResult
  $Res call({bool isLoading, String? videoPath, String? imagePath});
}

/// @nodoc
class _$MediaStateCopyWithImpl<$Res, $Val extends MediaState>
    implements $MediaStateCopyWith<$Res> {
  _$MediaStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MediaState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? videoPath = freezed,
    Object? imagePath = freezed,
  }) {
    return _then(_value.copyWith(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      videoPath: freezed == videoPath
          ? _value.videoPath
          : videoPath // ignore: cast_nullable_to_non_nullable
              as String?,
      imagePath: freezed == imagePath
          ? _value.imagePath
          : imagePath // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MediaStateImplCopyWith<$Res>
    implements $MediaStateCopyWith<$Res> {
  factory _$$MediaStateImplCopyWith(
          _$MediaStateImpl value, $Res Function(_$MediaStateImpl) then) =
      __$$MediaStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool isLoading, String? videoPath, String? imagePath});
}

/// @nodoc
class __$$MediaStateImplCopyWithImpl<$Res>
    extends _$MediaStateCopyWithImpl<$Res, _$MediaStateImpl>
    implements _$$MediaStateImplCopyWith<$Res> {
  __$$MediaStateImplCopyWithImpl(
      _$MediaStateImpl _value, $Res Function(_$MediaStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of MediaState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? videoPath = freezed,
    Object? imagePath = freezed,
  }) {
    return _then(_$MediaStateImpl(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      videoPath: freezed == videoPath
          ? _value.videoPath
          : videoPath // ignore: cast_nullable_to_non_nullable
              as String?,
      imagePath: freezed == imagePath
          ? _value.imagePath
          : imagePath // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$MediaStateImpl implements _MediaState {
  const _$MediaStateImpl(
      {this.isLoading = false, this.videoPath = null, this.imagePath = null});

  @override
  @JsonKey()
  final bool isLoading;
  @override
  @JsonKey()
  final String? videoPath;
  @override
  @JsonKey()
  final String? imagePath;

  @override
  String toString() {
    return 'MediaState(isLoading: $isLoading, videoPath: $videoPath, imagePath: $imagePath)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MediaStateImpl &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.videoPath, videoPath) ||
                other.videoPath == videoPath) &&
            (identical(other.imagePath, imagePath) ||
                other.imagePath == imagePath));
  }

  @override
  int get hashCode => Object.hash(runtimeType, isLoading, videoPath, imagePath);

  /// Create a copy of MediaState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MediaStateImplCopyWith<_$MediaStateImpl> get copyWith =>
      __$$MediaStateImplCopyWithImpl<_$MediaStateImpl>(this, _$identity);
}

abstract class _MediaState implements MediaState {
  const factory _MediaState(
      {final bool isLoading,
      final String? videoPath,
      final String? imagePath}) = _$MediaStateImpl;

  @override
  bool get isLoading;
  @override
  String? get videoPath;
  @override
  String? get imagePath;

  /// Create a copy of MediaState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MediaStateImplCopyWith<_$MediaStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
