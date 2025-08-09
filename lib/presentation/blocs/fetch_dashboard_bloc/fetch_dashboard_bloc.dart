import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:qcms/data/dashboard_model.dart';
import 'package:qcms/domain/repositories/apprepo.dart';

part 'fetch_dashboard_event.dart';
part 'fetch_dashboard_state.dart';

class FetchDashboardBloc
    extends Bloc<FetchDashboardEvent, FetchDashboardState> {
  final Apprepo repository;
  FetchDashboardBloc({required this.repository})
    : super(FetchDashboardInitial()) {
    on<FetchDashboardEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<FetchDashboardInitialEvent>(fetchdashbord);
  }

  FutureOr<void> fetchdashbord(
    FetchDashboardInitialEvent event,
    Emitter<FetchDashboardState> emit,
  ) async {
    emit(FetchDashboardLoadingState());
    try {
      final response = await repository.fetchdashboard();
      if (!response.error && response.status == 200) {
        emit(FetchDashboardSuccessState(dashboard: response.data!));
      } else {
        emit(FetchDashboardErrorState(message: response.message));
      }
    } catch (e) {
      emit(FetchDashboardErrorState(message: e.toString()));
    }
  }
}
