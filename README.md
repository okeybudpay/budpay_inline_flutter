# BudPay Inline Flutter Plugin

A Flutter plugin that provides a seamless integration of BudPay's inline payment system for **Android** and **iOS** platforms. This plugin wraps the existing BudPay JavaScript inline payment solution within a WebView, allowing you to accept payments in your Flutter applications with ease.

---

## Table of Contents

- [Features](#features)
- [Installation](#installation)
- [Getting Started](#getting-started)
- [Usage](#usage)
- [API Reference](#api-reference)
- [Platform-specific Setup](#platform-specific-setup)
  - [Android](#android)
  - [iOS](#ios)
- [Permissions](#permissions)
- [Error Handling](#error-handling)
- [Important Notes](#important-notes)
- [Troubleshooting](#troubleshooting)
- [Contributing](#contributing)
- [License](#license)

---

## Features

- **Cross-Platform Support**: Works seamlessly on both Android and iOS platforms.
- **Easy Integration**: Simple and straightforward API to initiate payments.
- **Customizable**: Supports customization options such as custom fields, callback URLs, and more.
- **Error Handling**: Provides callbacks for success, error, and cancellation events.
- **Secure**: Uses BudPay's secure payment infrastructure.

---

## Installation

Add the following to your project's `pubspec.yaml` file:

```yaml
dependencies:
  flutter:
    sdk: flutter
  budpay_inline_flutter: ^0.0.1  # Replace with the latest version
```

Replace `^0.0.1` with the latest version of the plugin as specified on [pub.dev](https://pub.dev/packages/budpay_inline_flutter).

Then run:

```bash
flutter pub get
```

---

## Getting Started

To start using the plugin:

1. **Import the Package**:

   ```dart
   import 'package:budpay_inline_flutter/budpay_inline_flutter.dart';
   ```

2. **Initialize Payment Parameters**:

   Prepare the necessary parameters required by BudPay, such as `publicKey`, `email`, `amount`, etc.

3. **Initiate the Payment**:

   Use the `BudpayInlinePayment` widget to initiate the payment process.

---

## Usage

Here's a step-by-step guide to using the `budpay_inline_flutter` plugin in your Flutter application.

### 1. Import the Plugin

```dart
import 'package:budpay_inline_flutter/budpay_inline_flutter.dart';
```

### 2. Prepare Payment Information

Collect or define the necessary payment information:

- **Public Key**: Obtain your public key from your BudPay dashboard.
- **Customer Details**: Email, first name, last name, etc.
- **Transaction Details**: Amount, currency, reference, etc.

### 3. Create the Payment Widget

Use the `BudpayInlinePayment` widget to initiate the payment process.

```dart
BudpayInlinePayment(
  publicKey: 'YOUR_PUBLIC_KEY',
  email: 'customer@example.com',
  amount: '1000',
  firstName: 'John',
  lastName: 'Doe',
  currency: 'NGN',
  reference: 'unique_transaction_reference',
  onSuccess: (response) {
    // Handle successful payment here
    print('Payment successful: $response');
  },
  onError: (error) {
    // Handle error here
    print('Payment error: $error');
  },
  onCancel: () {
    // Handle cancellation here
    print('Payment cancelled by user');
  },
  customFields: {
    'custom_field_1': 'value1',
    'custom_field_2': 'value2',
  },
)
```

### 4. Navigate to the Payment Screen

You can navigate to a new screen to display the payment widget.

```dart
Navigator.of(context).push(
  MaterialPageRoute(
    builder: (context) => BudpayInlinePayment(
      // ... parameters ...
    ),
  ),
);
```

---

## API Reference

### BudpayInlinePayment

A widget that initiates the BudPay inline payment process.

#### Constructor Parameters

| Parameter      | Type                       | Required | Description                                                                 |
| -------------- | -------------------------- | -------- | --------------------------------------------------------------------------- |
| `publicKey`    | `String`                   | Yes      | Your BudPay public key.                                                     |
| `email`        | `String`                   | Yes      | Customer's email address.                                                   |
| `amount`       | `String`                   | Yes      | Amount to be charged (as a string).                                         |
| `firstName`    | `String?`                  | No       | Customer's first name.                                                      |
| `lastName`     | `String?`                  | No       | Customer's last name.                                                       |
| `currency`     | `String`                   | Yes      | Currency code (e.g., `NGN`, `USD`).                                         |
| `reference`    | `String?`                  | No       | Unique transaction reference. If not provided, BudPay will generate one.    |
| `logoUrl`      | `String?`                  | No       | URL to your custom logo to display in the payment popup.                    |
| `callbackUrl`  | `String?`                  | No       | URL for BudPay to send payment notifications.                               |
| `customFields` | `Map<String, dynamic>?`    | No       | Additional custom fields as key-value pairs.                                |
| `onSuccess`    | `Function(dynamic)`        | Yes      | Callback function invoked on successful payment.                            |
| `onError`      | `Function(dynamic)`        | Yes      | Callback function invoked when an error occurs.                             |
| `onCancel`     | `Function()`               | Yes      | Callback function invoked when the payment is canceled by the user.         |

---

## Platform-specific Setup

### Android

#### 1. **Internet Permission**

Add the following permission to your app's `AndroidManifest.xml` file to allow network access:

```xml
<manifest xmlns:android="http://schemas.android.com/apk/res/android"
    package="com.example.your_app">
    <!-- Add this line -->
    <uses-permission android:name="android.permission.INTERNET"/>
    <!-- Existing content -->
</manifest>
```

#### 2. **WebView Initialization (Optional)**

If you encounter issues with the WebView on Android, you can specify the WebView implementation:

```dart
import 'dart:io';
import 'package:webview_flutter/webview_flutter.dart';

@override
void initState() {
  super.initState();

  if (Platform.isAndroid) {
    WebView.platform = AndroidWebView();
  }

  // Rest of your initialization code
}
```

### iOS

#### 1. **App Transport Security Settings**

To allow your app to load web content, update the `Info.plist` file:

```xml
<key>NSAppTransportSecurity</key>
<dict>
    <key>NSAllowsArbitraryLoads</key>
    <true/>
</dict>
```

#### 2. **WKWebView Configuration (Optional)**

Ensure that the WebView is properly configured in your Flutter project. In most cases, the default configuration is sufficient.

---

## Permissions

Ensure the following permissions are set:

- **Android**: Internet access (`android.permission.INTERNET`).
- **iOS**: Network access configurations in `Info.plist`.

---

## Error Handling

Implement the `onError` callback to handle errors during the payment process.

```dart
onError: (error) {
  // Handle error
  print('Payment error: $error');
}
```

Possible error scenarios:

- Network issues.
- Payment failures.
- Unexpected responses.

Ensure that you provide meaningful feedback to the user and handle errors gracefully.

---

## Important Notes

- **Test Mode vs. Live Mode**: Use your BudPay test public key for testing and switch to the live public key for production.
- **Currency**: Ensure that the currency code you provide is supported (`NGN`, `GHS`, `USD`, etc.).
- **Amount Format**: The `amount` parameter should be a string representing the amount in the smallest currency unit (e.g., kobo for NGN).
- **Platform Support**: This plugin supports **Android** and **iOS** platforms. Web and desktop platforms are not supported.
- **WebView Content**: The plugin uses a WebView to load BudPay's inline payment JavaScript. Ensure that your app allows WebView content to execute JavaScript.

---

## Troubleshooting

### WebView Not Displaying

- Ensure that all required permissions are set.
- Check for any errors in the console.
- Verify network connectivity.

### Payment Not Processing

- Confirm that your public key is correct.
- Ensure that the amount and other parameters are valid.
- Check BudPay's service status.

### Error Messages

- Implement comprehensive error handling.
- Log errors for debugging purposes.
- Provide user-friendly error messages.

---

## Contributing

Contributions are welcome! Please follow these steps:

1. **Fork the Repository**:

   Click the "Fork" button at the top right corner of the repository page.

2. **Create a New Branch**:

   ```bash
   git checkout -b feature/your-feature
   ```

3. **Commit Your Changes**:

   ```bash
   git commit -am 'Add a feature'
   ```

4. **Push to the Branch**:

   ```bash
   git push origin feature/your-feature
   ```

5. **Open a Pull Request**:

   Go to the repository on GitHub and click "Compare & pull request".

---

## License

This project is licensed under the MIT License.

---


For any issues or questions, please create an issue on the [GitHub repository](https://github.com/okeybudpay/budpay_inline_flutter/issues).

---

## Contact

If you have any questions or need support, please contact:

- **Email**: [developers@budpay.com](mailto:developers@budpay.com)
- **GitHub**: [https://github.com/okeybudpay](https://github.com/okeybudpay)

---

## Changelog

Please see the [Changelog](https://pub.dev/packages/budpay_inline_flutter/changelog) for more information on version updates.

---

## Additional Resources

- **BudPay Documentation**: [https://devs.budpay.com/](https://devs.budpay.com/)
- **Flutter WebView Documentation**: [https://pub.dev/packages/webview_flutter](https://pub.dev/packages/webview_flutter)
- **Flutter Documentation**: [https://flutter.dev/docs](https://flutter.dev/docs)

---

Thank you for using `budpay_inline_flutter`! We hope it makes integrating BudPay payments into your Flutter app easier. Happy coding!