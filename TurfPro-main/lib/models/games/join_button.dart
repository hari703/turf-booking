import 'package:flutter/material.dart';

class JoinButton extends StatelessWidget {
  const JoinButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: () {
              // Handle join action
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
            ),
            child: const Text('Join now'),
          ),
        ),
        const SizedBox(width: 16),
        OutlinedButton(
          onPressed: () {
            // Handle query action
          },
          child: const Text('Add a query'),
        ),
      ],
    );
  }
}