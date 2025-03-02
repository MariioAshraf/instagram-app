part of 'home_cubit.dart';

@immutable
sealed class HomeState {}

final class BottomNavInitial extends HomeState {}

final class ChangeBottomNavState extends HomeState {}

final class GetUserSuccess extends HomeState {}

final class GetUserLoading extends HomeState {}
