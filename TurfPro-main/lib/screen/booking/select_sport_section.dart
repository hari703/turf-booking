import 'package:flutter/material.dart';

class SelectSportSection extends StatelessWidget {
  const SelectSportSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Choose your sport', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: [
            _buildChip('Football'),
            _buildChip('Cricket'),
            _buildChip('Badminton'),
            _buildChip('Billiards'),
            _buildChip('Table Tennis'),
          ],
        ),
      ],
    );
  }

  Widget _buildChip(String label) {
    return ChoiceChip(
      label: Text(label),
      selected: false,
    );
  }
}