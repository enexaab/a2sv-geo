import 'package:a2sv_geo/presentation/features/favorites/cubit/favorites_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/utils/formatters.dart';
import '../../../domain/models/country_summary.dart';

class CountryListTile extends StatelessWidget {
  final CountrySummary country;
  final bool isFavoriteView;
  final Function()? onTap;
  final Function()? onToggleFavorite;
  final bool isFavorite;
  final bool isDarkMode; // Add dark mode parameter

  const CountryListTile({
    super.key,
    required this.country,
    this.isFavoriteView = false,
    this.onTap,
    this.onToggleFavorite, 
    required this.isFavorite,
    required this.isDarkMode, // Add to constructor
  });

  @override
  Widget build(BuildContext context) {
    return BlocSelector<FavoritesCubit, FavoritesState, bool>(
      selector: (state) => state.favoriteCodes.contains(country.cca2),
      builder: (context, isCurrentlyFavorite) {
        
        final bool shouldShowFilledHeart;
        if (isFavoriteView) {
          shouldShowFilledHeart = false;
        } else {
          shouldShowFilledHeart = isCurrentlyFavorite;
        }

        return Card(
          color: isDarkMode ? const Color(0xFF1E1E1E) : Colors.white,
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          elevation: 0,
          child: ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Image.network(
                country.flag,
                width: 60,
                height: 45,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  width: 60,
                  height: 45,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    gradient: LinearGradient(
                      colors: [Colors.blue.shade200, Colors.pink.shade200],
                    ),
                  ),
                  child: Icon(Icons.flag, size: 36, color: isDarkMode ? Colors.white : Colors.grey),
                ),
              ),
            ),
            title: Text(
              country.name,
              style: TextStyle(
                fontSize: 16, 
                fontWeight: FontWeight.w600,
                color: isDarkMode ? Colors.white : Colors.black,
              ),
            ),
            subtitle: Text(
              isFavoriteView ? 'Capital: ${country.capital}' : 'Population: ${Formatters.formatPopulation(country.population)}',
              style: TextStyle(
                fontSize: 14, 
                color: isDarkMode ? Colors.grey[400] : AppConstants.textSecondary,
              ),
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  onPressed: onToggleFavorite,
                  icon: Icon(
                    shouldShowFilledHeart ? Icons.favorite : Icons.favorite_border,
                    color: shouldShowFilledHeart ? AppConstants.primaryColor : (isDarkMode ? Colors.grey[400] : AppConstants.textPrimary),
                  ),
                ),
              ],
            ),
            onTap: onTap,
          ),
        );
      },
    );
  }
}