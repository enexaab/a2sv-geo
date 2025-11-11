import 'package:equatable/equatable.dart';

class CountrySummary extends Equatable {
  final String name;
  final String flag;
  final int population;
  final String cca2;
  final String capital;

  const CountrySummary({
    required this.name,
    required this.flag,
    required this.population,
    required this.cca2,
    required this.capital,
  });

  factory CountrySummary.fromJson(Map<String, dynamic> json) {
    return CountrySummary(
      name: json['name']['common'] as String,
      flag: json['flags']['png'] as String,
      population: (json['population'] as num?)?.toInt() ?? 0,  // Safe cast
      cca2: json['cca2'] as String,
      capital: (json['capital'] as List?)?.isNotEmpty == true ? json['capital'][0] as String : 'N/A',
    );
  }

  @override
  List<Object?> get props => [name, flag, population, cca2, capital];
}