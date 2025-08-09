import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:qcms/data/register_newquarters.dart';
import 'package:qcms/domain/repositories/loginrepo.dart';

part 'register_quarters_event.dart';
part 'register_quarters_state.dart';

class RegisterQuartersBloc
    extends Bloc<RegisterQuartersEvent, RegisterQuartersState> {
  final LoginRepo repository;
  RegisterQuartersBloc({required this.repository})
    : super(RegisterQuartersInitial()) {
    on<RegisterQuartersEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<RegisterQuartersButtonClickEvent>(registerquarters);
  }

  FutureOr<void> registerquarters(
    RegisterQuartersButtonClickEvent event,
    Emitter<RegisterQuartersState> emit,
  ) async {
    emit(RegisterQuartersLoadingState());
    try {
      final response = await repository.registerquarters(
        quarters: event.quarters,
      );
      if (!response.error && response.status == 200) {
        emit(RegisterQuartersSuccessState(message: response.message));
      } else {
        emit(RegisterQuartersErrorState(message: response.message));
      }
    } catch (e) {
      emit(RegisterQuartersErrorState(message: e.toString()));
    }
  }
}
