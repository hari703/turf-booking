import 'package:flutter/material.dart';
import 'package:turfpro/colors.dart'; 

class ManagerPanelScreen extends StatelessWidget {
  const ManagerPanelScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Manager Panel'),
        backgroundColor: isDarkMode ? AppColors.darkSurface : AppColors.lightSurface,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            const Text(
              'Welcome to the Manager Panel!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: isDarkMode ? AppColors.darkPrimary : AppColors.lightPrimary,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ViewBookingsScreen()),
                );
              },
              child: const Text('View Bookings'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: isDarkMode ? AppColors.darkPrimary : AppColors.lightPrimary,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ManageTurfsScreen()),
                );
              },
              child: const Text('Manage Turfs'),
            ),
          ],
        ),
      ),
    );
  }
}

class ViewBookingsScreen extends StatelessWidget {
  const ViewBookingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('View Bookings'),
        backgroundColor: isDarkMode ? AppColors.darkSurface : AppColors.lightSurface,
      ),
      body: Center(
        child: Text(
          'List of bookings will be displayed here.',
          style: TextStyle(
            color: isDarkMode ? AppColors.darkOnSurface : AppColors.lightOnSurface,
          ),
        ),
      ),
    );
  }
}

class ManageTurfsScreen extends StatelessWidget {
  const ManageTurfsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage Turfs'),
        backgroundColor: isDarkMode ? AppColors.darkSurface : AppColors.lightSurface,
      ),
      body: Center(
        child: Text(
          'Turfs management options will be displayed here.',
          style: TextStyle(
            color: isDarkMode ? AppColors.darkOnSurface : AppColors.lightOnSurface,
          ),
        ),
      ),
    );
  }
}
