// lib/presentation/features/favorites/screens/favorites_screen.dart (Final Code)
// ignore_for_file: depend_on_referenced_packages

import 'package:a2sv_geo/core/providers/theme_provider.dart';
import 'package:a2sv_geo/presentation/features/country_detail/cubit/country_detail_cubit.dart';
import 'package:a2sv_geo/presentation/features/country_detail/screens/country_detail_screen.dart';
import 'package:a2sv_geo/presentation/features/home/cubit/countries_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

import '../../../widgets/country_list_tile.dart';
import '../../../widgets/loading_shimmer.dart';
import '../../favorites/cubit/favorites_cubit.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  @override
  void initState() {
    super.initState();
    // Ensure favorites are loaded
    context.read<FavoritesCubit>().loadFavorites();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: Consumer<ThemeProvider>(
          builder: (context, themeProvider, child) {
            final isDarkMode = themeProvider.isDarkMode;
            return AppBar(
              centerTitle: true,
              title: const Text('Favorites'),
              backgroundColor: isDarkMode ? const Color(0xFF1E1E1E) : Colors.white,
              foregroundColor: isDarkMode ? Colors.white : Colors.black,
              // These settings are crucial for removing the line/shadow
              elevation: 0, 
              shadowColor: Colors.transparent,
              surfaceTintColor: Colors.transparent,
              forceMaterialTransparency: true,
              // This explicitly removes any default bottom border
              shape: const Border(
                bottom: BorderSide.none,
              ), 
            );
          },
        ),
      ),
      body: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          final isDarkMode = themeProvider.isDarkMode;
          return MultiBlocListener(
            listeners: [
              BlocListener<FavoritesCubit, FavoritesState>(
                listener: (context, state) {
                  if (state.isError) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Favorites error: ${state.errorMessage}')),
                    );
                  }
                },
              ),
            ],
            child: BlocBuilder<FavoritesCubit, FavoritesState>(
              builder: (context, favState) {
                if (favState.isLoading && favState.favoriteCodes.isEmpty) {
                  return Container(
                    color: isDarkMode ? const Color(0xFF1E1E1E) : Colors.white,
                    child: ListView.builder(
                      itemCount: 10,
                      itemBuilder: (_, __) => ShimmerCountryTile(isDarkMode: isDarkMode),
                    ),
                  );
                }
                return BlocBuilder<CountriesCubit, CountriesState>(
                  builder: (context, countriesState) {
                    // Filter the main list of countries to show only the favorites
                    final favorites = countriesState.countries
                        .where((country) => favState.favoriteCodes.contains(country.cca2))
                        .toList();
                        
                    if (favorites.isEmpty && !favState.isLoading) {
                      return Container(
                        color: isDarkMode ? const Color(0xFF1E1E1E) : Colors.white,
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(48.0),
                            child: Column(
                              children: [
                                Icon(
                                  Icons.favorite_border, 
                                  size: 64, 
                                  color: isDarkMode ? Colors.grey[400] : const Color(0xFF6B7582),
                                ), 
                                const SizedBox(height: 16),
                                Text(
                                  'No favorites yet', 
                                  style: TextStyle(
                                    fontSize: 18, 
                                    fontWeight: FontWeight.w500,
                                    color: isDarkMode ? Colors.white : Colors.black,
                                  ),
                                ),
                                Text(
                                  'Tap the heart icon to save your favorite countries', 
                                  style: TextStyle(
                                    color: isDarkMode ? Colors.grey[400] : const Color(0xFF6B7582),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }
                    return Container(
                      color: isDarkMode ? const Color(0xFF1E1E1E) : Colors.white,
                      child: ListView.builder(
                        itemCount: favorites.length,
                        itemBuilder: (context, index) {
                          final country = favorites[index];
                          return BlocSelector<FavoritesCubit, FavoritesState, bool>(
                            selector: (state) => state.favoriteCodes.contains(country.cca2),
                            builder: (context, isFavorite) {
                              return CountryListTile(
                                country: country,
                                isFavoriteView: true,
                                // Pass the actual state. The fix relies on CountryListTile
                                // checking the isFavoriteView flag to draw the icon.
                                isFavorite: isFavorite, 
                                isDarkMode: isDarkMode,
                                onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => BlocProvider(
                                      create: (_) => GetIt.I<CountryDetailCubit>(),
                                      child: CountryDetailScreen(code: country.cca2),
                                    ),
                                  ),
                                ),
                                onToggleFavorite: () => context.read<FavoritesCubit>().toggleFavorite(country.cca2),
                              );
                            },
                          );
                        },
                      ),
                    );
                  },
                );
              },
            ),
          );
        },
      ),
    );
  }
}