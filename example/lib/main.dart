import 'package:flutter/material.dart';
import 'package:budpay_inline_flutter/budpay_inline_flutter.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final TextEditingController emailController =
      TextEditingController(text: 'test@example.com');
  final TextEditingController amountController =
      TextEditingController(text: '1000');

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BudPay Inline Flutter Example',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('BudPay Inline Flutter Example'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Builder(
            builder: (context) => Column(
              children: [
                TextField(
                  controller: emailController,
                  decoration:
                      const InputDecoration(labelText: 'E-mail Address'),
                ),
                TextField(
                  controller: amountController,
                  decoration: const InputDecoration(labelText: 'Amount'),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    _startPayment(context);
                  },
                  child: const Text('Pay'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _startPayment(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => BudpayInlinePayment(
          publicKey:
              'pk_test_xolsnu5dpqpia2a7a8iftygugzyluz2qffkhlid', // Replace with your public key
          email: emailController.text,
          amount: amountController.text,
          firstName: 'John',
          lastName: 'Doe',
          currency: 'NGN',
          reference: DateTime.now().millisecondsSinceEpoch.toString(),
          onSuccess: (response) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                  content: Text(
                      'Payment complete! Reference: ${response['reference']}, Status: ${response['status']}')),
            );
          },
          onCancel: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                  content:
                      Text('Transaction was not completed, window closed.')),
            );
          },
          onError: (error) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('An error occurred: $error')),
            );
          },
          customFields: const {
            'tax_pay_transaction': '',
            'tax_pay_type': '',
            'agency_code': '',
            'revenue_code': '',
            'revenue_credit_acc': '',
            'cbn_code': '',
          },
        ),
      ),
    );
  }
}
