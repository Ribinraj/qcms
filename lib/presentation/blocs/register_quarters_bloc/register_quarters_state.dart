part of 'register_quarters_bloc.dart';

@immutable
sealed class RegisterQuartersState {}

final class RegisterQuartersInitial extends RegisterQuartersState {}

final class RegisterQuartersLoadingState extends RegisterQuartersState {}

final class RegisterQuartersSuccessState extends RegisterQuartersState {
  final String message;

  RegisterQuartersSuccessState({required this.message});
}

final class RegisterQuartersErrorState extends RegisterQuartersState {
  final String message;

  RegisterQuartersErrorState({required this.message});
}
