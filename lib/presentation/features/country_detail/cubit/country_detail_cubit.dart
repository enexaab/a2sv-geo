
import 'package:equatable/equatable.dart'; // BACK TO MANUAL
import 'package:flutter_bloc/flutter_bloc.dart';


import '../../../../core/error/failures.dart';
import '../../../../domain/models/country_details.dart'; // Need this here for CountryDetails model
import '../../../../domain/repositories/country_repository.dart';

part 'country_detail_state.dart'; 

class CountryDetailCubit extends Cubit<CountryDetailState> {
  final ICountryRepository repository;
  
  CountryDetailCubit(this.repository) : super(const CountryDetailState());

  Future<void> fetchCountryDetails(String code) async {
    emit(const CountryDetailState(isLoading: true, isError: false, errorMessage: '')); 

    try {
      final details = await repository.getCountryDetails(code);
      emit(CountryDetailState(
        details: details,
        isLoading: false,
        isError: false,
        errorMessage: '',
      ));
    } on ServerFailure catch (e) {
      emit(CountryDetailState(
        isLoading: false,
        isError: true,
        errorMessage: e.message,
      ));
    // ignore: unused_catch_stack
    } catch (e, stackTrace) {
      emit(CountryDetailState(
        isLoading: false,
        isError: true,
        errorMessage: 'Unexpected error: ${e.toString()}',
      ));
    }
  }
}