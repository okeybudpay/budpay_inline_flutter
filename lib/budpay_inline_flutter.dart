// ignore_for_file: library_private_types_in_public_api

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:convert';

class BudpayInlinePayment extends StatefulWidget {
  final String publicKey;
  final String email;
  final String amount;
  final String? firstName;
  final String? lastName;
  final String currency;
  final String? reference;
  final String? logoUrl;
  final String? callbackUrl;
  final Map<String, dynamic>? customFields;
  final Function(dynamic response) onSuccess;
  final Function(dynamic response) onError;
  final Function() onCancel;

  const BudpayInlinePayment({
    super.key,
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
  });

  @override
  _BudpayInlinePaymentState createState() => _BudpayInlinePaymentState();
}

class _BudpayInlinePaymentState extends State<BudpayInlinePayment> {
  late final WebViewController _webViewController;
  bool _isLoading = true;

  late String _localFilePath;

  @override
  void initState() {
    super.initState();
    _createLocalHtmlFile().then((_) {
      setState(() {
        _initializeWebView();
      });
    });
  }

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
            setState(() {
              _isLoading = false;
            });
          },
        ),
      )
      ..loadFile(_localFilePath);
  }

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
      appBar: AppBar(
        title: const Text('BudPay Payment'),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            widget.onCancel();
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Stack(
        children: [
          // ignore: unnecessary_null_comparison
          if (_webViewController != null)
            WebViewWidget(controller: _webViewController),
          if (_isLoading) const Center(child: CircularProgressIndicator()),
        ],
      ),
    );
  }

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
