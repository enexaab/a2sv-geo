import '../../core/error/failures.dart';
import '../../domain/models/country_details.dart';
import '../../domain/models/country_summary.dart';
import '../../domain/repositories/country_repository.dart';
import '../datasources/local/local_data_source.dart';
import '../datasources/remote/country_api_service.dart';

class CountryRepositoryImpl implements ICountryRepository {
  final CountryApiService _remoteDataSource;
  final LocalDataSource _localDataSource;

  CountryRepositoryImpl(this._remoteDataSource, this._localDataSource);

  @override
  Future<List<CountrySummary>> getAllCountries() async {
    try {
      return await _remoteDataSource.getAllCountries();
    } on ServerFailure {
      rethrow;
    } catch (e) {
      throw ServerFailure('Unexpected error fetching countries: ${e.toString()}');
    }
  }

  @override
  Future<List<CountrySummary>> searchCountries(String name) async {
    try {
      return await _remoteDataSource.searchCountries(name);
    } on ServerFailure {
      rethrow;
    } catch (e) {
      throw ServerFailure('Unexpected error searching countries: ${e.toString()}');
    }
  }


  @override
  Future<CountryDetails> getCountryDetails(String code) async {
    try {
      final cachedDetails = await _localDataSource.getCountryDetails(code);
      
      if (cachedDetails != null) {
        return cachedDetails; 
      }
    } on Exception {
      // If reading the cache failed, we proceed to network.
    }
    
    try {
      final remoteDetails = await _remoteDataSource.getCountryDetails(code);
      
      _localDataSource.cacheCountryDetails(remoteDetails); 
      
      return remoteDetails;
    } on ServerFailure {
      rethrow; 
    } catch (e) {
      throw ServerFailure('Unexpected error fetching country details: ${e.toString()}');
    }
  }
  
  @override
  Future<void> toggleFavorite(String code) async {
    try {
      await _localDataSource.toggleFavorite(code);
    } catch (e) {
      throw CacheFailure('Failed to toggle favorite: ${e.toString()}');
    }
  }

  @override
  Future<bool> isFavorite(String code) async {
    try {
      return await _localDataSource.isFavorite(code);
    } catch (e) {
      throw CacheFailure('Failed to check favorite: ${e.toString()}');
    }
  }

  @override
  Future<List<String>> getFavoriteCodes() async {
    try {
      return await _localDataSource.getFavoriteCodes();
    } catch (e) {
      throw CacheFailure('Failed to load favorites: ${e.toString()}');
    }
  }

  @override
  Future<void> clearFavoriteCodes() async {
    
    try {
     
      
      throw const CacheFailure('Clear favorite codes is not supported by the current LocalDataSource implementation.');
    } catch (e) {
      throw CacheFailure('Failed to clear favorites: ${e.toString()}');
    }
  }
}