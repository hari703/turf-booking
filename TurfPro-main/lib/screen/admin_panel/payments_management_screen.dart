import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:turfpro/models/payment_model.dart';
import 'dart:convert';

class PaymentManagementScreen extends StatefulWidget {
  const PaymentManagementScreen({super.key});

  @override
  PaymentManagementScreenState createState() => PaymentManagementScreenState();
}

class PaymentManagementScreenState extends State<PaymentManagementScreen> {
  List<PaymentModel> payments = [];

  @override
  void initState() {
    super.initState();
    fetchPayments();
  }

  Future<void> fetchPayments() async {
    try {
      final response = await http.get(Uri.parse('http://localhost:3000/api/payments'));

      if (response.statusCode == 200) {
        final List<dynamic> paymentList = json.decode(response.body);
        setState(() {
          payments = paymentList.map((payment) => PaymentModel.fromJson(payment)).toList();
        });
      } else {
        throw Exception('Failed to load payments');
      }
    } catch (e) {
      debugPrint(e.toString()); // ✅ Fixed the print issue
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment Management'),
      ),
      body: ListView.builder(
        itemCount: payments.length,
        itemBuilder: (context, index) {
          var payment = payments[index];
          return ListTile(
            title: Text(payment.customerName),
            subtitle: Text('Amount: \$${payment.amount}'),
            trailing: Text(payment.status),
            onTap: () {
              // Handle payment details or update functionality
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Handle creating a new payment
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('Add Payment'),
                content: PaymentForm(onSubmit: (payment) {
                  setState(() {
                    payments.add(payment);
                  });
                  Navigator.of(context).pop();
                }),
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class PaymentForm extends StatefulWidget {
  final Function(PaymentModel) onSubmit;

  const PaymentForm({super.key, required this.onSubmit});

  @override
  PaymentFormState createState() => PaymentFormState();
}

class PaymentFormState extends State<PaymentForm> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  String _status = 'Pending';

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TextField(
          controller: _nameController,
          decoration: const InputDecoration(labelText: 'Customer Name'),
        ),
        TextField(
          controller: _amountController,
          decoration: const InputDecoration(labelText: 'Amount'),
          keyboardType: TextInputType.number,
        ),
        DropdownButton<String>(
          value: _status,
          onChanged: (String? newValue) {
            setState(() {
              _status = newValue!;
            });
          },
          items: <String>['Pending', 'Completed']
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
        ElevatedButton(
          onPressed: () {
            final payment = PaymentModel(
              id: DateTime.now().toString(),
              customerName: _nameController.text,
              amount: double.tryParse(_amountController.text) ?? 0,
              status: _status,
            );
            widget.onSubmit(payment);
          },
          child: const Text('Add Payment'),
        ),
      ],
    );
  }
}
