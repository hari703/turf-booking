import 'package:flutter/material.dart';

class OffersSection extends StatelessWidget {
  const OffersSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Offers', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        const SizedBox(height: 8),
        _buildOfferCard('FIRSTBUY', 'Get a 20% off on your first turf booking with TurfPro'),
        const SizedBox(height: 8),
        _buildOfferCard('RAMADAN24', 'Get a 10% off on any of your turf booking during Ramadan'),
      ],
    );
  }

  Widget _buildOfferCard(String code, String description) {
    return Card(
      color: Colors.grey[200],
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            const Icon(Icons.local_offer, color: Colors.green),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(code, style: const TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Text(description),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
