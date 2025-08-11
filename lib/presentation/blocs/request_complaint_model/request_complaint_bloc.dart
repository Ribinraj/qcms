import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/physics.dart';
import 'package:meta/meta.dart';
import 'package:qcms/data/complaintrequest_model.dart';
import 'package:qcms/domain/repositories/apprepo.dart';

part 'request_complaint_event.dart';
part 'request_complaint_state.dart';

class RequestComplaintBloc
    extends Bloc<RequestComplaintEvent, RequestComplaintState> {
  final Apprepo repository;
  RequestComplaintBloc({required this.repository})
    : super(RequestComplaintInitial()) {
    on<RequestComplaintEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<RequestComplaintButtonClickEvent>(requestcomplaint);
  }

  FutureOr<void> requestcomplaint(
    RequestComplaintButtonClickEvent event,
    Emitter<RequestComplaintState> emit,
  ) async {
    emit(RequestComplaintLoadingState());
    try {
      final response = await repository.complaintRequest(
        complaint: event.complaint,
      );
      if (!response.error && response.status == 200) {
        emit(RequestComplaintSuccessState(message: response.message));
      } else {
        emit(RequestComplaintErrorState(message: response.message));
      }
    } catch (e) {
      emit(RequestComplaintErrorState(message: e.toString()));
    }
  }
}
