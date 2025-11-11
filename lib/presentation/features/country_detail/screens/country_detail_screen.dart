
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../country_detail/cubit/country_detail_cubit.dart';
import '../../../../core/utils/formatters.dart';

class CountryDetailScreen extends StatefulWidget {
  final String code;
  const CountryDetailScreen({super.key, required this.code});

  @override
  State<CountryDetailScreen> createState() => _CountryDetailScreenState();
}

class _CountryDetailScreenState extends State<CountryDetailScreen> {
  @override
  void initState() {
    super.initState();
    debugPrint('CountryDetailScreen: Initializing with code: ${widget.code}');
    context.read<CountryDetailCubit>().fetchCountryDetails(widget.code);
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    
    return Scaffold(
      appBar: AppBar(
        title: BlocSelector<CountryDetailCubit, CountryDetailState, String>(
          selector: (state) => state.details?.name ?? 'Loading...',
          builder: (context, name) => Text(name),
        ),
        backgroundColor: isDarkMode ? const Color(0xFF1E1E1E) : Colors.white,
        foregroundColor: isDarkMode ? Colors.white : Colors.black,
        iconTheme: IconThemeData(color: isDarkMode ? Colors.white : Colors.black),
      ),
      body: BlocBuilder<CountryDetailCubit, CountryDetailState>(
        builder: (context, state) {
          if (state.isLoading) {
            return Center(
              child: CircularProgressIndicator(
                color: isDarkMode ? Colors.white : Colors.blue,
              ),
            );
          }
          if (state.isError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
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
                      'Failed to load country details',
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        color: isDarkMode ? Colors.white : Colors.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      state.errorMessage,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: () => context.read<CountryDetailCubit>().fetchCountryDetails(widget.code),
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              ),
            );
          }
          if (state.details == null) {
            return Center(
              child: Text(
                'No details available',
                style: TextStyle(
                  color: isDarkMode ? Colors.white : Colors.black,
                ),
              ),
            );
          }
          final details = state.details!;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              Hero(
                tag: 'flag_${details.name}',
                child: ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    bottom: Radius.circular(12.0),
                    top: Radius.circular(12),
                  ), 
                  child: Image.network(
                    details.flag,
                    height: 250,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      height: 280,
                      color: isDarkMode ? Colors.grey[800] : Colors.grey[200],
                      child: Icon(
                        Icons.flag, 
                        size: 120, 
                        color: isDarkMode ? Colors.grey[400] : Colors.grey,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Key Statistics',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: isDarkMode ? Colors.white : Colors.black,
                        ),
                      ),
                      const SizedBox(height: 16),
                      
                      _buildStatRow('Area', Formatters.formatArea(details.area.toDouble()), isDarkMode),
                      _buildStatRow('Population', Formatters.formatPopulation(details.population), isDarkMode),
                      _buildStatRow('Region', details.region, isDarkMode),
                      _buildStatRow('Sub Region', details.subregion, isDarkMode),
                      
                      const SizedBox(height: 32),
                      
                      Text(
                        'Timezone',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: isDarkMode ? Colors.white : Colors.black,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: details.timezones.map((tz) => Chip(
                          label: Text(
                            tz,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: isDarkMode ? Colors.white : const Color(0xFF121417),
                            ),
                          ),
                          backgroundColor: isDarkMode ? const Color(0xFF2D2D2D) : Colors.white,
                          side: BorderSide(
                            color: isDarkMode ? Colors.grey[700]! : Colors.grey.shade300,
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        )).toList(),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildStatRow(String label, String value, bool isDarkMode) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 16,
              color: isDarkMode ? Colors.grey[400] : const Color(0xFF61758A),
            ),
          ),
          Flexible(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: TextStyle(
                fontSize: 16, 
                color: isDarkMode ? Colors.white : const Color(0xFF121417),
              ),
            ),
          ),
        ],
      ),
    );
  }
}