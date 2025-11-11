// lib/presentation/features/home/screens/home_screen.dart
import 'dart:async';
import 'package:a2sv_geo/presentation/features/country_detail/cubit/country_detail_cubit.dart';
import 'package:a2sv_geo/presentation/features/home/cubit/countries_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
// ignore: depend_on_referenced_packages
import 'package:provider/provider.dart';

import '../../../widgets/country_list_tile.dart';
import '../../../widgets/loading_shimmer.dart';
import '../../country_detail/screens/country_detail_screen.dart';
import '../../favorites/cubit/favorites_cubit.dart';
import '../../../../domain/enums/sort_criteria.dart';
import '../../../../core/providers/theme_provider.dart'; // Add this import
import '../../../widgets/theme_toggle_button.dart'; // Add this import

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  Timer? _debounce;
  final int _debounceDurationMs = 500;

  void _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) {
      _debounce!.cancel();
    }
    _debounce = Timer(Duration(milliseconds: _debounceDurationMs), () {
      if (mounted) {
        context.read<CountriesCubit>().searchCountries(query);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<CountriesCubit>().getAllCountries();
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _searchController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _clearSearchAndDismissKeyboard(BuildContext context) {
    _searchController.clear();
    context.read<CountriesCubit>().clearSearch();
    _focusNode.unfocus();
  }

  void _showSortBottomSheet(BuildContext context) {
    final currentSort = context.read<CountriesCubit>().state.sortCriteria;
    final isDarkMode = Provider.of<ThemeProvider>(context, listen: false).isDarkMode;
    
    showModalBottomSheet(
      context: context,
      backgroundColor: isDarkMode ? const Color(0xFF1E1E1E) : Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 8),
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: isDarkMode ? Colors.grey[600] : Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Sort By',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: isDarkMode ? Colors.white : Colors.black,
                ),
              ),
              const SizedBox(height: 16),
              _buildSortOption(
                context,
                title: 'Name (A-Z)',
                isSelected: currentSort == SortCriteria.name,
                onTap: () {
                  context.read<CountriesCubit>().sortCountries(SortCriteria.name);
                  Navigator.pop(context);
                },
              ),
              _buildSortOption(
                context,
                title: 'Population (High to Low)',
                isSelected: currentSort == SortCriteria.population,
                onTap: () {
                  context.read<CountriesCubit>().sortCountries(SortCriteria.population);
                  Navigator.pop(context);
                },
              ),
              const SizedBox(height: 8),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSortOption(
    BuildContext context, {
    required String title,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    final isDarkMode = Provider.of<ThemeProvider>(context, listen: false).isDarkMode;
    const selectedColor = Color(0xFF007AFF);
    
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 8),
      leading: Container(
        width: 24,
        height: 24,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: isSelected ? selectedColor : (isDarkMode ? Colors.grey[600]! : Colors.grey[400]!),
            width: 2,
          ),
        ),
        child: isSelected
            ? Container(
                margin: const EdgeInsets.all(4),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: selectedColor,
                ),
              )
            : null,
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
          color: isSelected ? selectedColor : (isDarkMode ? Colors.white : Colors.black),
        ),
      ),
      onTap: onTap,
    );
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
              title: const Text('Countries'),
              centerTitle: true,
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
              leading: BlocBuilder<CountriesCubit, CountriesState>(
                builder: (context, state) {
                  return IconButton(
                    icon: const Icon(Icons.sort, size: 25),
                    onPressed: state.countries.isEmpty ? null : () => _showSortBottomSheet(context),
                    tooltip: 'Sort countries',
                  );
                },
              ),
              actions: const [
                ThemeToggleButton(),
              ],
            );
          },
        ),
      ),
      body: BlocBuilder<CountriesCubit, CountriesState>(
        builder: (context, state) {
          return Consumer<ThemeProvider>(
            builder: (context, themeProvider, child) {
              final isDarkMode = themeProvider.isDarkMode;
              if (state.isLoading && state.countries.isEmpty) {
                return Container(
                  color: isDarkMode ? const Color(0xFF1E1E1E) : Colors.white,
                  child: ListView.builder(
                    itemCount: 10,
                    itemBuilder: (_, __) => ShimmerCountryTile(isDarkMode: isDarkMode),
                  ),
                );
              }
              if (state.isError && state.countries.isEmpty) {
                return Container(
                  color: isDarkMode ? const Color(0xFF1E1E1E) : Colors.white,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.error_outline,
                          size: 64,
                          color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Failed to load countries',
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () => context.read<CountriesCubit>().getAllCountries(),
                          child: const Text('Retry'),
                        ),
                      ],
                    ),
                  ),
                );
              }
              return Container(
                color: isDarkMode ? const Color(0xFF1E1E1E) : Colors.white,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: TextField(
                        controller: _searchController,
                        focusNode: _focusNode,
                        onChanged: _onSearchChanged,
                        style: TextStyle(
                          color: isDarkMode ? Colors.white : Colors.black,
                        ),
                        decoration: InputDecoration(
                          hintText: 'Search for a country',
                          hintStyle: TextStyle(
                            color: isDarkMode ? Colors.grey[400] : const Color(0xff6B7582),
                          ),
                          prefixIcon: Icon(
                            Icons.search_outlined,
                            size: 25,
                            color: isDarkMode ? Colors.grey[400] : const Color(0xff6B7582),
                          ),
                          suffixIconColor: isDarkMode ? Colors.grey[400] : const Color(0xff6B7582),
                          filled: true,
                          fillColor: isDarkMode ? const Color(0xFF2D2D2D) : const Color(0xfff2f2f5),
                          isDense: true,
                          contentPadding: const EdgeInsets.symmetric(vertical: 12),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide.none,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide.none,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide.none,
                          ),
                          suffixIcon: state.searchQuery.isNotEmpty
                              ? IconButton(
                                  icon: Icon(
                                    Icons.cancel,
                                    size: 25,
                                    color: isDarkMode ? Colors.grey[400] : const Color(0xff6B7582),
                                  ),
                                  onPressed: () => _clearSearchAndDismissKeyboard(context),
                                )
                              : null,
                        ),
                      ),
                    ),
                    if (state.countries.isNotEmpty) ...[
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '${state.filteredCountries.length} countries',
                              style: TextStyle(
                                color: isDarkMode ? Colors.grey[400] : const Color(0xFF6B7582),
                                fontSize: 14,
                              ),
                            ),
                            BlocBuilder<CountriesCubit, CountriesState>(
                              builder: (context, state) {
                                final sortText = state.sortCriteria == SortCriteria.name
                                    ? 'Sorted by: Name'
                                    : 'Sorted by: Population';
                                return Text(
                                  sortText,
                                  style: TextStyle(
                                    color: isDarkMode ? Colors.grey[400] : const Color(0xFF6B7582),
                                    fontSize: 14,
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),
                    ],
                    Expanded(
                      child: RefreshIndicator(
                        onRefresh: () => context.read<CountriesCubit>().getAllCountries(),
                        child: state.filteredCountries.isEmpty && !state.isLoading
                            ? Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(24.0),
                                  child: Column(
                                    children: [
                                      Icon(
                                        Icons.search_off,
                                        size: 64,
                                        color: isDarkMode ? Colors.grey[400] : const Color(0xFF6B7582),
                                      ),
                                      const SizedBox(height: 16),
                                      Text(
                                        'No countries found',
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500,
                                          color: isDarkMode ? Colors.white : Colors.black,
                                        ),
                                      ),
                                      Text(
                                        'Try a different search term',
                                        style: TextStyle(
                                          color: isDarkMode ? Colors.grey[400] : const Color(0xFF6B7582),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            : ListView.builder(
                                itemCount: state.filteredCountries.length,
                                itemBuilder: (context, index) {
                                  final country = state.filteredCountries[index];
                                  return BlocSelector<FavoritesCubit, FavoritesState, bool>(
                                    selector: (favState) => favState.favoriteCodes.contains(country.cca2),
                                    builder: (context, isFavorite) {
                                      return CountryListTile(
                                        country: country,
                                        isFavoriteView: false,
                                        isFavorite: isFavorite,
                                        isDarkMode: isDarkMode, // Pass dark mode state
                                        onTap: () {
                                          final image = NetworkImage(country.flag);
                                          precacheImage(image, context).then((_) {
                                            Navigator.push(
                                              // ignore: use_build_context_synchronously
                                              context,
                                              MaterialPageRoute(
                                                builder: (_) => BlocProvider(
                                                  create: (_) => GetIt.I<CountryDetailCubit>(),
                                                  child: CountryDetailScreen(code: country.cca2),
                                                ),
                                              ),
                                            );
                                          });
                                        },
                                        onToggleFavorite: () => context.read<FavoritesCubit>().toggleFavorite(country.cca2),
                                      );
                                    },
                                  );
                                },
                              ),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}