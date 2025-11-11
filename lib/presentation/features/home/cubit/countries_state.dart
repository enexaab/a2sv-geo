part of 'countries_cubit.dart';

class CountriesState extends Equatable {
  final List<CountrySummary> countries;
  final List<CountrySummary> filteredCountries;
  final bool isLoading;
  final bool isError;
  final String errorMessage;
  final String searchQuery;
  final SortCriteria sortCriteria; 

  const CountriesState({
    this.countries = const [],
    this.filteredCountries = const [],
    this.isLoading = false,
    this.isError = false,
    this.errorMessage = '',
    this.searchQuery = '',
    this.sortCriteria = SortCriteria.name,
  });

  CountriesState copyWith({
    List<CountrySummary>? countries,
    List<CountrySummary>? filteredCountries,
    bool? isLoading,
    bool? isError,
    String? errorMessage,
    String? searchQuery,
    SortCriteria? sortCriteria, 
  }) {
    return CountriesState(
      countries: countries ?? this.countries,
      filteredCountries: filteredCountries ?? this.filteredCountries,
      isLoading: isLoading ?? this.isLoading,
      isError: isError ?? this.isError,
      errorMessage: errorMessage ?? this.errorMessage,
      searchQuery: searchQuery ?? this.searchQuery,
      sortCriteria: sortCriteria ?? this.sortCriteria, // NEW
    );
  }

  @override
  List<Object> get props => [
    countries,
    filteredCountries,
    isLoading,
    isError,
    errorMessage,
    searchQuery,
    sortCriteria, // NEW: Add to props
  ];
}