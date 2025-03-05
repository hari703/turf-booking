import 'package:flutter/material.dart';
import 'package:turfpro/models/turf/app_bar.dart';  
import 'package:turfpro/models/turf/bottom_nav.dart';
import 'package:turfpro/models/turf/turf_card.dart'; 
import 'package:turfpro/models/turf/turf.dart'; 

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Create example Turf objects
    final List<Turf> turfs = [
      Turf(
        id: '1', // Ensure ID is included
        name: 'AZCO Games Arena',
        imageUrl: 'https://imgs.search.brave.com/EYI5-k0ttSZMbuDVg_DNrxwAfuT9lkRsgAC6yO6JBAQ/rs:fit:500:0:0:0/g:ce/aHR0cHM6Ly90NC5m/dGNkbi5uZXQvanBn/LzA3LzE1LzExLzEx/LzM2MF9GXzcxNTEx/MTEwN19rUk1xdXZY/bmgyVU92Yjk1d3BI/bExpcjdkVWhvb3Bj/OC5qcGc',
        games: 'Football, Basketball',
        location: 'Keezhmadam (2km)',
        openHours: '7AM - 11PM',
        discount: 'Upto 10% off',
        rating: 4.2,
      ),
      Turf(
        id: '2', // Ensure ID is included
        name: 'ABC Turf',
        imageUrl: 'https://example.com/image.jpg',
        games: 'Cricket, Tennis',
        location: 'Downtown (1km)',
        openHours: '6AM - 10PM',
        discount: 'Upto 15% off',
        rating: 4.5,
      ),
    ];

    return Scaffold(
      appBar: const CustomAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: 'Search for turfs, games...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide.none,
                ),
                fillColor: Colors.grey[200],
                filled: true,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Browse by sports',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FilterChip(label: const Text('Football'), onSelected: (val) {}),
                FilterChip(label: const Text('Cricket'), onSelected: (val) {}),
                FilterChip(label: const Text('Badminton'), onSelected: (val) {}),
              ],
            ),
            const SizedBox(height: 16),
            const Text(
              'Nearby turfs',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: turfs.map((turf) => TurfCard(turf: turf)).toList(),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Nearby games',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: turfs.map((turf) => TurfCard(turf: turf)).toList(),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const CustomBottomNavBar(),
    );
  }
}
