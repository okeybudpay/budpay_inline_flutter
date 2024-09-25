## [0.0.2] - 2024-09-25

### Changed

- **Updated to Stable Dart and Flutter SDK Versions**
  - Updated `pubspec.yaml` to use stable Dart SDK (`>=3.0.0 <4.0.0`) and Flutter SDK (`>=3.0.0`).
  - Adjusted dev dependencies to ensure compatibility with stable releases.


### Fixed

- **Resolved Linting Issue with Private Type in Public API**
  - Made `BudpayInlinePaymentState` public to comply with Dart's visibility rules.
  - Ensured all public API elements use public types to prevent any exposure of private types.

### Added

- **Comprehensive Documentation**
  - Added detailed documentation comments to all public classes, methods, and properties.
  - Enabled the `public_member_api_docs` lint rule to enforce documentation standards.
  - Improved code readability and maintainability.

---

## [0.0.1] - 2024-09-23

### Added

- **Initial Release of `budpay_inline_flutter` Plugin**

  - **BudPay Integration**: Enables Flutter applications to integrate BudPay's inline payment system for **Android** and **iOS** platforms using a WebView.

- **Core Features**

  - **`BudpayInlinePayment` Widget**: A customizable widget to initiate and manage BudPay payments within Flutter apps.
  - **Payment Parameters**: Support for essential payment parameters:
    - `publicKey`, `email`, `amount`, `firstName`, `lastName`, `currency`, `reference`, `logoUrl`, `callbackUrl`, `customFields`.
  - **Callbacks and Event Handling**:
    - `onSuccess`, `onError`, `onCancel`.

- **WebView Integration**

  - Utilizes `webview_flutter` for embedding web content.
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

**Release Dates:**

- **Version 0.0.2**: 2024-09-25
- **Version 0.0.1**: 2024-09-23
