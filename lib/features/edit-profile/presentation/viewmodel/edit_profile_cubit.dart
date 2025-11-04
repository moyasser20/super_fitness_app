import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:super_fitness_app/features/edit-profile/data/models/edit_profile_request.dart';
import '../../data/repositories/edit_profile_repo_impl.dart';
import 'edit_profile_states.dart';

@injectable
class EditProfileCubit extends Cubit<EditProfileState> {
  final EditProfileRepository _repository;

  EditProfileCubit(this._repository) : super(EditProfileInitial());

  Future<void> editProfile(EditProfileRequest request) async {
    try {
      emit(EditProfileLoading());
      final result = await _repository.editProfile(request);
      emit(EditProfileSuccess(result));
    } catch (error) {
      emit(EditProfileError(error.toString()));
    }
  }
}
