# Transact Pay

[![pub package](https://img.shields.io/pub/v/flutter_zoom_drawer.svg)](https://pub.dev/packages/transact_pay) [![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

TransactPay provide innovative and flexible European BIN sponsorship and modular payment, debit, and prepaid services.

## 🌟 Getting Started

To start using this package, add `transact_pay_sdk` dependency to your `pubspec.yaml`

You also need to have `Public key`, `Secret key` ' and `Encryption key`, which can be gotten from the transactpay marchant dashboard

In your implementation you will need to parse the payload and return screen as shown in the example

```yaml
dependencies:
  transact_pay_sdk: "<latest_release>"
```

## 📌 Simple Example (Thanks to @ChidiebereEdeh)

```dart

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:test_transactpay/app_textfield.dart';
import 'package:transact_pay_sdk/transact_pay_sdk.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Test TransactPay",
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late TextEditingController _apiKeyController;
  late TextEditingController _encryptionKeyController;
  late TextEditingController _secretKeyController;
  late TextEditingController _payloadController;

  // Default values
  final String defaultApiKey =
      "PGW-PUBLICKEY-TEST-5D9411AB210740019FF1374C896D86D0";
  final String defaultEncryptionKey =
      "NDA5NiE8UlNBS2V5VmFsdWU+PE1vZHVsdXM+cW5rdlhOWHRYdEF0Mi9RcDB4SzBSUXpXYTVKRWc5T0xTNFBqYzZKcmN1eDg4bmJsd2Fyd0h4dnlrUy9STk92eFltU2ZPTlEzbW9vM1hhaWpXd2IwbnVVOTJ4anBmSzByb0FYaFo0emdHVUdlS081emY4enlncExTYzFqS05MMFNXZHZWYndMeTN3WHJiRTBrSjZJRWVvSThLRSs0anRndzY1R084Z3hJeGpibjhNemI5YVNreFdaSnVMRFRLNzJHcGcxYkwrNDBLYnVNc2tVWlJVTGxhNC84Y1dYSlpId2JINjRWNkNHQlVMMGVQUmQ4dnB3aEhySzhZSlZaRGxuYTdNbmxQVjdoeGg1Q0dabkVsNy91WEJjaGYvTExLOFNyckdnRWN1anFKWEZxMm9nUlEwNzBxN2RmOXBNZ0Q5YXpTK3dya2dBck9wNnVFcXBFQ1NnbXlvb1VMZFV2MTBhQk4xRUN5YTY2UnhuV3dEck5QZktSWjU4ZmFlNnJkelpMaExlajNId2VJRjZYcHpwL280VTlmVDVwOFNWTStHK1FZalFFV0RieldhYzMyMUIxRVhWc2xkMXFFTDJzZEk0UEFWNy9DWUcwS2hvR256NVdyZnNBQ1lRRUFkQm16MXM1NktYZnczV3dYVDJoUE1xWWtTZ2c4ejFiR1AxWTZJeDU3RHViUjdVcDlwc2taV0ptUzdNdkM1NnRHN1F6OUdiNzBjVTRiNXYvYkdBZnNMNUlRanBrc2QyRENsU2U0Vm5oNEcyWE0xeTEzS0gyZWVvNnViMUczdVBUMGtzZ2RxSXRtdjFKcmN3SThWaXJOWG9oeW1xL2xpbWg1VUhDTWhzMUhlUTQwMXIvNWt0S200bDJISFMvdXhNcmZlUmVEVTRWMXVBZTNQRU1jUDg9PC9Nb2R1bHVzPjxFeHBvbmVudD5BUUFCPC9FeHBvbmVudD48L1JTQUtleVZhbHVlPg==";
  final String defaultSecretKey =
      "PGW-SECRETKEY-TEST-AA5F84F420514F7DB6CD7938B398727C";
  final String defaultPayload = jsonEncode({
    "customer": {
      "firstname": "Chidiebere",
      "lastname": "Saleman",
      "mobile": "+2348064255905",
      "country": "NG",
      "email": "example@gmail.com"
    },
    "order": {
      "amount": 245000.00,
      "reference": "A2i1qwk",
      "description": "Desc",
      "currency": "NGN"
    },
    "payment": {"RedirectUrl": "https://urlredirection.com/"}
  });

  @override
  void initState() {
    super.initState();
    _resetFields();
  }

  void _resetFields() {
    setState(() {
      _apiKeyController = TextEditingController(text: defaultApiKey);
      _encryptionKeyController =
          TextEditingController(text: defaultEncryptionKey);
      _secretKeyController = TextEditingController(text: defaultSecretKey);
      _payloadController = TextEditingController(text: defaultPayload);
    });
  }

  void _navigateToPaymentScreen() {
    try {
      final Map<String, dynamic> payload = jsonDecode(_payloadController.text);

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PaymentInitiationScreen(
            apiKey: _apiKeyController.text.trim(),
            encryptionKey: _encryptionKeyController.text.trim(),
            secretKey: _secretKeyController.text.trim(),
            payload: payload,
            returnScreen: const HomeScreen(),
          ),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Invalid JSON format: ${e.toString()}"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Test Payment SDK"),
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.refresh, color: Colors.white),
            onPressed: _resetFields, // Reset fields when clicked
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppInputField(
                  labelText: "API Key",
                  hintText: "Enter API Key",
                  controller: _apiKeyController,
                  isRequired: true,
                ),
                AppInputField(
                  labelText: "Encryption Key",
                  hintText: "Enter Encryption Key",
                  controller: _encryptionKeyController,
                  isRequired: true,
                ),
                AppInputField(
                  labelText: "Secret Key",
                  hintText: "Enter Secret Key",
                  controller: _secretKeyController,
                  isRequired: true,
                ),
                AppInputField(
                  labelText: "Payload Data (Enter JSON)",
                  hintText: "Enter JSON payload",
                  controller: _payloadController,
                  isTextArea: true,
                  isRequired: true,
                ),
                const SizedBox(height: 20),
                Center(
                  child: ElevatedButton(
                    onPressed: _navigateToPaymentScreen,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 12),
                      textStyle: const TextStyle(fontSize: 16),
                    ),
                    child: const Text("Open Payment Screen"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


```


### Other example can be found in the example tab

## Issues

Please file any issues, bugs or feature request as an issue on our [GitHub](https://github.com/fussion-integrator/transact_pay_sdk/issues) page.

## Want to contribute

If you would like to contribute to the plugin (e.g. by improving the documentation, solving a bug or adding a cool new feature), please carefully review our [contribution guide](CONTRIBUTING.md) and send us your [pull request](https://github.com/fussion-integrator/transact_pay/pulls).

## Credits

Credits goes to [ChidiebereEdeh](https://github.com/fussion-integrator) as most of this package comes from his implementation.