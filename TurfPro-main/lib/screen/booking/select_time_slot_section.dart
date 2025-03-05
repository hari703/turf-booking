import 'package:flutter/material.dart';

class SelectTimeSlotSection extends StatelessWidget {
  const SelectTimeSlotSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Select time slot', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: [
            _buildTimeSlot('7AM - 8AM'),
            _buildTimeSlot('8AM - 9AM'),
            _buildTimeSlot('9AM - 10AM'),
            _buildTimeSlot('10AM - 11AM'),
            _buildTimeSlot('11AM - 12PM'),
          ],
        ),
      ],
    );
  }

  Widget _buildTimeSlot(String label) {
    return ChoiceChip(
      label: Text(label),
      selected: false,
    );
  }
}