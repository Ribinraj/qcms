part of 'cancel_complaint_bloc.dart';

@immutable
sealed class CancelComplaintState {}

final class CancelComplaintInitial extends CancelComplaintState {}

final class CancelComplaintLoadingState extends CancelComplaintState {}

final class CancelComplaintSuccessState extends CancelComplaintState {
  final String message;

  CancelComplaintSuccessState({required this.message});
}

final class CancelComplaintErrorState extends CancelComplaintState {
  final String message;

  CancelComplaintErrorState({required this.message});
}
