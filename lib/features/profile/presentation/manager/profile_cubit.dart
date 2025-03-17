import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_app/constants.dart';
import 'package:instagram_app/core/functions/hive_functions.dart';
import 'package:instagram_app/features/auth/models/user_model.dart';
import 'package:instagram_app/features/auth/user_model_extensions.dart';
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

  Future<void> updateUserNameAndBio({required UserModel userModel}) async {
    emit(UpdateUserLoading());
    var result = await profileRepo.updateUserProfile(
      name: nameController.text,
      bio: bioController.text,
      userModel: userModel,
    );

    result.fold((failure) => emit(UpdateUserFailure(failure.message)), (_) {
      HiveFunctions.updaterUserNameAndBio(
        name: nameController.text,
        bio: bioController.text,
      );
      emit(UpdateUserSuccess());
    });
  }

  String? profileImagePath;

  Future<void> pickProfilePhoto() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      profileImagePath = pickedFile.path;
      emit(PickProfilePhotoSuccess(pickedFile.path));
    }
  }

  String? coverImagePath;

  Future<void> pickCoverPhoto() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      coverImagePath = pickedFile.path;
      emit(PickCoverPhotoSuccess(pickedFile.path));
    }
  }

  Future<void> uploadProfilePhoto({
    required String path,
    required UserModel userModel,
  }) async {
    emit(UploadProfilePhotoLoading());
    var result = await profileUseCase.call(
      path,
      userModel.uId,
      kProfileImage,
    );
    result.fold((failure) => emit(UploadProfilePhotoFailure(failure.message)),
        (fileUrl) {
      emit(UploadProfilePhotoSuccess(profileImageUrl: fileUrl));
    });
  }

  Future<void> uploadCoverPhoto({
    required String path,
    required UserModel userModel,
  }) async {
    emit(UploadCoverPhotoLoading());
    var result = await profileUseCase.call(
      path,
      userModel.uId,
      kCoverImage,
    );
    result.fold((failure) => emit(UploadCoverPhotoFailure(failure.message)),
        (fileUrl) async {
      await HiveFunctions.updateUser(
          userModel.copyWith(coverImageUrl: fileUrl));
      emit(UploadCoverPhotoSuccess());
    });
  }

  disposeControllers() {
    nameController.dispose();
    bioController.dispose();
  }
}
