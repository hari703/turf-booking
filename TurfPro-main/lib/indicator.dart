import 'package:flutter/material.dart';

class IndicatorWidget extends StatelessWidget {
  final int currentStep;
  final int totalSteps;

  const IndicatorWidget({
    super.key,
    required this.currentStep,
    required this.totalSteps,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        LinearProgressIndicator(
          value: currentStep / totalSteps,
          backgroundColor: Colors.grey[300],
          valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
        ),
        const SizedBox(height: 10),
        Text('Step $currentStep of $totalSteps'),
      ],
    );
  }
}
