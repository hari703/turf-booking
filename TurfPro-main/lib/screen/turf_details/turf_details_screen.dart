import 'package:flutter/material.dart';
import 'package:turfpro/models/turf/turf.dart';
import 'package:turfpro/screen/booking/booking_screen.dart';
import 'app_bar.dart';
import 'action_buttons.dart';
import 'ameinties_section.dart';
import 'offers_section.dart';
import 'reviews_section.dart';
import 'sports_section.dart';
import 'package:turfpro/colors.dart'; 

class TurfDetailsScreen extends StatelessWidget {
  final Turf turf; 

  const TurfDetailsScreen({super.key, required this.turf});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: const CustomAppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildImage(), 
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    turf.name, 
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: isDarkMode ? AppColors.darkOnSurface : AppColors.lightOnSurface,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${turf.location} • ${turf.openHours} • ★ ${turf.rating.toStringAsFixed(1)}',
                    style: const TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(height: 16),
                  const ActionButtons(),
                  const SizedBox(height: 16),
                  const SportsSection(),
                  const SizedBox(height: 16),
                  const AmenitiesSection(),
                  const SizedBox(height: 16),
                  const OffersSection(),
                  const SizedBox(height: 16),
                  const Text(
                    'Description provided by the owner',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Azco - The Games Arena has the below mentioned facilities: ...',
                    style: TextStyle(
                      color: isDarkMode ? AppColors.darkOnSurface : AppColors.lightOnSurface,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const ReviewsSection(),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: isDarkMode ? AppColors.darkPrimary : AppColors.lightPrimary,
            padding: const EdgeInsets.symmetric(vertical: 16.0),
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const BookingScreen()),
            );
          },
          child: const Text('Book now', style: TextStyle(fontSize: 18)),
        ),
      ),
    );
  }

  Widget _buildImage() {
    if (turf.imageUrl.startsWith('http')) {
      return Image.network(
        turf.imageUrl,
        fit: BoxFit.cover,
        width: double.infinity,
      );
    } else {
      return Image.asset(
        turf.imageUrl,
        fit: BoxFit.cover,
        width: double.infinity,
      );
    }
  }
}
