part of 'country_detail_cubit.dart';

class CountryDetailState extends Equatable {
  final CountryDetails? details;
  final bool isLoading;
  final bool isError;
  final String errorMessage;

  const CountryDetailState({
    this.details,
    this.isLoading = false,
    this.isError = false,
    this.errorMessage = '',
  });

  CountryDetailState copyWith({
    CountryDetails? details,
    bool? isLoading,
    bool? isError,
    String? errorMessage,
  }) {
    return CountryDetailState(
      details: details ?? this.details,
      isLoading: isLoading ?? this.isLoading,
      isError: isError ?? this.isError,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [details, isLoading, isError, errorMessage];
}