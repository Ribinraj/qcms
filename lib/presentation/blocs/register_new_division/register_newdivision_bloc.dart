import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:qcms/data/register_newdivision.dart';
import 'package:qcms/domain/repositories/loginrepo.dart';

part 'register_newdivision_event.dart';
part 'register_newdivision_state.dart';

class RegisterNewdivisionBloc
    extends Bloc<RegisterNewdivisionEvent, RegisterNewdivisionState> {
  final LoginRepo repository;
  RegisterNewdivisionBloc({required this.repository})
    : super(RegisterNewdivisionInitial()) {
    on<RegisterNewdvisionButtonClickEvent>(registernewdivision);
  }

  FutureOr<void> registernewdivision(
    RegisterNewdvisionButtonClickEvent event,
    Emitter<RegisterNewdivisionState> emit,
  ) async {
    emit(RegisterNewdivisionLoadingState());
    try {
      final response = await repository.registernewDivision(
        division: event.divsion,
      );
      if (!response.error && response.status == 200) {
        emit(RegisterNewdivisionSuccessState(message: response.message));
      } else {
        emit(RegisterNewdivisionErrorState(message: response.message));
      }
    } catch (e) {
      emit(RegisterNewdivisionErrorState(message: e.toString()));
    }
  }
}
