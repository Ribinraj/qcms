import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:qcms/domain/repositories/apprepo.dart';

part 'cancel_complaint_event.dart';
part 'cancel_complaint_state.dart';

class CancelComplaintBloc
    extends Bloc<CancelComplaintEvent, CancelComplaintState> {
  final Apprepo repository;
  CancelComplaintBloc({required this.repository})
    : super(CancelComplaintInitial()) {
    on<CancelComplaintEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<CancelComplaintButtonClickEvent>(cancelcomplaint);
  }

  FutureOr<void> cancelcomplaint(
    CancelComplaintButtonClickEvent event,
    Emitter<CancelComplaintState> emit,
  ) async {
    emit(CancelComplaintLoadingState());
    try {
      final response = await repository.cancelcomplaint(
        complaintId: event.complaintId,
      );
      if (!response.error && response.status == 200) {
        emit(CancelComplaintSuccessState(message: response.message));
      } else {
        emit(CancelComplaintErrorState(message: response.message));
      }
    } catch (e) {
      emit(CancelComplaintErrorState(message: e.toString()));
    }
  }
}
