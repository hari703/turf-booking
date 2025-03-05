import 'package:flutter/material.dart';
import 'package:turfpro/colors.dart'; 

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    // Determine if the current theme is dark or light
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return AppBar(
      backgroundColor: isDarkMode ? AppColors.darkSurface : AppColors.lightSurface,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        color: isDarkMode ? AppColors.darkOnSurface : AppColors.lightOnSurface,
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.more_vert),
          color: isDarkMode ? AppColors.darkOnSurface : AppColors.lightOnSurface,
          onPressed: () {},
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
