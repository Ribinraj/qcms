import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:qcms/data/quarters_model.dart';
import 'package:qcms/domain/repositories/apprepo.dart';

part 'fetch_quarters_event.dart';
part 'fetch_quarters_state.dart';

class FetchQuartersBloc extends Bloc<FetchQuartersEvent, FetchQuartersState> {
  final Apprepo repository;
  FetchQuartersBloc({required this.repository})
    : super(FetchQuartersInitial()) {
    on<FetchQuartersEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<FetchQuartersInitialFEtchingEvent>(fetchquarters);
  }

  FutureOr<void> fetchquarters(
    FetchQuartersInitialFEtchingEvent event,
    Emitter<FetchQuartersState> emit,
  ) async {
    emit(FetchQuartersLoadingState());
    try {
      final response = await repository.fetchquarters(
        divisionId: event.divisionId,
      );
      if (!response.error && response.status == 200) {
        emit(FetchQuartersSuccessState(quarters: response.data!));
      } else {
        emit(FetchQuartersErrorState(message: response.message));
      }
    } catch (e) {
      emit(FetchQuartersErrorState(message: e.toString()));
    }
  }
}
