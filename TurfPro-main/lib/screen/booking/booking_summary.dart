import 'package:flutter/material.dart';
import 'package:turfpro/screen/payments/payments_screen.dart';

class BookingSummaryPage extends StatelessWidget {
  final String selectedSport;
  final DateTime selectedDate;
  final String selectedTimeSlot;
  final bool isFullCourt;
  final double subTotal;
  final double discount;
  final double payableAmount;
  final double advancePayment;

  const BookingSummaryPage({super.key, 
    required this.selectedSport,
    required this.selectedDate,
    required this.selectedTimeSlot,
    required this.isFullCourt,
    required this.subTotal,
    required this.discount,
    required this.payableAmount,
    required this.advancePayment,
  });

  final Color whatsAppGreen = const Color(0xFF075E54);
  final Color whatsAppLightGreen = const Color(0xFF25D366);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Review'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: whatsAppGreen,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Image.network(
                  'https://via.placeholder.com/100', // Placeholder image URL
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                ),
                const SizedBox(width: 16),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'AZCO Games Arena',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Text('Keezhnadam'),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text('Chosen sport: $selectedSport'),
            Text('Selected date: ${selectedDate.toLocal()}'.split(' ')[0]),
            Text('Selected time slot: $selectedTimeSlot'),
            Text('Selected court size: ${isFullCourt ? 'Full court' : 'Half court'}'),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.green[100],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  const Icon(Icons.check_circle, color: Colors.green),
                  const SizedBox(width: 8),
                  const Text('FIRSTBUY'),
                  const Spacer(),
                  const Text('Offer applied'),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () {
                      // Handle offer removal
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Sub total'),
                Text('₹$subTotal'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Discount'),
                Text('₹$discount'),
              ],
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('To pay (total)'),
                Text('₹$payableAmount'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('To pay (in advance)'),
                Text('₹$advancePayment'),
              ],
            ),
            const Spacer(),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      // Handle advance payment
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: whatsAppLightGreen,
                    ),
                    child: const Text('Pay advance'),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const PaymentScreen()),
                );
                    },
                    style: OutlinedButton.styleFrom(
                      foregroundColor: whatsAppGreen, side: BorderSide(color: whatsAppGreen),
                    ),
                    child: const Text('Pay full amount'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
