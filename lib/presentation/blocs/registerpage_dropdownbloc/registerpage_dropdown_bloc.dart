import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:qcms/data/divisions_model.dart';
import 'package:qcms/data/quarters_model.dart';
import 'package:qcms/domain/repositories/apprepo.dart';

part 'registerpage_dropdown_event.dart';
part 'registerpage_dropdown_state.dart';

class RegisterpageDropdownBloc
    extends Bloc<RegisterpageDropdownEvent, RegisterpageDropdownState> {
  final Apprepo repository;
  RegisterpageDropdownBloc({required this.repository})
    : super(RegisterpageDropdownInitial()) {
    on<RegisterpageDropdownFetchingInitailEvent>(fetchdropdownlists);
    on<SearchDivisonsEvent>(searchdivision);
    on<SearchQuartersEvent>(searchquarters);
  }

  FutureOr<void> fetchdropdownlists(
    RegisterpageDropdownFetchingInitailEvent event,
    Emitter<RegisterpageDropdownState> emit,
  ) async {
    emit(RegisterpageDropdownLoadingState());
    try {
      final divisonresponse = await repository.fetchdivisions();
      final quartersresponse = await repository.fetchquarters();
      if (!divisonresponse.error && !quartersresponse.error) {
        emit(
          RegisterpageDropdownSuccessState(
            divisions: divisonresponse.data!,
            filtereddivisions: divisonresponse.data!,
            quarters: quartersresponse.data!,
            filteredquarters: quartersresponse.data!,
          ),
        );
      } else {
        emit(RegisterpageDropdownErrorState(error: 'data not downloaded'));
      }
    } catch (e) {
      emit(RegisterpageDropdownErrorState(error: e.toString()));
    }
  }

  FutureOr<void> searchdivision(
    SearchDivisonsEvent event,
    Emitter<RegisterpageDropdownState> emit,
  ) {
    final stateLoaded = state as RegisterpageDropdownSuccessState;
    final filterddivision = stateLoaded.divisions.where((division) {
      return division.cityName.toLowerCase().contains(
        event.query.trim().toLowerCase(),
      );
    }).toList();
    emit(stateLoaded.copyWith(filterdDivisions: filterddivision));
  }

  FutureOr<void> searchquarters(
    SearchQuartersEvent event,
    Emitter<RegisterpageDropdownState> emit,
  ) {
    final stateloaded = state as RegisterpageDropdownSuccessState;
    final filteredquarters = stateloaded.quarters.where((quarters) {
      return quarters.quarterName.toLowerCase().contains(
        event.query.trim().toLowerCase(),
      );
    }).toList();
    emit(stateloaded.copyWith(filteredQuarters: filteredquarters));
  }
}
////////////////////////////
        // children: [
        //   TextField(
        //     decoration: InputDecoration(hintText: 'Search City'),
        //     onChanged: (value) {
        //       context.read<RegistrationBloc>().add(SearchCities(value));
        //     },
        //   ),
        //   DropdownButtonFormField<City>(
        //     items: state.filteredCities
        //         .map((city) =>
        //             DropdownMenuItem(value: city, child: Text(city.name)))
        //         .toList(),
        //     onChanged: (value) {},
        //     decoration: InputDecoration(labelText: "Select City"),
        //   ),