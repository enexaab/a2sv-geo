
part of 'country_details.dart';


_$CountryDetailsImpl _$$CountryDetailsImplFromJson(Map<String, dynamic> json) =>
    _$CountryDetailsImpl(
      code: json['cca2'] as String? ?? 'NA',
      name: _nameFromJson(json['name']),
      flag: _flagFromJson(json['flags']),
      population: _numToInt(json['population']),
      capital: _capitalFromJson(json['capital']),
      region: json['region'] as String,
      subregion: json['subregion'] as String,
      area: _numToInt(json['area']),
      timezones:
          (json['timezones'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$$CountryDetailsImplToJson(
        _$CountryDetailsImpl instance) =>
    <String, dynamic>{
      'cca2': instance.code,
      'name': _nameToJson(instance.name),
      'flags': _flagToJson(instance.flag),
      'population': _intToNum(instance.population),
      'capital': _capitalToJson(instance.capital),
      'region': instance.region,
      'subregion': instance.subregion,
      'area': _intToNum(instance.area),
      'timezones': instance.timezones,
    };
