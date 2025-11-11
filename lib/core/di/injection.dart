import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/datasources/local/local_data_source.dart';
import '../../data/datasources/remote/country_api_service.dart';
import '../../data/repositories/country_repository_impl.dart';
import '../../domain/repositories/country_repository.dart';
import '../../presentation/features/country_detail/cubit/country_detail_cubit.dart';
import '../../presentation/features/favorites/cubit/favorites_cubit.dart';
import '../../presentation/features/home/cubit/countries_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferences>(() => sharedPreferences);

  sl.registerLazySingleton<Dio>(() => Dio());

  sl.registerLazySingleton<CountryApiService>(() => CountryApiService(sl()));
  sl.registerLazySingleton<LocalDataSource>(() => LocalDataSource(sl()));

  sl.registerLazySingleton<ICountryRepository>(() => CountryRepositoryImpl(sl(), sl()));

  sl.registerFactory<CountriesCubit>(() => CountriesCubit(sl()));
  sl.registerFactory<FavoritesCubit>(() => FavoritesCubit(sl()));
  sl.registerFactory<CountryDetailCubit>(() => CountryDetailCubit(sl()));
}