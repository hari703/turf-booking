import 'package:flutter/material.dart';
import 'package:turfpro/colors.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final bool isDarkMode = theme.brightness == Brightness.dark;
    return Column(
      children: [
        Icon(
          Icons.sports_soccer,
          size: 50,
          color: isDarkMode ? AppColors.darkPrimary : AppColors.lightPrimary,
        ),
        const SizedBox(height: 10),
        Text(
          'TurfPro',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: isDarkMode ? AppColors.darkPrimary : AppColors.lightPrimary, 
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
