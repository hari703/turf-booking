import 'package:flutter/material.dart';
import 'package:turfpro/indicator.dart';
import 'package:turfpro/screen/home/homescreen.dart';

class ReadyScreen extends StatelessWidget {
  const ReadyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('You Are Ready!'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const IndicatorWidget(currentStep: 4, totalSteps: 4),
            const SizedBox(height: 20),
            const Text(
              'You are all set to play!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            Image.asset(
              'assests/images/Play.png',
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 20),
            const Text(
              'Let\'s get started with your first booking.',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const HomeScreen()),
                );
                
              },
              child: const Text('Start Booking'),
            ),
          ],
        ),
      ),
    );
  }
}
