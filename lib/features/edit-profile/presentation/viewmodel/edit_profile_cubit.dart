import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:super_fitness_app/core/contants/secure_storage.dart';
import 'package:super_fitness_app/core/l10n/translation/app_localizations.dart';
import 'package:super_fitness_app/features/edit-profile/data/models/edit_profile_request.dart';
import 'package:super_fitness_app/features/edit-profile/data/repositories/edit_profile_repo_impl.dart';
import '../../../../core/common/widgets/custom_snackbar_widget.dart';
import '../../../../core/errors/api_result.dart';
import '../../../profile/domain/entity/user_entity.dart';
import '../../data/models/upload_photo_response.dart';
import 'edit_profile_states.dart';

@injectable
class EditProfileViewModel extends Cubit<EditProfileState> {
  final EditProfileRepository _repository;

  EditProfileViewModel(this._repository) : super(EditProfileInitial());

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  int selectedWeight = 0;
  String selectedGoal = "";
  String selectedActivity = "";
  String? profilePhotoUrl;

  static const _profilePhotoKey = "PROFILE_PHOTO_PATH";

  Future<void> loadUserDataFromProfile(UserEntity user) async {
    emit(EditProfileLoading());
    try {
      firstNameController.text = user.firstName;
      lastNameController.text = user.lastName;
      emailController.text = user.email;
      selectedWeight = user.weight;
      selectedGoal = user.goal;
      selectedActivity = user.activityLevel;

      profilePhotoUrl = await SecureStorage.read(_profilePhotoKey) ?? user.photo;

      emit(EditProfileLoaded());
    } catch (e) {
      emit(EditProfileError(e.toString()));
    }
  }

  Future<void> changeProfilePhoto() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile == null) return;

    emit(ProfilePhotoLoadingState());
    try {
      profilePhotoUrl = pickedFile.path;
      await SecureStorage.write(key: _profilePhotoKey, value: profilePhotoUrl!);
      emit(ProfilePhotoUpdatedState(profilePhotoUrl!));
    } catch (e) {
      emit(ProfilePhotoErrorState(message: e.toString()));
    }
  }

  Future<void> uploadPhoto(File file, BuildContext context) async {
    emit(ProfilePhotoLoadingState());
    try {
      final result = await _repository.uploadPhoto(file);

      if (result is ApiSuccessResult<UploadPhotoResponse>) {
        profilePhotoUrl = file.path;
        await SecureStorage.write(key: _profilePhotoKey, value: profilePhotoUrl!);
        emit(ProfilePhotoUpdatedState(profilePhotoUrl!));
        await showCustomSnackBar(context, AppLocalizations.of(context)!.uploadPhotoSuccess, isError: false);
      } else if (result is ApiErrorResult<UploadPhotoResponse>) {
        emit(ProfilePhotoErrorState(message: result.errorMessage));
        await showCustomSnackBar(context, result.errorMessage, isError: true);
      } else {
        emit(ProfilePhotoErrorState(message: 'Unexpected error occurred'));
        await showCustomSnackBar(context, 'Unexpected error occurred', isError: true);
      }
    } catch (e) {
      emit(ProfilePhotoErrorState(message: e.toString()));
      await showCustomSnackBar(context, e.toString(), isError: true);
    }
  }

  Future<void> submitProfile(BuildContext context) async {
    emit(EditProfileLoading());

    final request = EditProfileRequest(
      firstName: firstNameController.text,
      lastName: lastNameController.text,
      email: emailController.text,
      weight: selectedWeight,
      goal: selectedGoal,
      activityLevel: selectedActivity,
    );

    try {
      final response = await _repository.editProfile(request);
      emit(EditProfileSuccess(response));
      await showCustomSnackBar(
        context,
        AppLocalizations.of(context)!.profileUpdatedSuccess,
        isError: false,
      );
    } catch (e) {
      emit(EditProfileError(e.toString()));
      await showCustomSnackBar(
        context,
        e.toString(),
        isError: true,
      );
    }
  }

  @override
  Future<void> close() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    return super.close();
  }
}
