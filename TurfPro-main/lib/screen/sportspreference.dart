import 'package:flutter/material.dart';
import 'package:turfpro/indicator.dart';
import 'package:turfpro/header.dart';

class SportsPreferencesScreen extends StatefulWidget {
  const SportsPreferencesScreen({super.key});

  @override
  SportsPreferencesScreenState createState() => SportsPreferencesScreenState();
}

class SportsPreferencesScreenState extends State<SportsPreferencesScreen> {
  final List<Map<String, dynamic>> sports = [
    {'name': 'Football', 'icon': Icons.sports_soccer},
    {'name': 'Cricket', 'icon': Icons.sports_cricket},
    {'name': 'Basketball', 'icon': Icons.sports_basketball},
    {'name': 'Badminton', 'icon': Icons.sports},
    {'name': 'Swimming', 'icon': Icons.pool},
    {'name': 'Table Tennis', 'icon': Icons.sports_tennis_sharp},
    {'name': 'Billiards', 'icon': Icons.sports_golf},
    {'name': 'Tennis', 'icon': Icons.sports_tennis},
  ];

  final Set<String> selectedSports = {};

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const HeaderWidget(),
            const SizedBox(height: 20),
            const IndicatorWidget(currentStep: 2, totalSteps: 4),
            const SizedBox(height: 20),
            const Text(
              'Tell us about your sports interests.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              'Help us personalize your sports experience by telling us about the sports you enjoy playing.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: GridView.count(
                padding: EdgeInsets.fromLTRB(width * 0.15, 10, width * 0.15, 10),
                crossAxisCount: 2,
                childAspectRatio: 1.5,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                children: sports.map((sport) {
                  final isSelected = selectedSports.contains(sport['name']);
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        if (isSelected) {
                          selectedSports.remove(sport['name']);
                        } else {
                          selectedSports.add(sport['name']);
                        }
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: isSelected ? Colors.green[100] : Colors.white,
                        border: Border.all(
                          color: isSelected ? Colors.green : Colors.grey,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            sport['icon'],
                            size: 30,
                            color: isSelected ? Colors.green : Colors.black,
                          ),
                          const SizedBox(height: 10),
                          Text(
                            sport['name'],
                            style: TextStyle(
                              fontSize: 16,
                              color: isSelected ? Colors.green : Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context); 
                  },
                  child: const Text(
                    "I'll do this later",
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/notification_preferences');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                  ),
                  child: const Text('Continue'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
