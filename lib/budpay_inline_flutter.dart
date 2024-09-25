/// A Flutter plugin for integrating BudPay's inline payment system.
///
/// Provides the [BudpayInlinePayment] widget to initiate and manage BudPay payments within Flutter apps.

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:convert';

/// A widget that integrates BudPay's inline payment system into your Flutter app.
///
/// This widget opens a WebView that loads the BudPay payment gateway,
/// allowing users to complete transactions within your app.
///
/// Example usage:
/// ```dart
/// BudpayInlinePayment(
///   publicKey: 'your-public-key',
///   email: 'customer@example.com',
///   amount: '1000',
///   currency: 'NGN',
///   reference: 'txn_1234567890',
///   onSuccess: (response) {
///     // Handle successful payment
///   },
///   onError: (error) {
///     // Handle payment error
///   },
///   onCancel: () {
///     // Handle payment cancellation
///   },
/// );
/// ```
class BudpayInlinePayment extends StatefulWidget {
  /// Your BudPay public key.
  final String publicKey;

  /// Customer's email address.
  final String email;

  /// The transaction amount as a string.
  final String amount;

  /// Customer's first name (optional).
  final String? firstName;

  /// Customer's last name (optional).
  final String? lastName;

  /// The currency code (e.g., 'NGN', 'USD').
  final String currency;

  /// Unique transaction reference (optional).
  final String? reference;

  /// Custom logo URL for the payment popup (optional).
  final String? logoUrl;

  /// The URL to which BudPay sends payment notifications (optional).
  final String? callbackUrl;

  /// Additional custom fields as key-value pairs (optional).
  final Map<String, dynamic>? customFields;

  /// Callback function that is called when the payment is successful.
  final Function(dynamic response) onSuccess;

  /// Callback function that is called when an error occurs during the payment process.
  final Function(dynamic response) onError;

  /// Callback function that is called when the user cancels the payment.
  final Function() onCancel;

  /// Creates a new instance of [BudpayInlinePayment].
  ///
  /// The [publicKey], [email], [amount], [currency], [onSuccess], [onError], and [onCancel] parameters are required.
  const BudpayInlinePayment({
    Key? key,
    required this.publicKey,
    required this.email,
    required this.amount,
    this.firstName,
    this.lastName,
    required this.currency,
    this.reference,
    this.logoUrl,
    this.callbackUrl,
    this.customFields,
    required this.onSuccess,
    required this.onError,
    required this.onCancel,
  }) : super(key: key);

  @override
  BudpayInlinePaymentState createState() => BudpayInlinePaymentState();
}

/// The state class for [BudpayInlinePayment].
///
/// Handles the WebView initialization and communication with the BudPay payment gateway.
class BudpayInlinePaymentState extends State<BudpayInlinePayment> {
  late final WebViewController _webViewController;

  late String _localFilePath;
  bool _isControllerReady = false;

  @override
  void initState() {
    super.initState();
    _createLocalHtmlFile().then((_) {
      setState(() {
        _initializeWebView();
      });
    });
  }

  /// Initializes the WebView controller and sets up the JavaScript channel.
  void _initializeWebView() {
    _webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..addJavaScriptChannel(
        'SendMessage',
        onMessageReceived: (JavaScriptMessage message) {
          _handleJavascriptMessage(message.message);
        },
      )
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageFinished: (url) {
            // Handle page load completion if needed
          },
        ),
      )
      ..loadFile(_localFilePath);
    setState(() {
      _isControllerReady = true;
    });
  }

  /// Creates a local HTML file with the necessary content to initiate the BudPay payment.
  Future<void> _createLocalHtmlFile() async {
    final customFieldsJson =
        widget.customFields != null ? jsonEncode(widget.customFields) : '{}';
    final htmlContent = '''
    <!DOCTYPE html>
    <html>
      <head>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <script src="https://inlinepay.budpay.com/budpay-inline-custom.js"></script>
      </head>
      <body onload="payWithBudPay()">
        <script type="text/javascript">
          function payWithBudPay() {
            BudPayCheckout({
              key: '${widget.publicKey}',
              email: '${widget.email}',
              amount: '${widget.amount}',
              first_name: '${widget.firstName ?? ''}',
              last_name: '${widget.lastName ?? ''}',
              currency: '${widget.currency}',
              reference: '${widget.reference ?? ''}',
              logo_url: '${widget.logoUrl ?? ''}',
              callback_url: '${widget.callbackUrl ?? ''}',
              custom_fields: $customFieldsJson,
              callback: function(response) {
                var message = JSON.stringify({'status': 'success', 'response': response});
                SendMessage.postMessage(message);
              },
              onClose: function() {
                var message = JSON.stringify({'status': 'closed'});
                SendMessage.postMessage(message);
              }
            });
          }
        </script>
      </body>
    </html>
    ''';

    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/budpay_payment.html');
    await file.writeAsString(htmlContent);
    _localFilePath = file.path;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          if (_isControllerReady) WebViewWidget(controller: _webViewController),
          Positioned(
            top: 20.0,
            left: 5.0,
            child: IconButton(
              icon: const Icon(Icons.close),
              onPressed: () {
                widget.onCancel();
                Navigator.of(context).pop();
              },
            ),
          ),
        ],
      ),
    );
  }

  /// Handles messages received from the JavaScript code in the WebView.
  ///
  /// Parses the message and triggers the appropriate callbacks.
  void _handleJavascriptMessage(String message) {
    final Map<String, dynamic> result = jsonDecode(message);
    if (result['status'] == 'success') {
      widget.onSuccess(result['response']);
    } else if (result['status'] == 'closed') {
      widget.onCancel();
    } else {
      widget.onError(result);
    }
    Navigator.of(context).pop();
  }
}
