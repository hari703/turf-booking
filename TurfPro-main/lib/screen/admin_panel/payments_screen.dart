import 'package:flutter/material.dart';
import 'package:turfpro/screen/admin_panel/payments_management_screen.dart';


class PaymentsScreen extends StatelessWidget {
  const PaymentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const PaymentManagementScreen()),
          );
        },
        child: const Text('Manage Payments'),
      ),
    );
  }
}