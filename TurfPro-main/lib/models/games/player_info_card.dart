import 'package:flutter/material.dart';

class PlayerInfoCard extends StatelessWidget {
  const PlayerInfoCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Description provided by the host',
              style: TextStyle(
                  fontWeight: FontWeight.bold, fontSize: 18)),
          SizedBox(height: 8),
          Text(
            'This game is being hosted at AZCO Games Arena. New players and old enthusiasts are welcome to join.',
          ),
        ],
      ),
    );
  }
}