import 'package:flutter/material.dart';
//import 'package:turfpro/screen/booking/booking_summary.dart';
import 'payments_method.dart';
import 'success.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Review'),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //const BookingSummaryPage(),
            const SizedBox(height: 16),
            const PaymentMethodSection(),
            const Spacer(),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding: const EdgeInsets.symmetric(vertical: 16.0),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SuccessScreen()),
                );
              },
              child: const Text('Pay', style: TextStyle(fontSize: 18)),
            ),
          ],
        ),
      ),
    );
  }
}