import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart'; // For debugPrint

import '../../../../core/error/failures.dart';
import '../../../../domain/repositories/country_repository.dart';

part 'favorites_state.dart';

class FavoritesCubit extends Cubit<FavoritesState> {
  final ICountryRepository repository;
  FavoritesCubit(this.repository) : super(const FavoritesState());

  Future<void> loadFavorites() async {
    if (kDebugMode) {
      debugPrint('FavoritesCubit: Loading favorites...');
    }
    emit(const FavoritesState(isLoading: true, isError: false));
    try {
      final codes = await repository.getFavoriteCodes();
      emit(FavoritesState(
        favoriteCodes: codes.toSet(),
        isLoading: false,
        isError: false,
      ));
      if (kDebugMode) {
        debugPrint('FavoritesCubit: Loaded ${codes.length} favorites');
      }
    } on CacheFailure catch (e) {
      if (kDebugMode) {
        debugPrint('FavoritesCubit: CacheFailure loading favorites: ${e.message}');
      }
      emit(FavoritesState(
        isLoading: false,
        isError: true,
        errorMessage: e.message,
      ));
    } catch (e) {
      if (kDebugMode) {
        debugPrint('FavoritesCubit: Unexpected error loading favorites: $e');
      }
      emit(FavoritesState(
        isLoading: false,
        isError: true,
        errorMessage: 'Unexpected error: ${e.toString()}',
      ));
    }
  }

  Future<void> toggleFavorite(String code) async {
    if (kDebugMode) {
      debugPrint('FavoritesCubit: Toggling favorite for code: $code');
    }
    emit(state.copyWith(isLoading: true));
    try {
      await repository.toggleFavorite(code);
      await loadFavorites();
      if (kDebugMode) {
        debugPrint('FavoritesCubit: Toggle complete, reloaded favorites');
      }
    } on CacheFailure catch (e) {
      if (kDebugMode) {
        debugPrint('FavoritesCubit: CacheFailure toggling favorite: ${e.message}');
      }
      emit(state.copyWith(
        isLoading: false,
        isError: true,
        errorMessage: e.message,
      ));
    } catch (e) {
      if (kDebugMode) {
        debugPrint('FavoritesCubit: Unexpected error toggling favorite: $e');
      }
      emit(state.copyWith(
        isLoading: false,
        isError: true,
        errorMessage: 'Unexpected error: ${e.toString()}',
      ));
    }
  }

  Future<void> clearAllFavorites() async {
    if (kDebugMode) {
      debugPrint('FavoritesCubit: Clearing ALL persisted favorites...');
    }
    emit(state.copyWith(isLoading: true));
    try {
      await repository.clearFavoriteCodes(); 
      await loadFavorites(); 
      if (kDebugMode) {
        debugPrint('FavoritesCubit: All favorites cleared successfully.');
      }
    } on CacheFailure catch (e) {
      if (kDebugMode) {
        debugPrint('FavoritesCubit: CacheFailure clearing favorites: ${e.message}');
      }
      emit(state.copyWith(
        isLoading: false,
        isError: true,
        errorMessage: e.message,
      ));
    } catch (e) {
      if (kDebugMode) {
        debugPrint('FavoritesCubit: Unexpected error clearing favorites: $e');
      }
      emit(state.copyWith(
        isLoading: false,
        isError: true,
        errorMessage: 'Unexpected error: ${e.toString()}',
      ));
    }
  }
}