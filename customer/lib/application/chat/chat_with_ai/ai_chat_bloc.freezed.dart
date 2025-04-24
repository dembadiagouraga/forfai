// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ai_chat_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$AiChatEvent {
  BuildContext get context => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(BuildContext context, int? sellerId) checkChatId,
    required TResult Function(BuildContext context, String file) sendImage,
    required TResult Function(
            BuildContext context, String message, ProductData? product)
        sendMessage,
    required TResult Function(
            BuildContext context, String message, String messageId)
        editMessage,
    required TResult Function(
            BuildContext context, String message, String messageId)
        replyMessage,
    required TResult Function(BuildContext context, String messageId)
        deleteMessage,
    required TResult Function(BuildContext context, String message, int? userId,
            Function onSuccess)
        createAndSendMessage,
    required TResult Function(BuildContext context, bool? isRefresh,
            RefreshController? controller)
        getChatList,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(BuildContext context, int? sellerId)? checkChatId,
    TResult? Function(BuildContext context, String file)? sendImage,
    TResult? Function(
            BuildContext context, String message, ProductData? product)?
        sendMessage,
    TResult? Function(BuildContext context, String message, String messageId)?
        editMessage,
    TResult? Function(BuildContext context, String message, String messageId)?
        replyMessage,
    TResult? Function(BuildContext context, String messageId)? deleteMessage,
    TResult? Function(BuildContext context, String message, int? userId,
            Function onSuccess)?
        createAndSendMessage,
    TResult? Function(BuildContext context, bool? isRefresh,
            RefreshController? controller)?
        getChatList,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(BuildContext context, int? sellerId)? checkChatId,
    TResult Function(BuildContext context, String file)? sendImage,
    TResult Function(
            BuildContext context, String message, ProductData? product)?
        sendMessage,
    TResult Function(BuildContext context, String message, String messageId)?
        editMessage,
    TResult Function(BuildContext context, String message, String messageId)?
        replyMessage,
    TResult Function(BuildContext context, String messageId)? deleteMessage,
    TResult Function(BuildContext context, String message, int? userId,
            Function onSuccess)?
        createAndSendMessage,
    TResult Function(BuildContext context, bool? isRefresh,
            RefreshController? controller)?
        getChatList,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CheckChatId value) checkChatId,
    required TResult Function(SendImage value) sendImage,
    required TResult Function(SendMessage value) sendMessage,
    required TResult Function(EditMessage value) editMessage,
    required TResult Function(ReplyMessage value) replyMessage,
    required TResult Function(DeleteMessage value) deleteMessage,
    required TResult Function(CreateAndSendMessage value) createAndSendMessage,
    required TResult Function(GetChatList value) getChatList,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CheckChatId value)? checkChatId,
    TResult? Function(SendImage value)? sendImage,
    TResult? Function(SendMessage value)? sendMessage,
    TResult? Function(EditMessage value)? editMessage,
    TResult? Function(ReplyMessage value)? replyMessage,
    TResult? Function(DeleteMessage value)? deleteMessage,
    TResult? Function(CreateAndSendMessage value)? createAndSendMessage,
    TResult? Function(GetChatList value)? getChatList,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CheckChatId value)? checkChatId,
    TResult Function(SendImage value)? sendImage,
    TResult Function(SendMessage value)? sendMessage,
    TResult Function(EditMessage value)? editMessage,
    TResult Function(ReplyMessage value)? replyMessage,
    TResult Function(DeleteMessage value)? deleteMessage,
    TResult Function(CreateAndSendMessage value)? createAndSendMessage,
    TResult Function(GetChatList value)? getChatList,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  /// Create a copy of AiChatEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AiChatEventCopyWith<AiChatEvent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AiChatEventCopyWith<$Res> {
  factory $AiChatEventCopyWith(
          AiChatEvent value, $Res Function(AiChatEvent) then) =
      _$AiChatEventCopyWithImpl<$Res, AiChatEvent>;
  @useResult
  $Res call({BuildContext context});
}

/// @nodoc
class _$AiChatEventCopyWithImpl<$Res, $Val extends AiChatEvent>
    implements $AiChatEventCopyWith<$Res> {
  _$AiChatEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AiChatEvent
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
abstract class _$$CheckChatIdImplCopyWith<$Res>
    implements $AiChatEventCopyWith<$Res> {
  factory _$$CheckChatIdImplCopyWith(
          _$CheckChatIdImpl value, $Res Function(_$CheckChatIdImpl) then) =
      __$$CheckChatIdImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({BuildContext context, int? sellerId});
}

/// @nodoc
class __$$CheckChatIdImplCopyWithImpl<$Res>
    extends _$AiChatEventCopyWithImpl<$Res, _$CheckChatIdImpl>
    implements _$$CheckChatIdImplCopyWith<$Res> {
  __$$CheckChatIdImplCopyWithImpl(
      _$CheckChatIdImpl _value, $Res Function(_$CheckChatIdImpl) _then)
      : super(_value, _then);

  /// Create a copy of AiChatEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? context = null,
    Object? sellerId = freezed,
  }) {
    return _then(_$CheckChatIdImpl(
      context: null == context
          ? _value.context
          : context // ignore: cast_nullable_to_non_nullable
              as BuildContext,
      sellerId: freezed == sellerId
          ? _value.sellerId
          : sellerId // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc

class _$CheckChatIdImpl implements CheckChatId {
  const _$CheckChatIdImpl({required this.context, required this.sellerId});

  @override
  final BuildContext context;
  @override
  final int? sellerId;

  @override
  String toString() {
    return 'AiChatEvent.checkChatId(context: $context, sellerId: $sellerId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CheckChatIdImpl &&
            (identical(other.context, context) || other.context == context) &&
            (identical(other.sellerId, sellerId) ||
                other.sellerId == sellerId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, context, sellerId);

  /// Create a copy of AiChatEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CheckChatIdImplCopyWith<_$CheckChatIdImpl> get copyWith =>
      __$$CheckChatIdImplCopyWithImpl<_$CheckChatIdImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(BuildContext context, int? sellerId) checkChatId,
    required TResult Function(BuildContext context, String file) sendImage,
    required TResult Function(
            BuildContext context, String message, ProductData? product)
        sendMessage,
    required TResult Function(
            BuildContext context, String message, String messageId)
        editMessage,
    required TResult Function(
            BuildContext context, String message, String messageId)
        replyMessage,
    required TResult Function(BuildContext context, String messageId)
        deleteMessage,
    required TResult Function(BuildContext context, String message, int? userId,
            Function onSuccess)
        createAndSendMessage,
    required TResult Function(BuildContext context, bool? isRefresh,
            RefreshController? controller)
        getChatList,
  }) {
    return checkChatId(context, sellerId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(BuildContext context, int? sellerId)? checkChatId,
    TResult? Function(BuildContext context, String file)? sendImage,
    TResult? Function(
            BuildContext context, String message, ProductData? product)?
        sendMessage,
    TResult? Function(BuildContext context, String message, String messageId)?
        editMessage,
    TResult? Function(BuildContext context, String message, String messageId)?
        replyMessage,
    TResult? Function(BuildContext context, String messageId)? deleteMessage,
    TResult? Function(BuildContext context, String message, int? userId,
            Function onSuccess)?
        createAndSendMessage,
    TResult? Function(BuildContext context, bool? isRefresh,
            RefreshController? controller)?
        getChatList,
  }) {
    return checkChatId?.call(context, sellerId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(BuildContext context, int? sellerId)? checkChatId,
    TResult Function(BuildContext context, String file)? sendImage,
    TResult Function(
            BuildContext context, String message, ProductData? product)?
        sendMessage,
    TResult Function(BuildContext context, String message, String messageId)?
        editMessage,
    TResult Function(BuildContext context, String message, String messageId)?
        replyMessage,
    TResult Function(BuildContext context, String messageId)? deleteMessage,
    TResult Function(BuildContext context, String message, int? userId,
            Function onSuccess)?
        createAndSendMessage,
    TResult Function(BuildContext context, bool? isRefresh,
            RefreshController? controller)?
        getChatList,
    required TResult orElse(),
  }) {
    if (checkChatId != null) {
      return checkChatId(context, sellerId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CheckChatId value) checkChatId,
    required TResult Function(SendImage value) sendImage,
    required TResult Function(SendMessage value) sendMessage,
    required TResult Function(EditMessage value) editMessage,
    required TResult Function(ReplyMessage value) replyMessage,
    required TResult Function(DeleteMessage value) deleteMessage,
    required TResult Function(CreateAndSendMessage value) createAndSendMessage,
    required TResult Function(GetChatList value) getChatList,
  }) {
    return checkChatId(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CheckChatId value)? checkChatId,
    TResult? Function(SendImage value)? sendImage,
    TResult? Function(SendMessage value)? sendMessage,
    TResult? Function(EditMessage value)? editMessage,
    TResult? Function(ReplyMessage value)? replyMessage,
    TResult? Function(DeleteMessage value)? deleteMessage,
    TResult? Function(CreateAndSendMessage value)? createAndSendMessage,
    TResult? Function(GetChatList value)? getChatList,
  }) {
    return checkChatId?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CheckChatId value)? checkChatId,
    TResult Function(SendImage value)? sendImage,
    TResult Function(SendMessage value)? sendMessage,
    TResult Function(EditMessage value)? editMessage,
    TResult Function(ReplyMessage value)? replyMessage,
    TResult Function(DeleteMessage value)? deleteMessage,
    TResult Function(CreateAndSendMessage value)? createAndSendMessage,
    TResult Function(GetChatList value)? getChatList,
    required TResult orElse(),
  }) {
    if (checkChatId != null) {
      return checkChatId(this);
    }
    return orElse();
  }
}

abstract class CheckChatId implements AiChatEvent {
  const factory CheckChatId(
      {required final BuildContext context,
      required final int? sellerId}) = _$CheckChatIdImpl;

  @override
  BuildContext get context;
  int? get sellerId;

  /// Create a copy of AiChatEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CheckChatIdImplCopyWith<_$CheckChatIdImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SendImageImplCopyWith<$Res>
    implements $AiChatEventCopyWith<$Res> {
  factory _$$SendImageImplCopyWith(
          _$SendImageImpl value, $Res Function(_$SendImageImpl) then) =
      __$$SendImageImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({BuildContext context, String file});
}

/// @nodoc
class __$$SendImageImplCopyWithImpl<$Res>
    extends _$AiChatEventCopyWithImpl<$Res, _$SendImageImpl>
    implements _$$SendImageImplCopyWith<$Res> {
  __$$SendImageImplCopyWithImpl(
      _$SendImageImpl _value, $Res Function(_$SendImageImpl) _then)
      : super(_value, _then);

  /// Create a copy of AiChatEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? context = null,
    Object? file = null,
  }) {
    return _then(_$SendImageImpl(
      context: null == context
          ? _value.context
          : context // ignore: cast_nullable_to_non_nullable
              as BuildContext,
      file: null == file
          ? _value.file
          : file // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$SendImageImpl implements SendImage {
  const _$SendImageImpl({required this.context, required this.file});

  @override
  final BuildContext context;
  @override
  final String file;

  @override
  String toString() {
    return 'AiChatEvent.sendImage(context: $context, file: $file)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SendImageImpl &&
            (identical(other.context, context) || other.context == context) &&
            (identical(other.file, file) || other.file == file));
  }

  @override
  int get hashCode => Object.hash(runtimeType, context, file);

  /// Create a copy of AiChatEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SendImageImplCopyWith<_$SendImageImpl> get copyWith =>
      __$$SendImageImplCopyWithImpl<_$SendImageImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(BuildContext context, int? sellerId) checkChatId,
    required TResult Function(BuildContext context, String file) sendImage,
    required TResult Function(
            BuildContext context, String message, ProductData? product)
        sendMessage,
    required TResult Function(
            BuildContext context, String message, String messageId)
        editMessage,
    required TResult Function(
            BuildContext context, String message, String messageId)
        replyMessage,
    required TResult Function(BuildContext context, String messageId)
        deleteMessage,
    required TResult Function(BuildContext context, String message, int? userId,
            Function onSuccess)
        createAndSendMessage,
    required TResult Function(BuildContext context, bool? isRefresh,
            RefreshController? controller)
        getChatList,
  }) {
    return sendImage(context, file);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(BuildContext context, int? sellerId)? checkChatId,
    TResult? Function(BuildContext context, String file)? sendImage,
    TResult? Function(
            BuildContext context, String message, ProductData? product)?
        sendMessage,
    TResult? Function(BuildContext context, String message, String messageId)?
        editMessage,
    TResult? Function(BuildContext context, String message, String messageId)?
        replyMessage,
    TResult? Function(BuildContext context, String messageId)? deleteMessage,
    TResult? Function(BuildContext context, String message, int? userId,
            Function onSuccess)?
        createAndSendMessage,
    TResult? Function(BuildContext context, bool? isRefresh,
            RefreshController? controller)?
        getChatList,
  }) {
    return sendImage?.call(context, file);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(BuildContext context, int? sellerId)? checkChatId,
    TResult Function(BuildContext context, String file)? sendImage,
    TResult Function(
            BuildContext context, String message, ProductData? product)?
        sendMessage,
    TResult Function(BuildContext context, String message, String messageId)?
        editMessage,
    TResult Function(BuildContext context, String message, String messageId)?
        replyMessage,
    TResult Function(BuildContext context, String messageId)? deleteMessage,
    TResult Function(BuildContext context, String message, int? userId,
            Function onSuccess)?
        createAndSendMessage,
    TResult Function(BuildContext context, bool? isRefresh,
            RefreshController? controller)?
        getChatList,
    required TResult orElse(),
  }) {
    if (sendImage != null) {
      return sendImage(context, file);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CheckChatId value) checkChatId,
    required TResult Function(SendImage value) sendImage,
    required TResult Function(SendMessage value) sendMessage,
    required TResult Function(EditMessage value) editMessage,
    required TResult Function(ReplyMessage value) replyMessage,
    required TResult Function(DeleteMessage value) deleteMessage,
    required TResult Function(CreateAndSendMessage value) createAndSendMessage,
    required TResult Function(GetChatList value) getChatList,
  }) {
    return sendImage(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CheckChatId value)? checkChatId,
    TResult? Function(SendImage value)? sendImage,
    TResult? Function(SendMessage value)? sendMessage,
    TResult? Function(EditMessage value)? editMessage,
    TResult? Function(ReplyMessage value)? replyMessage,
    TResult? Function(DeleteMessage value)? deleteMessage,
    TResult? Function(CreateAndSendMessage value)? createAndSendMessage,
    TResult? Function(GetChatList value)? getChatList,
  }) {
    return sendImage?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CheckChatId value)? checkChatId,
    TResult Function(SendImage value)? sendImage,
    TResult Function(SendMessage value)? sendMessage,
    TResult Function(EditMessage value)? editMessage,
    TResult Function(ReplyMessage value)? replyMessage,
    TResult Function(DeleteMessage value)? deleteMessage,
    TResult Function(CreateAndSendMessage value)? createAndSendMessage,
    TResult Function(GetChatList value)? getChatList,
    required TResult orElse(),
  }) {
    if (sendImage != null) {
      return sendImage(this);
    }
    return orElse();
  }
}

abstract class SendImage implements AiChatEvent {
  const factory SendImage(
      {required final BuildContext context,
      required final String file}) = _$SendImageImpl;

  @override
  BuildContext get context;
  String get file;

  /// Create a copy of AiChatEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SendImageImplCopyWith<_$SendImageImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SendMessageImplCopyWith<$Res>
    implements $AiChatEventCopyWith<$Res> {
  factory _$$SendMessageImplCopyWith(
          _$SendMessageImpl value, $Res Function(_$SendMessageImpl) then) =
      __$$SendMessageImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({BuildContext context, String message, ProductData? product});
}

/// @nodoc
class __$$SendMessageImplCopyWithImpl<$Res>
    extends _$AiChatEventCopyWithImpl<$Res, _$SendMessageImpl>
    implements _$$SendMessageImplCopyWith<$Res> {
  __$$SendMessageImplCopyWithImpl(
      _$SendMessageImpl _value, $Res Function(_$SendMessageImpl) _then)
      : super(_value, _then);

  /// Create a copy of AiChatEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? context = null,
    Object? message = null,
    Object? product = freezed,
  }) {
    return _then(_$SendMessageImpl(
      context: null == context
          ? _value.context
          : context // ignore: cast_nullable_to_non_nullable
              as BuildContext,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      product: freezed == product
          ? _value.product
          : product // ignore: cast_nullable_to_non_nullable
              as ProductData?,
    ));
  }
}

/// @nodoc

class _$SendMessageImpl implements SendMessage {
  const _$SendMessageImpl(
      {required this.context, required this.message, required this.product});

  @override
  final BuildContext context;
  @override
  final String message;
  @override
  final ProductData? product;

  @override
  String toString() {
    return 'AiChatEvent.sendMessage(context: $context, message: $message, product: $product)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SendMessageImpl &&
            (identical(other.context, context) || other.context == context) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.product, product) || other.product == product));
  }

  @override
  int get hashCode => Object.hash(runtimeType, context, message, product);

  /// Create a copy of AiChatEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SendMessageImplCopyWith<_$SendMessageImpl> get copyWith =>
      __$$SendMessageImplCopyWithImpl<_$SendMessageImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(BuildContext context, int? sellerId) checkChatId,
    required TResult Function(BuildContext context, String file) sendImage,
    required TResult Function(
            BuildContext context, String message, ProductData? product)
        sendMessage,
    required TResult Function(
            BuildContext context, String message, String messageId)
        editMessage,
    required TResult Function(
            BuildContext context, String message, String messageId)
        replyMessage,
    required TResult Function(BuildContext context, String messageId)
        deleteMessage,
    required TResult Function(BuildContext context, String message, int? userId,
            Function onSuccess)
        createAndSendMessage,
    required TResult Function(BuildContext context, bool? isRefresh,
            RefreshController? controller)
        getChatList,
  }) {
    return sendMessage(context, message, product);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(BuildContext context, int? sellerId)? checkChatId,
    TResult? Function(BuildContext context, String file)? sendImage,
    TResult? Function(
            BuildContext context, String message, ProductData? product)?
        sendMessage,
    TResult? Function(BuildContext context, String message, String messageId)?
        editMessage,
    TResult? Function(BuildContext context, String message, String messageId)?
        replyMessage,
    TResult? Function(BuildContext context, String messageId)? deleteMessage,
    TResult? Function(BuildContext context, String message, int? userId,
            Function onSuccess)?
        createAndSendMessage,
    TResult? Function(BuildContext context, bool? isRefresh,
            RefreshController? controller)?
        getChatList,
  }) {
    return sendMessage?.call(context, message, product);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(BuildContext context, int? sellerId)? checkChatId,
    TResult Function(BuildContext context, String file)? sendImage,
    TResult Function(
            BuildContext context, String message, ProductData? product)?
        sendMessage,
    TResult Function(BuildContext context, String message, String messageId)?
        editMessage,
    TResult Function(BuildContext context, String message, String messageId)?
        replyMessage,
    TResult Function(BuildContext context, String messageId)? deleteMessage,
    TResult Function(BuildContext context, String message, int? userId,
            Function onSuccess)?
        createAndSendMessage,
    TResult Function(BuildContext context, bool? isRefresh,
            RefreshController? controller)?
        getChatList,
    required TResult orElse(),
  }) {
    if (sendMessage != null) {
      return sendMessage(context, message, product);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CheckChatId value) checkChatId,
    required TResult Function(SendImage value) sendImage,
    required TResult Function(SendMessage value) sendMessage,
    required TResult Function(EditMessage value) editMessage,
    required TResult Function(ReplyMessage value) replyMessage,
    required TResult Function(DeleteMessage value) deleteMessage,
    required TResult Function(CreateAndSendMessage value) createAndSendMessage,
    required TResult Function(GetChatList value) getChatList,
  }) {
    return sendMessage(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CheckChatId value)? checkChatId,
    TResult? Function(SendImage value)? sendImage,
    TResult? Function(SendMessage value)? sendMessage,
    TResult? Function(EditMessage value)? editMessage,
    TResult? Function(ReplyMessage value)? replyMessage,
    TResult? Function(DeleteMessage value)? deleteMessage,
    TResult? Function(CreateAndSendMessage value)? createAndSendMessage,
    TResult? Function(GetChatList value)? getChatList,
  }) {
    return sendMessage?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CheckChatId value)? checkChatId,
    TResult Function(SendImage value)? sendImage,
    TResult Function(SendMessage value)? sendMessage,
    TResult Function(EditMessage value)? editMessage,
    TResult Function(ReplyMessage value)? replyMessage,
    TResult Function(DeleteMessage value)? deleteMessage,
    TResult Function(CreateAndSendMessage value)? createAndSendMessage,
    TResult Function(GetChatList value)? getChatList,
    required TResult orElse(),
  }) {
    if (sendMessage != null) {
      return sendMessage(this);
    }
    return orElse();
  }
}

abstract class SendMessage implements AiChatEvent {
  const factory SendMessage(
      {required final BuildContext context,
      required final String message,
      required final ProductData? product}) = _$SendMessageImpl;

  @override
  BuildContext get context;
  String get message;
  ProductData? get product;

  /// Create a copy of AiChatEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SendMessageImplCopyWith<_$SendMessageImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$EditMessageImplCopyWith<$Res>
    implements $AiChatEventCopyWith<$Res> {
  factory _$$EditMessageImplCopyWith(
          _$EditMessageImpl value, $Res Function(_$EditMessageImpl) then) =
      __$$EditMessageImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({BuildContext context, String message, String messageId});
}

/// @nodoc
class __$$EditMessageImplCopyWithImpl<$Res>
    extends _$AiChatEventCopyWithImpl<$Res, _$EditMessageImpl>
    implements _$$EditMessageImplCopyWith<$Res> {
  __$$EditMessageImplCopyWithImpl(
      _$EditMessageImpl _value, $Res Function(_$EditMessageImpl) _then)
      : super(_value, _then);

  /// Create a copy of AiChatEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? context = null,
    Object? message = null,
    Object? messageId = null,
  }) {
    return _then(_$EditMessageImpl(
      context: null == context
          ? _value.context
          : context // ignore: cast_nullable_to_non_nullable
              as BuildContext,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      messageId: null == messageId
          ? _value.messageId
          : messageId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$EditMessageImpl implements EditMessage {
  const _$EditMessageImpl(
      {required this.context, required this.message, required this.messageId});

  @override
  final BuildContext context;
  @override
  final String message;
  @override
  final String messageId;

  @override
  String toString() {
    return 'AiChatEvent.editMessage(context: $context, message: $message, messageId: $messageId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EditMessageImpl &&
            (identical(other.context, context) || other.context == context) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.messageId, messageId) ||
                other.messageId == messageId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, context, message, messageId);

  /// Create a copy of AiChatEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EditMessageImplCopyWith<_$EditMessageImpl> get copyWith =>
      __$$EditMessageImplCopyWithImpl<_$EditMessageImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(BuildContext context, int? sellerId) checkChatId,
    required TResult Function(BuildContext context, String file) sendImage,
    required TResult Function(
            BuildContext context, String message, ProductData? product)
        sendMessage,
    required TResult Function(
            BuildContext context, String message, String messageId)
        editMessage,
    required TResult Function(
            BuildContext context, String message, String messageId)
        replyMessage,
    required TResult Function(BuildContext context, String messageId)
        deleteMessage,
    required TResult Function(BuildContext context, String message, int? userId,
            Function onSuccess)
        createAndSendMessage,
    required TResult Function(BuildContext context, bool? isRefresh,
            RefreshController? controller)
        getChatList,
  }) {
    return editMessage(context, message, messageId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(BuildContext context, int? sellerId)? checkChatId,
    TResult? Function(BuildContext context, String file)? sendImage,
    TResult? Function(
            BuildContext context, String message, ProductData? product)?
        sendMessage,
    TResult? Function(BuildContext context, String message, String messageId)?
        editMessage,
    TResult? Function(BuildContext context, String message, String messageId)?
        replyMessage,
    TResult? Function(BuildContext context, String messageId)? deleteMessage,
    TResult? Function(BuildContext context, String message, int? userId,
            Function onSuccess)?
        createAndSendMessage,
    TResult? Function(BuildContext context, bool? isRefresh,
            RefreshController? controller)?
        getChatList,
  }) {
    return editMessage?.call(context, message, messageId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(BuildContext context, int? sellerId)? checkChatId,
    TResult Function(BuildContext context, String file)? sendImage,
    TResult Function(
            BuildContext context, String message, ProductData? product)?
        sendMessage,
    TResult Function(BuildContext context, String message, String messageId)?
        editMessage,
    TResult Function(BuildContext context, String message, String messageId)?
        replyMessage,
    TResult Function(BuildContext context, String messageId)? deleteMessage,
    TResult Function(BuildContext context, String message, int? userId,
            Function onSuccess)?
        createAndSendMessage,
    TResult Function(BuildContext context, bool? isRefresh,
            RefreshController? controller)?
        getChatList,
    required TResult orElse(),
  }) {
    if (editMessage != null) {
      return editMessage(context, message, messageId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CheckChatId value) checkChatId,
    required TResult Function(SendImage value) sendImage,
    required TResult Function(SendMessage value) sendMessage,
    required TResult Function(EditMessage value) editMessage,
    required TResult Function(ReplyMessage value) replyMessage,
    required TResult Function(DeleteMessage value) deleteMessage,
    required TResult Function(CreateAndSendMessage value) createAndSendMessage,
    required TResult Function(GetChatList value) getChatList,
  }) {
    return editMessage(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CheckChatId value)? checkChatId,
    TResult? Function(SendImage value)? sendImage,
    TResult? Function(SendMessage value)? sendMessage,
    TResult? Function(EditMessage value)? editMessage,
    TResult? Function(ReplyMessage value)? replyMessage,
    TResult? Function(DeleteMessage value)? deleteMessage,
    TResult? Function(CreateAndSendMessage value)? createAndSendMessage,
    TResult? Function(GetChatList value)? getChatList,
  }) {
    return editMessage?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CheckChatId value)? checkChatId,
    TResult Function(SendImage value)? sendImage,
    TResult Function(SendMessage value)? sendMessage,
    TResult Function(EditMessage value)? editMessage,
    TResult Function(ReplyMessage value)? replyMessage,
    TResult Function(DeleteMessage value)? deleteMessage,
    TResult Function(CreateAndSendMessage value)? createAndSendMessage,
    TResult Function(GetChatList value)? getChatList,
    required TResult orElse(),
  }) {
    if (editMessage != null) {
      return editMessage(this);
    }
    return orElse();
  }
}

abstract class EditMessage implements AiChatEvent {
  const factory EditMessage(
      {required final BuildContext context,
      required final String message,
      required final String messageId}) = _$EditMessageImpl;

  @override
  BuildContext get context;
  String get message;
  String get messageId;

  /// Create a copy of AiChatEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EditMessageImplCopyWith<_$EditMessageImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ReplyMessageImplCopyWith<$Res>
    implements $AiChatEventCopyWith<$Res> {
  factory _$$ReplyMessageImplCopyWith(
          _$ReplyMessageImpl value, $Res Function(_$ReplyMessageImpl) then) =
      __$$ReplyMessageImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({BuildContext context, String message, String messageId});
}

/// @nodoc
class __$$ReplyMessageImplCopyWithImpl<$Res>
    extends _$AiChatEventCopyWithImpl<$Res, _$ReplyMessageImpl>
    implements _$$ReplyMessageImplCopyWith<$Res> {
  __$$ReplyMessageImplCopyWithImpl(
      _$ReplyMessageImpl _value, $Res Function(_$ReplyMessageImpl) _then)
      : super(_value, _then);

  /// Create a copy of AiChatEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? context = null,
    Object? message = null,
    Object? messageId = null,
  }) {
    return _then(_$ReplyMessageImpl(
      context: null == context
          ? _value.context
          : context // ignore: cast_nullable_to_non_nullable
              as BuildContext,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      messageId: null == messageId
          ? _value.messageId
          : messageId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$ReplyMessageImpl implements ReplyMessage {
  const _$ReplyMessageImpl(
      {required this.context, required this.message, required this.messageId});

  @override
  final BuildContext context;
  @override
  final String message;
  @override
  final String messageId;

  @override
  String toString() {
    return 'AiChatEvent.replyMessage(context: $context, message: $message, messageId: $messageId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ReplyMessageImpl &&
            (identical(other.context, context) || other.context == context) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.messageId, messageId) ||
                other.messageId == messageId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, context, message, messageId);

  /// Create a copy of AiChatEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ReplyMessageImplCopyWith<_$ReplyMessageImpl> get copyWith =>
      __$$ReplyMessageImplCopyWithImpl<_$ReplyMessageImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(BuildContext context, int? sellerId) checkChatId,
    required TResult Function(BuildContext context, String file) sendImage,
    required TResult Function(
            BuildContext context, String message, ProductData? product)
        sendMessage,
    required TResult Function(
            BuildContext context, String message, String messageId)
        editMessage,
    required TResult Function(
            BuildContext context, String message, String messageId)
        replyMessage,
    required TResult Function(BuildContext context, String messageId)
        deleteMessage,
    required TResult Function(BuildContext context, String message, int? userId,
            Function onSuccess)
        createAndSendMessage,
    required TResult Function(BuildContext context, bool? isRefresh,
            RefreshController? controller)
        getChatList,
  }) {
    return replyMessage(context, message, messageId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(BuildContext context, int? sellerId)? checkChatId,
    TResult? Function(BuildContext context, String file)? sendImage,
    TResult? Function(
            BuildContext context, String message, ProductData? product)?
        sendMessage,
    TResult? Function(BuildContext context, String message, String messageId)?
        editMessage,
    TResult? Function(BuildContext context, String message, String messageId)?
        replyMessage,
    TResult? Function(BuildContext context, String messageId)? deleteMessage,
    TResult? Function(BuildContext context, String message, int? userId,
            Function onSuccess)?
        createAndSendMessage,
    TResult? Function(BuildContext context, bool? isRefresh,
            RefreshController? controller)?
        getChatList,
  }) {
    return replyMessage?.call(context, message, messageId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(BuildContext context, int? sellerId)? checkChatId,
    TResult Function(BuildContext context, String file)? sendImage,
    TResult Function(
            BuildContext context, String message, ProductData? product)?
        sendMessage,
    TResult Function(BuildContext context, String message, String messageId)?
        editMessage,
    TResult Function(BuildContext context, String message, String messageId)?
        replyMessage,
    TResult Function(BuildContext context, String messageId)? deleteMessage,
    TResult Function(BuildContext context, String message, int? userId,
            Function onSuccess)?
        createAndSendMessage,
    TResult Function(BuildContext context, bool? isRefresh,
            RefreshController? controller)?
        getChatList,
    required TResult orElse(),
  }) {
    if (replyMessage != null) {
      return replyMessage(context, message, messageId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CheckChatId value) checkChatId,
    required TResult Function(SendImage value) sendImage,
    required TResult Function(SendMessage value) sendMessage,
    required TResult Function(EditMessage value) editMessage,
    required TResult Function(ReplyMessage value) replyMessage,
    required TResult Function(DeleteMessage value) deleteMessage,
    required TResult Function(CreateAndSendMessage value) createAndSendMessage,
    required TResult Function(GetChatList value) getChatList,
  }) {
    return replyMessage(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CheckChatId value)? checkChatId,
    TResult? Function(SendImage value)? sendImage,
    TResult? Function(SendMessage value)? sendMessage,
    TResult? Function(EditMessage value)? editMessage,
    TResult? Function(ReplyMessage value)? replyMessage,
    TResult? Function(DeleteMessage value)? deleteMessage,
    TResult? Function(CreateAndSendMessage value)? createAndSendMessage,
    TResult? Function(GetChatList value)? getChatList,
  }) {
    return replyMessage?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CheckChatId value)? checkChatId,
    TResult Function(SendImage value)? sendImage,
    TResult Function(SendMessage value)? sendMessage,
    TResult Function(EditMessage value)? editMessage,
    TResult Function(ReplyMessage value)? replyMessage,
    TResult Function(DeleteMessage value)? deleteMessage,
    TResult Function(CreateAndSendMessage value)? createAndSendMessage,
    TResult Function(GetChatList value)? getChatList,
    required TResult orElse(),
  }) {
    if (replyMessage != null) {
      return replyMessage(this);
    }
    return orElse();
  }
}

abstract class ReplyMessage implements AiChatEvent {
  const factory ReplyMessage(
      {required final BuildContext context,
      required final String message,
      required final String messageId}) = _$ReplyMessageImpl;

  @override
  BuildContext get context;
  String get message;
  String get messageId;

  /// Create a copy of AiChatEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ReplyMessageImplCopyWith<_$ReplyMessageImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$DeleteMessageImplCopyWith<$Res>
    implements $AiChatEventCopyWith<$Res> {
  factory _$$DeleteMessageImplCopyWith(
          _$DeleteMessageImpl value, $Res Function(_$DeleteMessageImpl) then) =
      __$$DeleteMessageImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({BuildContext context, String messageId});
}

/// @nodoc
class __$$DeleteMessageImplCopyWithImpl<$Res>
    extends _$AiChatEventCopyWithImpl<$Res, _$DeleteMessageImpl>
    implements _$$DeleteMessageImplCopyWith<$Res> {
  __$$DeleteMessageImplCopyWithImpl(
      _$DeleteMessageImpl _value, $Res Function(_$DeleteMessageImpl) _then)
      : super(_value, _then);

  /// Create a copy of AiChatEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? context = null,
    Object? messageId = null,
  }) {
    return _then(_$DeleteMessageImpl(
      context: null == context
          ? _value.context
          : context // ignore: cast_nullable_to_non_nullable
              as BuildContext,
      messageId: null == messageId
          ? _value.messageId
          : messageId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$DeleteMessageImpl implements DeleteMessage {
  const _$DeleteMessageImpl({required this.context, required this.messageId});

  @override
  final BuildContext context;
  @override
  final String messageId;

  @override
  String toString() {
    return 'AiChatEvent.deleteMessage(context: $context, messageId: $messageId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DeleteMessageImpl &&
            (identical(other.context, context) || other.context == context) &&
            (identical(other.messageId, messageId) ||
                other.messageId == messageId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, context, messageId);

  /// Create a copy of AiChatEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DeleteMessageImplCopyWith<_$DeleteMessageImpl> get copyWith =>
      __$$DeleteMessageImplCopyWithImpl<_$DeleteMessageImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(BuildContext context, int? sellerId) checkChatId,
    required TResult Function(BuildContext context, String file) sendImage,
    required TResult Function(
            BuildContext context, String message, ProductData? product)
        sendMessage,
    required TResult Function(
            BuildContext context, String message, String messageId)
        editMessage,
    required TResult Function(
            BuildContext context, String message, String messageId)
        replyMessage,
    required TResult Function(BuildContext context, String messageId)
        deleteMessage,
    required TResult Function(BuildContext context, String message, int? userId,
            Function onSuccess)
        createAndSendMessage,
    required TResult Function(BuildContext context, bool? isRefresh,
            RefreshController? controller)
        getChatList,
  }) {
    return deleteMessage(context, messageId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(BuildContext context, int? sellerId)? checkChatId,
    TResult? Function(BuildContext context, String file)? sendImage,
    TResult? Function(
            BuildContext context, String message, ProductData? product)?
        sendMessage,
    TResult? Function(BuildContext context, String message, String messageId)?
        editMessage,
    TResult? Function(BuildContext context, String message, String messageId)?
        replyMessage,
    TResult? Function(BuildContext context, String messageId)? deleteMessage,
    TResult? Function(BuildContext context, String message, int? userId,
            Function onSuccess)?
        createAndSendMessage,
    TResult? Function(BuildContext context, bool? isRefresh,
            RefreshController? controller)?
        getChatList,
  }) {
    return deleteMessage?.call(context, messageId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(BuildContext context, int? sellerId)? checkChatId,
    TResult Function(BuildContext context, String file)? sendImage,
    TResult Function(
            BuildContext context, String message, ProductData? product)?
        sendMessage,
    TResult Function(BuildContext context, String message, String messageId)?
        editMessage,
    TResult Function(BuildContext context, String message, String messageId)?
        replyMessage,
    TResult Function(BuildContext context, String messageId)? deleteMessage,
    TResult Function(BuildContext context, String message, int? userId,
            Function onSuccess)?
        createAndSendMessage,
    TResult Function(BuildContext context, bool? isRefresh,
            RefreshController? controller)?
        getChatList,
    required TResult orElse(),
  }) {
    if (deleteMessage != null) {
      return deleteMessage(context, messageId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CheckChatId value) checkChatId,
    required TResult Function(SendImage value) sendImage,
    required TResult Function(SendMessage value) sendMessage,
    required TResult Function(EditMessage value) editMessage,
    required TResult Function(ReplyMessage value) replyMessage,
    required TResult Function(DeleteMessage value) deleteMessage,
    required TResult Function(CreateAndSendMessage value) createAndSendMessage,
    required TResult Function(GetChatList value) getChatList,
  }) {
    return deleteMessage(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CheckChatId value)? checkChatId,
    TResult? Function(SendImage value)? sendImage,
    TResult? Function(SendMessage value)? sendMessage,
    TResult? Function(EditMessage value)? editMessage,
    TResult? Function(ReplyMessage value)? replyMessage,
    TResult? Function(DeleteMessage value)? deleteMessage,
    TResult? Function(CreateAndSendMessage value)? createAndSendMessage,
    TResult? Function(GetChatList value)? getChatList,
  }) {
    return deleteMessage?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CheckChatId value)? checkChatId,
    TResult Function(SendImage value)? sendImage,
    TResult Function(SendMessage value)? sendMessage,
    TResult Function(EditMessage value)? editMessage,
    TResult Function(ReplyMessage value)? replyMessage,
    TResult Function(DeleteMessage value)? deleteMessage,
    TResult Function(CreateAndSendMessage value)? createAndSendMessage,
    TResult Function(GetChatList value)? getChatList,
    required TResult orElse(),
  }) {
    if (deleteMessage != null) {
      return deleteMessage(this);
    }
    return orElse();
  }
}

abstract class DeleteMessage implements AiChatEvent {
  const factory DeleteMessage(
      {required final BuildContext context,
      required final String messageId}) = _$DeleteMessageImpl;

  @override
  BuildContext get context;
  String get messageId;

  /// Create a copy of AiChatEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DeleteMessageImplCopyWith<_$DeleteMessageImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$CreateAndSendMessageImplCopyWith<$Res>
    implements $AiChatEventCopyWith<$Res> {
  factory _$$CreateAndSendMessageImplCopyWith(_$CreateAndSendMessageImpl value,
          $Res Function(_$CreateAndSendMessageImpl) then) =
      __$$CreateAndSendMessageImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {BuildContext context, String message, int? userId, Function onSuccess});
}

/// @nodoc
class __$$CreateAndSendMessageImplCopyWithImpl<$Res>
    extends _$AiChatEventCopyWithImpl<$Res, _$CreateAndSendMessageImpl>
    implements _$$CreateAndSendMessageImplCopyWith<$Res> {
  __$$CreateAndSendMessageImplCopyWithImpl(_$CreateAndSendMessageImpl _value,
      $Res Function(_$CreateAndSendMessageImpl) _then)
      : super(_value, _then);

  /// Create a copy of AiChatEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? context = null,
    Object? message = null,
    Object? userId = freezed,
    Object? onSuccess = null,
  }) {
    return _then(_$CreateAndSendMessageImpl(
      context: null == context
          ? _value.context
          : context // ignore: cast_nullable_to_non_nullable
              as BuildContext,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      userId: freezed == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as int?,
      onSuccess: null == onSuccess
          ? _value.onSuccess
          : onSuccess // ignore: cast_nullable_to_non_nullable
              as Function,
    ));
  }
}

/// @nodoc

class _$CreateAndSendMessageImpl implements CreateAndSendMessage {
  const _$CreateAndSendMessageImpl(
      {required this.context,
      required this.message,
      required this.userId,
      required this.onSuccess});

  @override
  final BuildContext context;
  @override
  final String message;
  @override
  final int? userId;
  @override
  final Function onSuccess;

  @override
  String toString() {
    return 'AiChatEvent.createAndSendMessage(context: $context, message: $message, userId: $userId, onSuccess: $onSuccess)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CreateAndSendMessageImpl &&
            (identical(other.context, context) || other.context == context) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.onSuccess, onSuccess) ||
                other.onSuccess == onSuccess));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, context, message, userId, onSuccess);

  /// Create a copy of AiChatEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CreateAndSendMessageImplCopyWith<_$CreateAndSendMessageImpl>
      get copyWith =>
          __$$CreateAndSendMessageImplCopyWithImpl<_$CreateAndSendMessageImpl>(
              this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(BuildContext context, int? sellerId) checkChatId,
    required TResult Function(BuildContext context, String file) sendImage,
    required TResult Function(
            BuildContext context, String message, ProductData? product)
        sendMessage,
    required TResult Function(
            BuildContext context, String message, String messageId)
        editMessage,
    required TResult Function(
            BuildContext context, String message, String messageId)
        replyMessage,
    required TResult Function(BuildContext context, String messageId)
        deleteMessage,
    required TResult Function(BuildContext context, String message, int? userId,
            Function onSuccess)
        createAndSendMessage,
    required TResult Function(BuildContext context, bool? isRefresh,
            RefreshController? controller)
        getChatList,
  }) {
    return createAndSendMessage(context, message, userId, onSuccess);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(BuildContext context, int? sellerId)? checkChatId,
    TResult? Function(BuildContext context, String file)? sendImage,
    TResult? Function(
            BuildContext context, String message, ProductData? product)?
        sendMessage,
    TResult? Function(BuildContext context, String message, String messageId)?
        editMessage,
    TResult? Function(BuildContext context, String message, String messageId)?
        replyMessage,
    TResult? Function(BuildContext context, String messageId)? deleteMessage,
    TResult? Function(BuildContext context, String message, int? userId,
            Function onSuccess)?
        createAndSendMessage,
    TResult? Function(BuildContext context, bool? isRefresh,
            RefreshController? controller)?
        getChatList,
  }) {
    return createAndSendMessage?.call(context, message, userId, onSuccess);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(BuildContext context, int? sellerId)? checkChatId,
    TResult Function(BuildContext context, String file)? sendImage,
    TResult Function(
            BuildContext context, String message, ProductData? product)?
        sendMessage,
    TResult Function(BuildContext context, String message, String messageId)?
        editMessage,
    TResult Function(BuildContext context, String message, String messageId)?
        replyMessage,
    TResult Function(BuildContext context, String messageId)? deleteMessage,
    TResult Function(BuildContext context, String message, int? userId,
            Function onSuccess)?
        createAndSendMessage,
    TResult Function(BuildContext context, bool? isRefresh,
            RefreshController? controller)?
        getChatList,
    required TResult orElse(),
  }) {
    if (createAndSendMessage != null) {
      return createAndSendMessage(context, message, userId, onSuccess);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CheckChatId value) checkChatId,
    required TResult Function(SendImage value) sendImage,
    required TResult Function(SendMessage value) sendMessage,
    required TResult Function(EditMessage value) editMessage,
    required TResult Function(ReplyMessage value) replyMessage,
    required TResult Function(DeleteMessage value) deleteMessage,
    required TResult Function(CreateAndSendMessage value) createAndSendMessage,
    required TResult Function(GetChatList value) getChatList,
  }) {
    return createAndSendMessage(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CheckChatId value)? checkChatId,
    TResult? Function(SendImage value)? sendImage,
    TResult? Function(SendMessage value)? sendMessage,
    TResult? Function(EditMessage value)? editMessage,
    TResult? Function(ReplyMessage value)? replyMessage,
    TResult? Function(DeleteMessage value)? deleteMessage,
    TResult? Function(CreateAndSendMessage value)? createAndSendMessage,
    TResult? Function(GetChatList value)? getChatList,
  }) {
    return createAndSendMessage?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CheckChatId value)? checkChatId,
    TResult Function(SendImage value)? sendImage,
    TResult Function(SendMessage value)? sendMessage,
    TResult Function(EditMessage value)? editMessage,
    TResult Function(ReplyMessage value)? replyMessage,
    TResult Function(DeleteMessage value)? deleteMessage,
    TResult Function(CreateAndSendMessage value)? createAndSendMessage,
    TResult Function(GetChatList value)? getChatList,
    required TResult orElse(),
  }) {
    if (createAndSendMessage != null) {
      return createAndSendMessage(this);
    }
    return orElse();
  }
}

abstract class CreateAndSendMessage implements AiChatEvent {
  const factory CreateAndSendMessage(
      {required final BuildContext context,
      required final String message,
      required final int? userId,
      required final Function onSuccess}) = _$CreateAndSendMessageImpl;

  @override
  BuildContext get context;
  String get message;
  int? get userId;
  Function get onSuccess;

  /// Create a copy of AiChatEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CreateAndSendMessageImplCopyWith<_$CreateAndSendMessageImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$GetChatListImplCopyWith<$Res>
    implements $AiChatEventCopyWith<$Res> {
  factory _$$GetChatListImplCopyWith(
          _$GetChatListImpl value, $Res Function(_$GetChatListImpl) then) =
      __$$GetChatListImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {BuildContext context, bool? isRefresh, RefreshController? controller});
}

/// @nodoc
class __$$GetChatListImplCopyWithImpl<$Res>
    extends _$AiChatEventCopyWithImpl<$Res, _$GetChatListImpl>
    implements _$$GetChatListImplCopyWith<$Res> {
  __$$GetChatListImplCopyWithImpl(
      _$GetChatListImpl _value, $Res Function(_$GetChatListImpl) _then)
      : super(_value, _then);

  /// Create a copy of AiChatEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? context = null,
    Object? isRefresh = freezed,
    Object? controller = freezed,
  }) {
    return _then(_$GetChatListImpl(
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

class _$GetChatListImpl implements GetChatList {
  const _$GetChatListImpl(
      {required this.context, this.isRefresh, this.controller});

  @override
  final BuildContext context;
  @override
  final bool? isRefresh;
  @override
  final RefreshController? controller;

  @override
  String toString() {
    return 'AiChatEvent.getChatList(context: $context, isRefresh: $isRefresh, controller: $controller)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GetChatListImpl &&
            (identical(other.context, context) || other.context == context) &&
            (identical(other.isRefresh, isRefresh) ||
                other.isRefresh == isRefresh) &&
            (identical(other.controller, controller) ||
                other.controller == controller));
  }

  @override
  int get hashCode => Object.hash(runtimeType, context, isRefresh, controller);

  /// Create a copy of AiChatEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GetChatListImplCopyWith<_$GetChatListImpl> get copyWith =>
      __$$GetChatListImplCopyWithImpl<_$GetChatListImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(BuildContext context, int? sellerId) checkChatId,
    required TResult Function(BuildContext context, String file) sendImage,
    required TResult Function(
            BuildContext context, String message, ProductData? product)
        sendMessage,
    required TResult Function(
            BuildContext context, String message, String messageId)
        editMessage,
    required TResult Function(
            BuildContext context, String message, String messageId)
        replyMessage,
    required TResult Function(BuildContext context, String messageId)
        deleteMessage,
    required TResult Function(BuildContext context, String message, int? userId,
            Function onSuccess)
        createAndSendMessage,
    required TResult Function(BuildContext context, bool? isRefresh,
            RefreshController? controller)
        getChatList,
  }) {
    return getChatList(context, isRefresh, controller);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(BuildContext context, int? sellerId)? checkChatId,
    TResult? Function(BuildContext context, String file)? sendImage,
    TResult? Function(
            BuildContext context, String message, ProductData? product)?
        sendMessage,
    TResult? Function(BuildContext context, String message, String messageId)?
        editMessage,
    TResult? Function(BuildContext context, String message, String messageId)?
        replyMessage,
    TResult? Function(BuildContext context, String messageId)? deleteMessage,
    TResult? Function(BuildContext context, String message, int? userId,
            Function onSuccess)?
        createAndSendMessage,
    TResult? Function(BuildContext context, bool? isRefresh,
            RefreshController? controller)?
        getChatList,
  }) {
    return getChatList?.call(context, isRefresh, controller);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(BuildContext context, int? sellerId)? checkChatId,
    TResult Function(BuildContext context, String file)? sendImage,
    TResult Function(
            BuildContext context, String message, ProductData? product)?
        sendMessage,
    TResult Function(BuildContext context, String message, String messageId)?
        editMessage,
    TResult Function(BuildContext context, String message, String messageId)?
        replyMessage,
    TResult Function(BuildContext context, String messageId)? deleteMessage,
    TResult Function(BuildContext context, String message, int? userId,
            Function onSuccess)?
        createAndSendMessage,
    TResult Function(BuildContext context, bool? isRefresh,
            RefreshController? controller)?
        getChatList,
    required TResult orElse(),
  }) {
    if (getChatList != null) {
      return getChatList(context, isRefresh, controller);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CheckChatId value) checkChatId,
    required TResult Function(SendImage value) sendImage,
    required TResult Function(SendMessage value) sendMessage,
    required TResult Function(EditMessage value) editMessage,
    required TResult Function(ReplyMessage value) replyMessage,
    required TResult Function(DeleteMessage value) deleteMessage,
    required TResult Function(CreateAndSendMessage value) createAndSendMessage,
    required TResult Function(GetChatList value) getChatList,
  }) {
    return getChatList(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CheckChatId value)? checkChatId,
    TResult? Function(SendImage value)? sendImage,
    TResult? Function(SendMessage value)? sendMessage,
    TResult? Function(EditMessage value)? editMessage,
    TResult? Function(ReplyMessage value)? replyMessage,
    TResult? Function(DeleteMessage value)? deleteMessage,
    TResult? Function(CreateAndSendMessage value)? createAndSendMessage,
    TResult? Function(GetChatList value)? getChatList,
  }) {
    return getChatList?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CheckChatId value)? checkChatId,
    TResult Function(SendImage value)? sendImage,
    TResult Function(SendMessage value)? sendMessage,
    TResult Function(EditMessage value)? editMessage,
    TResult Function(ReplyMessage value)? replyMessage,
    TResult Function(DeleteMessage value)? deleteMessage,
    TResult Function(CreateAndSendMessage value)? createAndSendMessage,
    TResult Function(GetChatList value)? getChatList,
    required TResult orElse(),
  }) {
    if (getChatList != null) {
      return getChatList(this);
    }
    return orElse();
  }
}

abstract class GetChatList implements AiChatEvent {
  const factory GetChatList(
      {required final BuildContext context,
      final bool? isRefresh,
      final RefreshController? controller}) = _$GetChatListImpl;

  @override
  BuildContext get context;
  bool? get isRefresh;
  RefreshController? get controller;

  /// Create a copy of AiChatEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GetChatListImplCopyWith<_$GetChatListImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$AiChatState {
  bool get isLoading => throw _privateConstructorUsedError;
  bool get isButtonLoading => throw _privateConstructorUsedError;
  bool get isMessageLoading => throw _privateConstructorUsedError;
  ChatModel? get chatModel => throw _privateConstructorUsedError;
  List<ChatModel> get chatList => throw _privateConstructorUsedError;

  /// Create a copy of AiChatState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AiChatStateCopyWith<AiChatState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AiChatStateCopyWith<$Res> {
  factory $AiChatStateCopyWith(
          AiChatState value, $Res Function(AiChatState) then) =
      _$AiChatStateCopyWithImpl<$Res, AiChatState>;
  @useResult
  $Res call(
      {bool isLoading,
      bool isButtonLoading,
      bool isMessageLoading,
      ChatModel? chatModel,
      List<ChatModel> chatList});
}

/// @nodoc
class _$AiChatStateCopyWithImpl<$Res, $Val extends AiChatState>
    implements $AiChatStateCopyWith<$Res> {
  _$AiChatStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AiChatState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? isButtonLoading = null,
    Object? isMessageLoading = null,
    Object? chatModel = freezed,
    Object? chatList = null,
  }) {
    return _then(_value.copyWith(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isButtonLoading: null == isButtonLoading
          ? _value.isButtonLoading
          : isButtonLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isMessageLoading: null == isMessageLoading
          ? _value.isMessageLoading
          : isMessageLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      chatModel: freezed == chatModel
          ? _value.chatModel
          : chatModel // ignore: cast_nullable_to_non_nullable
              as ChatModel?,
      chatList: null == chatList
          ? _value.chatList
          : chatList // ignore: cast_nullable_to_non_nullable
              as List<ChatModel>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AiChatStateImplCopyWith<$Res>
    implements $AiChatStateCopyWith<$Res> {
  factory _$$AiChatStateImplCopyWith(
          _$AiChatStateImpl value, $Res Function(_$AiChatStateImpl) then) =
      __$$AiChatStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool isLoading,
      bool isButtonLoading,
      bool isMessageLoading,
      ChatModel? chatModel,
      List<ChatModel> chatList});
}

/// @nodoc
class __$$AiChatStateImplCopyWithImpl<$Res>
    extends _$AiChatStateCopyWithImpl<$Res, _$AiChatStateImpl>
    implements _$$AiChatStateImplCopyWith<$Res> {
  __$$AiChatStateImplCopyWithImpl(
      _$AiChatStateImpl _value, $Res Function(_$AiChatStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of AiChatState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? isButtonLoading = null,
    Object? isMessageLoading = null,
    Object? chatModel = freezed,
    Object? chatList = null,
  }) {
    return _then(_$AiChatStateImpl(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isButtonLoading: null == isButtonLoading
          ? _value.isButtonLoading
          : isButtonLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isMessageLoading: null == isMessageLoading
          ? _value.isMessageLoading
          : isMessageLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      chatModel: freezed == chatModel
          ? _value.chatModel
          : chatModel // ignore: cast_nullable_to_non_nullable
              as ChatModel?,
      chatList: null == chatList
          ? _value._chatList
          : chatList // ignore: cast_nullable_to_non_nullable
              as List<ChatModel>,
    ));
  }
}

/// @nodoc

class _$AiChatStateImpl implements _AiChatState {
  const _$AiChatStateImpl(
      {this.isLoading = true,
      this.isButtonLoading = false,
      this.isMessageLoading = true,
      this.chatModel = null,
      final List<ChatModel> chatList = const []})
      : _chatList = chatList;

  @override
  @JsonKey()
  final bool isLoading;
  @override
  @JsonKey()
  final bool isButtonLoading;
  @override
  @JsonKey()
  final bool isMessageLoading;
  @override
  @JsonKey()
  final ChatModel? chatModel;
  final List<ChatModel> _chatList;
  @override
  @JsonKey()
  List<ChatModel> get chatList {
    if (_chatList is EqualUnmodifiableListView) return _chatList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_chatList);
  }

  @override
  String toString() {
    return 'AiChatState(isLoading: $isLoading, isButtonLoading: $isButtonLoading, isMessageLoading: $isMessageLoading, chatModel: $chatModel, chatList: $chatList)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AiChatStateImpl &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.isButtonLoading, isButtonLoading) ||
                other.isButtonLoading == isButtonLoading) &&
            (identical(other.isMessageLoading, isMessageLoading) ||
                other.isMessageLoading == isMessageLoading) &&
            (identical(other.chatModel, chatModel) ||
                other.chatModel == chatModel) &&
            const DeepCollectionEquality().equals(other._chatList, _chatList));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      isLoading,
      isButtonLoading,
      isMessageLoading,
      chatModel,
      const DeepCollectionEquality().hash(_chatList));

  /// Create a copy of AiChatState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AiChatStateImplCopyWith<_$AiChatStateImpl> get copyWith =>
      __$$AiChatStateImplCopyWithImpl<_$AiChatStateImpl>(this, _$identity);
}

abstract class _AiChatState implements AiChatState {
  const factory _AiChatState(
      {final bool isLoading,
      final bool isButtonLoading,
      final bool isMessageLoading,
      final ChatModel? chatModel,
      final List<ChatModel> chatList}) = _$AiChatStateImpl;

  @override
  bool get isLoading;
  @override
  bool get isButtonLoading;
  @override
  bool get isMessageLoading;
  @override
  ChatModel? get chatModel;
  @override
  List<ChatModel> get chatList;

  /// Create a copy of AiChatState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AiChatStateImplCopyWith<_$AiChatStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
