import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:super_fitness_app/core/contants/secure_storage.dart';
import 'package:super_fitness_app/features/edit-profile/data/models/edit_profile_request.dart';
import 'package:super_fitness_app/features/edit-profile/data/repositories/edit_profile_repo_impl.dart';

import '../../../../core/common/widgets/custom_snackbar_widget.dart';
import '../../../profile/domain/entity/user_entity.dart';
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

  Future<void> loadUserDataFromProfile(UserEntity user) async {
    emit(EditProfileLoading());
    try {
      firstNameController.text = user.firstName ?? "";
      lastNameController.text = user.lastName ?? "";
      emailController.text = user.email ?? "";
      selectedWeight = user.weight ?? 0;
      selectedGoal = user.goal ?? "";
      selectedActivity = user.activityLevel ?? "";

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
      emit(ProfilePhotoUpdatedState(profilePhotoUrl!));
    } catch (e) {
      emit(ProfilePhotoErrorState(message: e.toString()));
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
      await showCustomSnackBar(context, "Profile updated successfully", isError: false);
    } catch (e) {
      emit(EditProfileError(e.toString()));
      await showCustomSnackBar(context, e.toString(), isError: true);
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
