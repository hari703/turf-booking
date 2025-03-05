import 'package:flutter/material.dart';
import 'package:turfpro/models/turf/bottom_nav.dart';
import 'nearby_games.dart'; 

class Sports extends StatelessWidget {
  const Sports({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chokli'),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              // Handle notifications
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                decoration: InputDecoration(
                  hintText: 'Search for games, hosts ...',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text('Upcoming games', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              const Center(child: Text('No games here yet.')),
              const Center(child: Text('Create a game or join a nearby game.')),
              const SizedBox(height: 20),
              const Text('Browse by sports', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              const SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    SportCard(sport: 'Football'),
                    SportCard(sport: 'Cricket'),
                    SportCard(sport: 'Badminton'),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              const Text('Nearby games', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              const NearbyGames(), // Use the NearbyGames widget here
            ],
          ),
        ),
      ),
      bottomNavigationBar: const CustomBottomNavBar()
    );
  }
}

class SportCard extends StatelessWidget {
  final String sport;

  const SportCard({super.key, required this.sport});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const Icon(Icons.sports_soccer),
            const SizedBox(height: 10),
            Text(sport),
          ],
        ),
      ),
    );
  }
}
