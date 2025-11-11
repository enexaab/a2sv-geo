import 'dart:convert';
import 'package:a2sv_geo/domain/models/country_details.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/foundation.dart'; 

class LocalDataSource {
  final SharedPreferences _prefs;
  static const String _favoritesKey = 'favorites_codes';
  static const String _detailsPrefix = 'country_details_'; 
  
  static const Duration _cacheDuration = Duration(hours: 24); 

  LocalDataSource(this._prefs);
  

  Future<void> cacheCountryDetails(CountryDetails details) async {
    final key = '$_detailsPrefix${details.code}';
    final timestamp = DateTime.now().toIso8601String();
    
    final cachedData = {
      'data': details.toJson(), 
      'timestamp': timestamp,
    };
    
    try {
      await _prefs.setString(key, jsonEncode(cachedData));
      if (kDebugMode) {
        debugPrint('LocalDataSource: Cached details for ${details.code} at $timestamp');
      }
    } catch (e) {
      if (kDebugMode) {
        debugPrint('LocalDataSource: Error caching details for ${details.code}: $e');
      }
      rethrow; 
    }
  }

  Future<CountryDetails?> getCountryDetails(String code) async {
    final key = '$_detailsPrefix$code';
    
    try {
      final cachedJsonString = _prefs.getString(key);
      if (cachedJsonString == null) {
        return null; // Cache miss
      }

      final cachedData = jsonDecode(cachedJsonString) as Map<String, dynamic>;
      final storedTimestamp = DateTime.parse(cachedData['timestamp'] as String);
      
      if (DateTime.now().difference(storedTimestamp) > _cacheDuration) {
        await _prefs.remove(key); 
        if (kDebugMode) {
          debugPrint('LocalDataSource: Cache expired for $code. Cleared entry.');
        }
        return null;
      }
      
      final detailsJson = cachedData['data'] as Map<String, dynamic>;
      final details = CountryDetails.fromJson(detailsJson);
      
      if (kDebugMode) {
        debugPrint('LocalDataSource: Cache HIT for $code. Valid until ${storedTimestamp.add(_cacheDuration)}');
      }
      return details;

    } catch (e) {
      if (kDebugMode) {
        debugPrint('LocalDataSource: Error retrieving or parsing cache for $code: $e');
      }
      return null;
    }
  }

  Future<void> toggleFavorite(String code) async {
    if (kDebugMode) {
      debugPrint('LocalDataSource: Toggling favorite for code: $code');
    }
    try {
      final favorites = await getFavoriteCodes();
      bool wasFavorite = favorites.contains(code);
      if (wasFavorite) {
        favorites.remove(code);
        if (kDebugMode) {
          debugPrint('LocalDataSource: Removed $code from favorites');
        }
      } else {
        favorites.add(code);
        if (kDebugMode) {
          debugPrint('LocalDataSource: Added $code to favorites');
        }
      }
      await _prefs.setStringList(_favoritesKey, List<String>.from(favorites));
      if (kDebugMode) {
        debugPrint('LocalDataSource: Saved favorites: ${List<String>.from(favorites)}');
      }
    } catch (e) {
      if (kDebugMode) {
        debugPrint('LocalDataSource: Error toggling favorite: $e');
      }
      rethrow;
    }
  }

  Future<bool> isFavorite(String code) async {
    try {
      final favorites = await getFavoriteCodes();
      bool isFav = favorites.contains(code);
      if (kDebugMode) {
        debugPrint('LocalDataSource: Is $code favorite? $isFav');
      }
      return isFav;
    } catch (e) {
      if (kDebugMode) {
        debugPrint('LocalDataSource: Error checking favorite: $e');
      }
      rethrow;
    }
  }

  Future<List<String>> getFavoriteCodes() async {
    try {
      final codes = _prefs.getStringList(_favoritesKey) ?? <String>[];
      if (kDebugMode) {
        debugPrint('LocalDataSource: Loaded favorites: $codes');
      }
      return codes;
    } catch (e) {
      if (kDebugMode) {
        debugPrint('LocalDataSource: Error loading favorites: $e');
      }
      return <String>[];
    }
  }
}