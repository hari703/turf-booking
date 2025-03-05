import 'package:flutter/material.dart';
import 'turf.dart';
import 'package:turfpro/screen/turf_details/turf_details_screen.dart';

class TurfCard extends StatelessWidget {
  final Turf turf;

  const TurfCard({super.key, required this.turf});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        width: 280,
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                _buildImage(),
                Positioned(
                  top: 8,
                  left: 8,
                  child: Container(
                    color: Colors.black54,
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    child: Text(
                      turf.discount,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.black54,
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.star, color: Colors.white),
                        Text(
                          turf.rating.toString(),
                          style: const TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    turf.name,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(turf.location),
                  Text(turf.openHours),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed: () {},
                        style: ButtonStyle(
                          backgroundColor: WidgetStateProperty.all<Color>(Colors.green),
                        ),
                        child: const Text('Book now'),
                      ),
                      OutlinedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => TurfDetailsScreen(turf: turf),
                            ),
                          );
                        },
                        child: const Text('More details'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
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
        height: 115,
      );
    } else {
      return Image.asset(
        turf.imageUrl, 
        fit: BoxFit.cover,
        width: double.infinity,
        height: 115,
      );
    }
  }
}
