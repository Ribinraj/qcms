part of 'request_complaint_bloc.dart';

@immutable
sealed class RequestComplaintState {}

final class RequestComplaintInitial extends RequestComplaintState {}

final class RequestComplaintLoadingState extends RequestComplaintState {}

final class RequestComplaintSuccessState extends RequestComplaintState {
  final String message;

  RequestComplaintSuccessState({required this.message});
}

final class RequestComplaintErrorState extends RequestComplaintState {
  final String message;

  RequestComplaintErrorState({required this.message});
}
