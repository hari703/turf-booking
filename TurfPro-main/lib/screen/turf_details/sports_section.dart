import 'package:flutter/material.dart';
import 'package:turfpro/colors.dart'; 

class SportsSection extends StatelessWidget {
  const SportsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Available sports', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: [
            _buildChip('Football', isDarkMode),
            _buildChip('Cricket', isDarkMode),
            _buildChip('Badminton', isDarkMode),
            _buildChip('Table Tennis', isDarkMode),
            _buildChip('Billiards', isDarkMode),
          ],
        ),
      ],
    );
  }

  Widget _buildChip(String label, bool isDarkMode) {
    return Chip(
      label: Text(label, style: TextStyle(color: isDarkMode ? AppColors.darkOnSurface : AppColors.lightOnSurface)),
      backgroundColor: isDarkMode ? AppColors.darkContainer : AppColors.lightContainer,
    );
  }
}
