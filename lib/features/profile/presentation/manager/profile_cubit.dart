import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_app/constants.dart';
import 'package:instagram_app/features/auth/models/user_model.dart';
import 'package:instagram_app/features/profile/domain/repos/profile_repo.dart';
import 'package:instagram_app/features/profile/domain/use_cases/profile_use_case.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(this.profileRepo, this.profileUseCase) : super(ProfileInitial());
  final ProfileRepo profileRepo;
  final ProfileUseCase profileUseCase;
  final nameController = TextEditingController();
  final bioController = TextEditingController();

  static ProfileCubit get(context) => BlocProvider.of(context);

  Future<void> updateUserNameAndBio(
      {String? name, String? bio, required UserModel userModel}) async {
    emit(UpdateUserLoading());
    var result = await profileRepo.updateUserNameAndBio(
      name: name,
      bio: bio,
      userModel: userModel,
    );
    result.fold((failure) => emit(UpdateUserFailure(failure.message)),
        (userModel) => emit(UpdateUserSuccess()));
  }

  Future<void> pickProfilePhoto() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      emit(PickProfilePhotoSuccess(pickedFile.path));
    }
  }

  Future<void> pickCoverPhoto() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      emit(PickCoverPhotoSuccess(pickedFile.path));
    }
  }

  Future<void> uploadProfilePhoto({
    required String path,
    required String uId,
  }) async {
    emit(UploadProfilePhotoLoading());
    var result = await profileUseCase.call(
      path,
      uId,
      kProfileImage,
    );
    result.fold((failure) => emit(UploadProfilePhotoFailure(failure.message)),
        (fileUrl) => emit(UploadProfilePhotoSuccess()));
  }

  Future<void> uploadCoverPhoto({
    required String path,
    required String uId,
  }) async {
    emit(UploadCoverPhotoLoading());
    var result = await profileUseCase.call(
      path,
      uId,
      kCoverImage,
    );
    result.fold((failure) => emit(UploadCoverPhotoFailure(failure.message)),
        (fileUrl) => emit(UploadCoverPhotoSuccess()));
  }

  disposeControllers() {
    nameController.dispose();
    bioController.dispose();
  }
}
