import 'package:super_fitness_app/features/edit-profile/data/models/edit_profile_response.dart';

abstract class EditProfileState {}

class EditProfileInitial extends EditProfileState {}

class EditProfileLoading extends EditProfileState {}

class EditProfileSuccess extends EditProfileState {
  final EditProfileResponse response;
  EditProfileSuccess(this.response);
}

class EditProfileError extends EditProfileState {
  final String message;
  EditProfileError(this.message);
}
