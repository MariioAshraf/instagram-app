part of 'profile_cubit.dart';

@immutable
sealed class ProfileState {}

final class ProfileInitial extends ProfileState {}

final class UpdateUserLoading extends ProfileState {}

final class UpdateUserSuccess extends ProfileState {
  final UserModel userModel;

  UpdateUserSuccess(this.userModel);
}

final class UpdateUserFailure extends ProfileState {
  final String errMessage;

  UpdateUserFailure(this.errMessage);
}
