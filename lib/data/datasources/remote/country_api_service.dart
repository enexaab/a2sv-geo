import 'package:a2sv_geo/core/constants/app_constants.dart';
import 'package:a2sv_geo/core/error/failures.dart';
import 'package:a2sv_geo/domain/models/country_details.dart';
import 'package:a2sv_geo/domain/models/country_summary.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart'; 

class CountryApiService {
  final Dio _dio;

  CountryApiService(this._dio);

  Future<List<CountrySummary>> getAllCountries() async {
    try {
      final response = await _dio.get(
        '${AppConstants.baseUrl}/all?fields=name,flags,population,cca2,capital',
      );
      _validateResponse(response);
      final data = response.data as List<dynamic>? ?? [];
      return data.map((json) => CountrySummary.fromJson(json as Map<String, dynamic>)).toList();
    } on DioException catch (e) {
      _logDioError(e, 'getAllCountries');
      final message = _extractDioErrorMessage(e);
      throw ServerFailure('Failed to fetch countries: $message');
    } catch (e, stackTrace) {
      debugPrint('Unexpected error in getAllCountries: $e\nStackTrace: $stackTrace');
      rethrow;
    }
  }

  Future<List<CountrySummary>> searchCountries(String name) async {
    if (name.trim().isEmpty) {
      return []; 
    }
    try {
      final response = await _dio.get(
        '${AppConstants.baseUrl}/name/${Uri.encodeComponent(name)}?fields=name,flags,population,cca2,capital',
      );
      _validateResponse(response);
      final data = response.data as List<dynamic>? ?? [];
      return data.map((json) => CountrySummary.fromJson(json as Map<String, dynamic>)).toList();
    } on DioException catch (e) {
      _logDioError(e, 'searchCountries');
      final message = _extractDioErrorMessage(e);
      throw ServerFailure('Failed to search countries: $message');
    } catch (e, stackTrace) {
      debugPrint('Unexpected error in searchCountries: $e\nStackTrace: $stackTrace');
      rethrow;
    }
  }

  Future<CountryDetails> getCountryDetails(String code) async {
    if (code.isEmpty) {
      throw const ServerFailure('Invalid country code provided');
    }
    try {
      final response = await _dio.get(
        '${AppConstants.baseUrl}/alpha/$code?fields=name,flags,population,capital,region,subregion,area,timezones',
      );
      _validateResponse(response);
      dynamic data = response.data;
      if (data is List<dynamic>) {
        if (data.isEmpty) {
          throw const ServerFailure('Country not found');
        }
        data = data.first;
      } else if (data is! Map<String, dynamic>) {
        throw const ServerFailure('Invalid response format');
      }
      return CountryDetails.fromJson(data as Map<String, dynamic>);
    } on DioException catch (e) {
      _logDioError(e, 'getCountryDetails');
      final message = _extractDioErrorMessage(e);
      if (e.response?.statusCode == 404) {
        throw const ServerFailure('Country not found');
      }
      throw ServerFailure('Failed to fetch country details: $message');
    } catch (e, stackTrace) {
      debugPrint('Unexpected error in getCountryDetails: $e\nStackTrace: $stackTrace');
      rethrow;
    }
  }

  void _validateResponse(Response response) {
    if (response.statusCode != 200) {
      throw ServerFailure('Invalid response status: ${response.statusCode}');
    }
  }

  String _extractDioErrorMessage(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return 'Connection timeout. Please check your internet.';
      case DioExceptionType.badResponse:
        return 'Server error (${e.response?.statusCode ?? 'Unknown'}): ${e.response?.statusMessage ?? 'No details available'}';
      case DioExceptionType.cancel:
        return 'Request cancelled';
      case DioExceptionType.connectionError:
        return 'No internet connection';
      default:
        return e.message ?? 'Unknown error occurred';
    }
  }

  void _logDioError(DioException e, String method) {
    if (kDebugMode) {
      debugPrint('DioError in $method: Type=${e.type}, Message=${e.message}');
      if (e.response != null) {
        debugPrint('Response: Status=${e.response!.statusCode}, Data type=${e.response!.data.runtimeType}');
      }
      debugPrint('Request: Path=${e.requestOptions.path}');
        }
  }
}