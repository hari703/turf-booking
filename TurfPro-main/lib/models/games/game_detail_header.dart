import 'package:flutter/material.dart';

class GameDetailHeader extends StatelessWidget {
  const GameDetailHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundImage: NetworkImage('https://example.com/avatar.jpg'),
            ),
            SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Abhidev P',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text('Host'),
                Text('AZCO Games'),
              ],
            ),
          ],
        ),
        SizedBox(height: 16),
        Row(
          children: [
            Icon(Icons.sports_soccer),
            SizedBox(width: 8),
            Text('Cricket | 7AM - 9AM'),
            SizedBox(width: 16),
            Text('₹700 per head'),
          ],
        ),
        SizedBox(height: 8),
        Row(
          children: [
            Icon(Icons.people),
            SizedBox(width: 8),
            Text('4/10 Going'),
          ],
        ),
      ],
    );
  }
}