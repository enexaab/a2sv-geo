part of 'favorites_cubit.dart';

class FavoritesState extends Equatable {
  final Set<String> favoriteCodes;
  final bool isLoading;
  final bool isError;
  final String errorMessage;

  const FavoritesState({
    this.favoriteCodes = const <String>{},
    this.isLoading = false,
    this.isError = false,
    this.errorMessage = '',
  });

  FavoritesState copyWith({
    Set<String>? favoriteCodes,
    bool? isLoading,
    bool? isError,
    String? errorMessage,
  }) {
    return FavoritesState(
      favoriteCodes: favoriteCodes ?? this.favoriteCodes,
      isLoading: isLoading ?? this.isLoading,
      isError: isError ?? this.isError,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object> get props => [favoriteCodes, isLoading, isError, errorMessage];
}