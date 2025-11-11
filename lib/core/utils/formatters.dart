
import 'package:intl/intl.dart'; // <<< ADD THIS IMPORT

class Formatters {
  static String formatPopulation(int population) {
    final double pop = population.toDouble();

    if (pop >= 1000000000) {
      return '${(pop / 1000000000).toStringAsFixed(1)}B';
    } else if (pop >= 1000000) {
      return '${(pop / 1000000).toStringAsFixed(1)}million';
    } else if (pop >= 100000) {
      return '${(pop / 1000).toStringAsFixed(1)}K';
    } else if (pop >= 1000) {
      return '${(pop / 1000).toStringAsFixed(1)}K';
    }
    return population.toString();
  }

  static String formatArea(double area) {
    final int areaInt = area.round();
        final formatter = NumberFormat('#,##0', 'en_US'); 
    
    return '${formatter.format(areaInt)} sq km'; 
  }
}