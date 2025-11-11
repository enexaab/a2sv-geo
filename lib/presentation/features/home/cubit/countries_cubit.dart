import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/error/failures.dart';
import '../../../../domain/models/country_summary.dart';
import '../../../../domain/repositories/country_repository.dart';
import '../../../../domain/enums/sort_criteria.dart'; // Add this import

part 'countries_state.dart';

class CountriesCubit extends Cubit<CountriesState> {
  final ICountryRepository repository;
  CountriesCubit(this.repository) : super(const CountriesState());

  Future<void> getAllCountries() async {
    emit(const CountriesState(isLoading: true, isError: false));
    try {
      final countries = await repository.getAllCountries();
      final sortedCountries = _sortCountries(countries, state.sortCriteria);
      emit(CountriesState(
        countries: countries,
        filteredCountries: sortedCountries,
        isLoading: false,
        isError: false,
      ));
    } on ServerFailure catch (e) {
      emit(CountriesState(
        isLoading: false,
        isError: true,
        errorMessage: e.message,
      ));
    } catch (e) {
      emit(CountriesState(
        isLoading: false,
        isError: true,
        errorMessage: 'Unexpected error: ${e.toString()}',
      ));
    }
  }

  void searchCountries(String query) {
    if (query.isEmpty) {
      final sortedCountries = _sortCountries(state.countries, state.sortCriteria);
      emit(state.copyWith(filteredCountries: sortedCountries, searchQuery: ''));
      return;
    }

    final lowerCaseQuery = query.toLowerCase();
    
    final filtered = state.countries.where((country) {
      return country.name.toLowerCase().startsWith(lowerCaseQuery);
    }).toList();

    final sortedFiltered = _sortCountries(filtered, state.sortCriteria);

    emit(state.copyWith(
      filteredCountries: sortedFiltered,
      searchQuery: query,
      isLoading: false,
      isError: false,
    ));
  }

  void clearSearch() {
    final sortedCountries = _sortCountries(state.countries, state.sortCriteria);
    emit(state.copyWith(filteredCountries: sortedCountries, searchQuery: ''));
  }

  void sortCountries(SortCriteria criteria) {
    final sortedCountries = _sortCountries(state.filteredCountries, criteria);
    emit(state.copyWith(
      filteredCountries: sortedCountries,
      sortCriteria: criteria,
    ));
  }

  List<CountrySummary> _sortCountries(List<CountrySummary> countries, SortCriteria criteria) {
    final List<CountrySummary> sortedList = List.from(countries);
    
    switch (criteria) {
      case SortCriteria.name:
        sortedList.sort((a, b) => a.name.compareTo(b.name));
        break;
      case SortCriteria.population:
        sortedList.sort((a, b) => b.population.compareTo(a.population)); // Descending
        break;
    }
    
    return sortedList;
  }
}