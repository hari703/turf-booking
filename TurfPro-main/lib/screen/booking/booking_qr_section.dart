import 'package:flutter/material.dart';

class BookingQRSection extends StatelessWidget {
  const BookingQRSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          color: Colors.blue,
          width: 200.0,
          height: 200.0,
          child: const Center(
            child: Text(
              'QR Code Placeholder',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
        const SizedBox(height: 16),
        const Text('Scan this code to show to the turf venue officials.'),
        const SizedBox(height: 16),
        const Text('Have a great game!'),
      ],
    );
  }
}
