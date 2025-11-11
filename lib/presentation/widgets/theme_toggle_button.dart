// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:a2sv_geo/core/providers/theme_provider.dart';

class ThemeToggleButton extends StatelessWidget {
  const ThemeToggleButton({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    
    return IconButton(
      icon: Icon(
        themeProvider.isDarkMode ? Icons.light_mode : Icons.dark_mode,
        size: 25,
      ),
      onPressed: () {
        themeProvider.toggleTheme();
      },
      tooltip: themeProvider.isDarkMode ? 'Switch to light mode' : 'Switch to dark mode',
    );
  }
}