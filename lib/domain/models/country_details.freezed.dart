
part of 'country_details.dart';


T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

CountryDetails _$CountryDetailsFromJson(Map<String, dynamic> json) {
  return _CountryDetails.fromJson(json);
}

mixin _$CountryDetails {
  @JsonKey(name: 'cca2', defaultValue: 'NA')
  String get code =>
      throw _privateConstructorUsedError; 
  @JsonKey(name: 'name', fromJson: _nameFromJson, toJson: _nameToJson)
  String get name =>
      throw _privateConstructorUsedError; 
  @JsonKey(name: 'flags', fromJson: _flagFromJson, toJson: _flagToJson)
  String get flag =>
      throw _privateConstructorUsedError; 
  @JsonKey(fromJson: _numToInt, toJson: _intToNum)
  int get population =>
      throw _privateConstructorUsedError; 
  @JsonKey(name: 'capital', fromJson: _capitalFromJson, toJson: _capitalToJson)
  String get capital => throw _privateConstructorUsedError;
  String get region => throw _privateConstructorUsedError;
  String get subregion => throw _privateConstructorUsedError; // 6. Area
  @JsonKey(fromJson: _numToInt, toJson: _intToNum)
  int get area => throw _privateConstructorUsedError;
  List<String> get timezones => throw _privateConstructorUsedError;
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  @JsonKey(includeFromJson: false, includeToJson: false)
  $CountryDetailsCopyWith<CountryDetails> get copyWith =>
      throw _privateConstructorUsedError;
}

abstract class $CountryDetailsCopyWith<$Res> {
  factory $CountryDetailsCopyWith(
          CountryDetails value, $Res Function(CountryDetails) then) =
      _$CountryDetailsCopyWithImpl<$Res, CountryDetails>;
  @useResult
  $Res call(
      // ignore: invalid_annotation_target
      {@JsonKey(name: 'cca2', defaultValue: 'NA') String code,
      // ignore: invalid_annotation_target
      @JsonKey(name: 'name', fromJson: _nameFromJson, toJson: _nameToJson)
      String name,
      // ignore: invalid_annotation_target
      @JsonKey(name: 'flags', fromJson: _flagFromJson, toJson: _flagToJson)
      String flag,
      // ignore: invalid_annotation_target
      @JsonKey(fromJson: _numToInt, toJson: _intToNum) int population,
      // ignore: invalid_annotation_target
      @JsonKey(
          name: 'capital', fromJson: _capitalFromJson, toJson: _capitalToJson)
      String capital,
      String region,
      String subregion,
      // ignore: invalid_annotation_target
      @JsonKey(fromJson: _numToInt, toJson: _intToNum) int area,
      List<String> timezones});
}

class _$CountryDetailsCopyWithImpl<$Res, $Val extends CountryDetails>
    implements $CountryDetailsCopyWith<$Res> {
  _$CountryDetailsCopyWithImpl(this._value, this._then);

  final $Val _value;
  final $Res Function($Val) _then;
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    // ignore: avoid_init_to_null
    Object? code = null,
    // ignore: avoid_init_to_null
    Object? name = null,
    // ignore: avoid_init_to_null
    Object? flag = null,
    // ignore: avoid_init_to_null
    Object? population = null,
    // ignore: avoid_init_to_null
    Object? capital = null,
    // ignore: avoid_init_to_null
    Object? region = null,
    // ignore: avoid_init_to_null
    Object? subregion = null,
    // ignore: avoid_init_to_null
    Object? area = null,
    // ignore: avoid_init_to_null
    Object? timezones = null,
  }) {
    return _then(_value.copyWith(
      code: null == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      flag: null == flag
          ? _value.flag
          : flag // ignore: cast_nullable_to_non_nullable
              as String,
      population: null == population
          ? _value.population
          : population // ignore: cast_nullable_to_non_nullable
              as int,
      capital: null == capital
          ? _value.capital
          : capital // ignore: cast_nullable_to_non_nullable
              as String,
      region: null == region
          ? _value.region
          : region // ignore: cast_nullable_to_non_nullable
              as String,
      subregion: null == subregion
          ? _value.subregion
          : subregion // ignore: cast_nullable_to_non_nullable
              as String,
      area: null == area
          ? _value.area
          : area // ignore: cast_nullable_to_non_nullable
              as int,
      timezones: null == timezones
          ? _value.timezones
          : timezones // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CountryDetailsImplCopyWith<$Res>
    implements $CountryDetailsCopyWith<$Res> {
  factory _$$CountryDetailsImplCopyWith(_$CountryDetailsImpl value,
          $Res Function(_$CountryDetailsImpl) then) =
      __$$CountryDetailsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      // ignore: invalid_annotation_target
      {@JsonKey(name: 'cca2', defaultValue: 'NA') String code,
      // ignore: invalid_annotation_target
      @JsonKey(name: 'name', fromJson: _nameFromJson, toJson: _nameToJson)
      String name,
      // ignore: invalid_annotation_target
      @JsonKey(name: 'flags', fromJson: _flagFromJson, toJson: _flagToJson)
      String flag,
      // ignore: invalid_annotation_target
      @JsonKey(fromJson: _numToInt, toJson: _intToNum) int population,
      // ignore: invalid_annotation_target
      @JsonKey(
          name: 'capital', fromJson: _capitalFromJson, toJson: _capitalToJson)
      String capital,
      String region,
      String subregion,
      // ignore: invalid_annotation_target
      @JsonKey(fromJson: _numToInt, toJson: _intToNum) int area,
      List<String> timezones});
}

/// @nodoc
class __$$CountryDetailsImplCopyWithImpl<$Res>
    extends _$CountryDetailsCopyWithImpl<$Res, _$CountryDetailsImpl>
    implements _$$CountryDetailsImplCopyWith<$Res> {
  // ignore: use_super_parameters
  __$$CountryDetailsImplCopyWithImpl(
      // ignore: no_leading_underscores_for_local_identifiers
      _$CountryDetailsImpl _value, $Res Function(_$CountryDetailsImpl) _then)
      : super(_value, _then);

  /// Create a copy of CountryDetails
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    // ignore: avoid_init_to_null
    Object? code = null,
    // ignore: avoid_init_to_null
    Object? name = null,
    // ignore: avoid_init_to_null
    Object? flag = null,
    // ignore: avoid_init_to_null
    Object? population = null,
    // ignore: avoid_init_to_null
    Object? capital = null,
    // ignore: avoid_init_to_null
    Object? region = null,
    // ignore: avoid_init_to_null
    Object? subregion = null,
    // ignore: avoid_init_to_null
    Object? area = null,
    // ignore: avoid_init_to_null
    Object? timezones = null,
  }) {
    return _then(_$CountryDetailsImpl(
      code: null == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      flag: null == flag
          ? _value.flag
          : flag // ignore: cast_nullable_to_non_nullable
              as String,
      population: null == population
          ? _value.population
          : population // ignore: cast_nullable_to_non_nullable
              as int,
      capital: null == capital
          ? _value.capital
          : capital // ignore: cast_nullable_to_non_nullable
              as String,
      region: null == region
          ? _value.region
          : region // ignore: cast_nullable_to_non_nullable
              as String,
      subregion: null == subregion
          ? _value.subregion
          : subregion // ignore: cast_nullable_to_non_nullable
              as String,
      area: null == area
          ? _value.area
          : area // ignore: cast_nullable_to_non_nullable
              as int,
      timezones: null == timezones
          ? _value._timezones
          : timezones // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CountryDetailsImpl implements _CountryDetails {
  const _$CountryDetailsImpl(
      // ignore: invalid_annotation_target
      {@JsonKey(name: 'cca2', defaultValue: 'NA') required this.code,
      // ignore: invalid_annotation_target
      @JsonKey(name: 'name', fromJson: _nameFromJson, toJson: _nameToJson)
      required this.name,
      // ignore: invalid_annotation_target
      @JsonKey(name: 'flags', fromJson: _flagFromJson, toJson: _flagToJson)
      required this.flag,
      // ignore: invalid_annotation_target
      @JsonKey(fromJson: _numToInt, toJson: _intToNum) required this.population,
      // ignore: invalid_annotation_target
      @JsonKey(
          name: 'capital', fromJson: _capitalFromJson, toJson: _capitalToJson)
      required this.capital,
      required this.region,
      required this.subregion,
      // ignore: invalid_annotation_target
      @JsonKey(fromJson: _numToInt, toJson: _intToNum) required this.area,
      required final List<String> timezones})
      : _timezones = timezones;

  factory _$CountryDetailsImpl.fromJson(Map<String, dynamic> json) =>
      _$$CountryDetailsImplFromJson(json);

// Use @JsonKey to map complex or nested JSON fields to simple Dart properties
// 1. Primary Code (Used for API calls, caching key)
  @override
  @JsonKey(name: 'cca2', defaultValue: 'NA')
  final String code;
// 2. Name: Maps to json['name']['common']
  @override
  @JsonKey(name: 'name', fromJson: _nameFromJson, toJson: _nameToJson)
  final String name;
// 3. Flag: Maps to json['flags']['png']
  @override
  @JsonKey(name: 'flags', fromJson: _flagFromJson, toJson: _flagToJson)
  final String flag;
// 4. Population (Numbers are often read as 'num', so we ensure conversion)
  @override
  @JsonKey(fromJson: _numToInt, toJson: _intToNum)
  final int population;
// 5. Capital: Maps to json['capital'][0]
  @override
  @JsonKey(name: 'capital', fromJson: _capitalFromJson, toJson: _capitalToJson)
  final String capital;
  @override
  final String region;
  @override
  final String subregion;
// 6. Area
  @override
  @JsonKey(fromJson: _numToInt, toJson: _intToNum)
  final int area;
  final List<String> _timezones;
  @override
  List<String> get timezones {
    if (_timezones is EqualUnmodifiableListView) return _timezones;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_timezones);
  }

  @override
  String toString() {
    return 'CountryDetails(code: $code, name: $name, flag: $flag, population: $population, capital: $capital, region: $region, subregion: $subregion, area: $area, timezones: $timezones)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CountryDetailsImpl &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.flag, flag) || other.flag == flag) &&
            (identical(other.population, population) ||
                other.population == population) &&
            (identical(other.capital, capital) || other.capital == capital) &&
            (identical(other.region, region) || other.region == region) &&
            (identical(other.subregion, subregion) ||
                other.subregion == subregion) &&
            (identical(other.area, area) || other.area == area) &&
            const DeepCollectionEquality()
                .equals(other._timezones, _timezones));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      code,
      name,
      flag,
      population,
      capital,
      region,
      subregion,
      area,
      const DeepCollectionEquality().hash(_timezones));

  /// Create a copy of CountryDetails
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CountryDetailsImplCopyWith<_$CountryDetailsImpl> get copyWith =>
      __$$CountryDetailsImplCopyWithImpl<_$CountryDetailsImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CountryDetailsImplToJson(
      this,
    );
  }
}

abstract class _CountryDetails implements CountryDetails {
  const factory _CountryDetails(
      // ignore: invalid_annotation_target
      {@JsonKey(name: 'cca2', defaultValue: 'NA') required final String code,
      // ignore: invalid_annotation_target
      @JsonKey(name: 'name', fromJson: _nameFromJson, toJson: _nameToJson)
      required final String name,
      // ignore: invalid_annotation_target
      @JsonKey(name: 'flags', fromJson: _flagFromJson, toJson: _flagToJson)
      required final String flag,
      // ignore: invalid_annotation_target
      @JsonKey(fromJson: _numToInt, toJson: _intToNum)
      required final int population,
      // ignore: invalid_annotation_target
      @JsonKey(
          name: 'capital', fromJson: _capitalFromJson, toJson: _capitalToJson)
      required final String capital,
      required final String region,
      required final String subregion,
      // ignore: invalid_annotation_target
      @JsonKey(fromJson: _numToInt, toJson: _intToNum) required final int area,
      required final List<String> timezones}) = _$CountryDetailsImpl;

  factory _CountryDetails.fromJson(Map<String, dynamic> json) =
      _$CountryDetailsImpl.fromJson;

// Use @JsonKey to map complex or nested JSON fields to simple Dart properties
// 1. Primary Code (Used for API calls, caching key)
  @override
  @JsonKey(name: 'cca2', defaultValue: 'NA')
  String get code; // 2. Name: Maps to json['name']['common']
  @override
  @JsonKey(name: 'name', fromJson: _nameFromJson, toJson: _nameToJson)
  String get name; // 3. Flag: Maps to json['flags']['png']
  @override
  @JsonKey(name: 'flags', fromJson: _flagFromJson, toJson: _flagToJson)
  String
      get flag; // 4. Population (Numbers are often read as 'num', so we ensure conversion)
  @override
  @JsonKey(fromJson: _numToInt, toJson: _intToNum)
  int get population; // 5. Capital: Maps to json['capital'][0]
  @override
  @JsonKey(name: 'capital', fromJson: _capitalFromJson, toJson: _capitalToJson)
  String get capital;
  @override
  String get region;
  @override
  String get subregion; // 6. Area
  @override
  @JsonKey(fromJson: _numToInt, toJson: _intToNum)
  int get area;
  @override
  List<String> get timezones;

  /// Create a copy of CountryDetails
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CountryDetailsImplCopyWith<_$CountryDetailsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
