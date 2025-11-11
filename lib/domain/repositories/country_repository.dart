import '../models/country_details.dart';
import '../models/country_summary.dart';

abstract class ICountryRepository {
  Future<List<CountrySummary>> getAllCountries();
  Future<List<CountrySummary>> searchCountries(String name);
  Future<CountryDetails> getCountryDetails(String code);
  Future<void> toggleFavorite(String code);
  Future<bool> isFavorite(String code);
  Future<List<String>> getFavoriteCodes();
  
  Future<void> clearFavoriteCodes(); 
}