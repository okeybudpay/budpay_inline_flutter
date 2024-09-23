## [0.0.1] - 2024-09-23

### Added

- **Initial Release of `budpay_inline_flutter` Plugin**

  - **BudPay Integration**: Enables Flutter applications to integrate BudPay's inline payment system for **Android** and **iOS** platforms using a WebView.

- **Core Features**

  - **`BudpayInlinePayment` Widget**: A customizable widget to initiate and manage BudPay payments within Flutter apps.
  
  - **Payment Parameters**: Support for essential payment parameters:
    - `publicKey`: Your BudPay public key.
    - `email`: Customer's email address.
    - `amount`: Transaction amount.
    - `firstName` and `lastName`: Customer's name.
    - `currency`: Currency code (e.g., `NGN`, `USD`).
    - `reference`: Unique transaction reference.
    - `logoUrl`: Custom logo URL for the payment popup.
    - `callbackUrl`: Custom callback URL for payment notifications.
    - `customFields`: Additional custom fields as key-value pairs.
  
  - **Callbacks and Event Handling**:
    - `onSuccess`: Callback for successful payment transactions.
    - `onError`: Callback for handling errors during the payment process.
    - `onCancel`: Callback for handling payment cancellations by the user.

- **WebView Integration**

  - Utilizes the latest `webview_flutter` package (`^4.9.0`) for embedding web content.
  - Loads BudPay's inline payment JavaScript securely within the WebView.
  - Handles communication between JavaScript and Flutter using JavaScript channels.

- **Example Application**

  - Provides a comprehensive example app demonstrating how to use the plugin.
  - Includes UI components for collecting payment information and initiating transactions.
  - Showcases handling of success, error, and cancellation events.

- **Documentation**

  - **README**: Detailed instructions on installation, setup, and usage.
  - **API Reference**: Comprehensive documentation of all classes, methods, and parameters.
  - **Platform-specific Setup**: Guidance on required configurations for Android and iOS.
  - **Permissions**: Information on necessary permissions and security settings.
  - **Error Handling**: Best practices for handling errors and providing user feedback.
  - **Troubleshooting**: Tips for resolving common issues.

- **Compatibility**

  - Supports Flutter applications targeting **Android** and **iOS** platforms.
  - Compatible with the latest versions of Flutter and Dart SDK.

- **Additional Features**

  - **Security Considerations**: Adheres to best practices for handling sensitive data.
  - **Customization**: Allows for extensive customization through parameters and custom fields.
  - **Async Initialization**: Ensures resources are loaded and initialized properly before use.

---

**Release Date**: `2024-09-23`