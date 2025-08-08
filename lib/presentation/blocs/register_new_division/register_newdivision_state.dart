part of 'register_newdivision_bloc.dart';

@immutable
sealed class RegisterNewdivisionState {}

final class RegisterNewdivisionInitial extends RegisterNewdivisionState {}

final class RegisterNewdivisionLoadingState extends RegisterNewdivisionState {}

final class RegisterNewdivisionSuccessState extends RegisterNewdivisionState {
  final String message;

  RegisterNewdivisionSuccessState({required this.message});
}

final class RegisterNewdivisionErrorState extends RegisterNewdivisionState {
  final String message;

  RegisterNewdivisionErrorState({required this.message});
}
