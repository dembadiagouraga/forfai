import 'package:flutter/cupertino.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:bloc/bloc.dart';
import 'package:quick/domain/di/dependency_manager.dart';
import 'package:quick/domain/model/model/referral_model.dart';
import 'package:quick/domain/model/model/translation_model.dart';
import 'package:quick/domain/model/model/update_profile_model.dart';
import 'package:quick/domain/model/response/help_response.dart';
import 'package:quick/domain/model/response/languages_response.dart';
import 'package:quick/infrastructure/service/services.dart';
import 'package:quick/infrastructure/local_storage/local_storage.dart';

part 'profile_event.dart';

part 'profile_state.dart';

part 'profile_bloc.freezed.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  int all = 0;

  ProfileBloc() : super(const ProfileState()) {
    on<UpdateImagePath>(updateImagePath);

    on<ShowPassword>(showPassword);

    on<ShowConfirmPassword>(showConfirmPassword);

    on<FetchProfile>(fetchProfile);

    on<UpdateUser>(updateUser);

    on<UpdatePassword>(updatePassword);

    on<GetLanguage>(getLanguage);

    on<FetchReferral>(fetchReferral);

    on<GetHelps>(getHelps);

    on<UpdateLan>(updateLan);

    on<GetPolicy>(getPolicy);

    on<GetTerm>(getTerm);

    on<ChangeLoad>(changeLoad);
  }

  updateImagePath(event, emit) {
    emit(state.copyWith(imagePath: event.imagePath));
  }

  showPassword(event, emit) {
    emit(state.copyWith(showNewPassword: !state.showNewPassword));
  }

  showConfirmPassword(event, emit) {
    emit(state.copyWith(showConfirmPassword: !state.showConfirmPassword));
  }

  fetchProfile(event, emit) async {
    emit(state.copyWith(isLoading: true));
    await userRepository.getProfileDetails(event.context);
    emit(state.copyWith(isLoading: false));
  }

  updateUser(event, emit) async {
    emit(state.copyWith(isLoading: true));
    String? imageUrl;
    if (state.imagePath != null) {
      final res = await galleryRepository.uploadImage(
          state.imagePath ?? "", UploadType.users);
      res.fold(
          (l) => imageUrl = l.imageData?.title,
          (r) => AppHelpers.errorSnackBar(
              context: event.context, message: r.toString()));
    }
    final res = await userRepository.updateProfile(
        updateProfile: UpdateProfileModel(
            firstName: event.firstName,
            lastName: event.lastName,
            imageUrl: imageUrl,
            phone: event.phone,
            email: event.email));

    res.fold(
      (l) {
        LocalStorage.setUser(l.data);
        emit(state.copyWith(isLoading: false));
        event.onSuccess?.call();
      },
      (r) {
        AppHelpers.errorSnackBar(
          context: event.context,
          message: r.toString(),
        );
        emit(state.copyWith(isLoading: false));
      },
    );
  }

  updatePassword(event, emit) async {
    emit(state.copyWith(isPasswordLoading: true));

    final res = await userRepository.updatePassword(
      password: event.newPassword,
      passwordConfirmation: event.confirmPassword,
    );

    res.fold((l) {
      emit(state.copyWith(isPasswordLoading: false));
      event.onSuccess?.call();
    }, (r) {
      emit(state.copyWith(isPasswordLoading: false));
      AppHelpers.errorSnackBar(context: event.context, message: r.toString());
    });
  }

  getLanguage(event, emit) async {
    emit(state.copyWith(isLanguage: state.languages.isEmpty));
    final res = await settingsRepository.getLanguages();
    res.fold(
      (l) {
        emit(state.copyWith(
          isLanguage: false,
          languages: l.data ?? [],
        ));
      },
      (r) {
        emit(state.copyWith(isLanguage: false));
        return AppHelpers.errorSnackBar(
          context: event.context,
          message: r.toString(),
        );
      },
    );
  }

  fetchReferral(event, emit) async {
    emit(state.copyWith(isReferralLoading: state.referralData == null));
    final res = await userRepository.getReferralDetails();
    res.fold(
      (l) {
        emit(state.copyWith(
          isReferralLoading: false,
          referralData: l,
        ));
      },
      (r) {
        emit(state.copyWith(isReferralLoading: false));
        return AppHelpers.errorSnackBar(
          context: event.context,
          message: r.toString(),
        );
      },
    );
  }

  getHelps(event, emit) async {
    emit(state.copyWith(isHelpLoading: state.helps.isEmpty));
    final res = await settingsRepository.getFaq();
    res.fold(
      (l) {
        emit(state.copyWith(
          isHelpLoading: false,
          helps: l.data ?? [],
        ));
      },
      (r) {
        emit(state.copyWith(isHelpLoading: false));
        return AppHelpers.errorSnackBar(
          context: event.context,
          message: r.toString(),
        );
      },
    );
  }

  updateLan(event, emit) async {
    emit(state.copyWith(isLoading: true));
    emit(state.copyWith(isLoading: false));
  }

  getPolicy(event, emit) async {
    emit(state.copyWith(isHelpLoading: state.policy == null));
    final res = await settingsRepository.getPolicy();
    res.fold(
      (l) {
        emit(state.copyWith(
          isHelpLoading: false,
          policy: l,
        ));
      },
      (r) {
        emit(state.copyWith(isHelpLoading: false));
        return AppHelpers.errorSnackBar(
          context: event.context,
          message: r.toString(),
        );
      },
    );
  }

  getTerm(event, emit) async {
    emit(state.copyWith(isHelpLoading: state.term == null));
    final res = await settingsRepository.getTerm();
    res.fold(
      (l) {
        emit(state.copyWith(
          isHelpLoading: false,
          term: l,
        ));
      },
      (r) {
        emit(state.copyWith(isHelpLoading: false));
        return AppHelpers.errorSnackBar(
          context: event.context,
          message: r.toString(),
        );
      },
    );
  }

  changeLoad(event, emit) {
    emit(state.copyWith(isLanguage: !state.isLanguage));
  }
}
