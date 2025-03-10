part of 'profile_cubit.dart';

@immutable
sealed class ProfileState {}

final class ProfileInitial extends ProfileState {}

final class UpdateUserLoading extends ProfileState {}

final class UpdateUserSuccess extends ProfileState {}

final class UpdateUserFailure extends ProfileState {
  final String errMessage;

  UpdateUserFailure(this.errMessage);
}

final class PickProfilePhotoSuccess extends ProfileState {
  final String profileImagePath;

  PickProfilePhotoSuccess(this.profileImagePath);
}

final class PickCoverPhotoSuccess extends ProfileState {
  final String coverImagePath;

  PickCoverPhotoSuccess(this.coverImagePath);
}

final class UploadProfilePhotoLoading extends ProfileState {}

final class UploadProfilePhotoSuccess extends ProfileState {
  final String profileImageUrl;

  UploadProfilePhotoSuccess({required this.profileImageUrl});
}

final class UploadProfilePhotoFailure extends ProfileState {
  final String errMessage;

  UploadProfilePhotoFailure(this.errMessage);
}

final class UploadCoverPhotoLoading extends ProfileState {}

final class UploadCoverPhotoSuccess extends ProfileState {}

final class UploadCoverPhotoFailure extends ProfileState {
  final String errMessage;

  UploadCoverPhotoFailure(this.errMessage);
}

final class UpdateProfileUserSuccess extends ProfileState {}
