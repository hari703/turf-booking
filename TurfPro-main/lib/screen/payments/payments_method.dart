import 'package:flutter/material.dart';

class PaymentMethodSection extends StatefulWidget {
  const PaymentMethodSection({super.key});

  @override
  PaymentMethodSectionState createState() => PaymentMethodSectionState();
}

class PaymentMethodSectionState extends State<PaymentMethodSection> {
  int _selectedPaymentMethod = 1; // Default selected payment method

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Payment Method', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        const SizedBox(height: 16),
        ListTile(
          leading: const Icon(Icons.credit_card),
          title: const Text('Credit Card'),
          trailing: Radio(
            value: 1,
            groupValue: _selectedPaymentMethod,
            onChanged: (int? value) {
              setState(() {
                _selectedPaymentMethod = value!;
              });
            },
          ),
        ),
        ListTile(
          leading: const Icon(Icons.account_balance_wallet),
          title: const Text('Wallet'),
          trailing: Radio(
            value: 2,
            groupValue: _selectedPaymentMethod,
            onChanged: (int? value) {
              setState(() {
                _selectedPaymentMethod = value!;
              });
            },
          ),
        ),
        ListTile(
          leading: const Icon(Icons.attach_money),
          title: const Text('Cash'),
          trailing: Radio(
            value: 3,
            groupValue: _selectedPaymentMethod,
            onChanged: (int? value) {
              setState(() {
                _selectedPaymentMethod = value!;
              });
            },
          ),
        ),
      ],
    );
  }
}
