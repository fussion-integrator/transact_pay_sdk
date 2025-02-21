import 'package:flutter/material.dart';
import 'package:transact_pay_sdk/transact_pay_sdk.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Card3DSScreen extends StatefulWidget {
  final String redirectUrl;

  const Card3DSScreen({super.key, required this.redirectUrl});

  @override
  State<Card3DSScreen> createState() => _Card3DSScreenState();
}

class _Card3DSScreenState extends State<Card3DSScreen> {
  late WebViewController webViewController;

  @override
  void initState() {
    super.initState();
    webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setUserAgent(
          "Mozilla/5.0 (Linux; Android 10) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.114 Mobile Safari/537.36")
      ..setNavigationDelegate(NavigationDelegate(
        onPageStarted: (String url) {
          debugPrint("🔵 WebView Loading Started: $url");
        },
        onPageFinished: (String url) {
          debugPrint("✅ WebView Loaded: $url");
        },
        onWebResourceError: (WebResourceError error) {
          debugPrint("❌ WebView Error: ${error.description}");
        },
      ))
      ..loadRequest(Uri.parse(widget.redirectUrl));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        leading: GestureDetector(
          onTap: () => Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => returnScreen),
            (route) => false,
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                //const Icon(Icons.close, color: Colors.white),
                Text(
                  "Done",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14),
                )
              ],
            ),
          ),
        ),
        centerTitle: true,
        title: const Text(
          "Card Payment",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: WebViewWidget(controller: webViewController),
    );
  }
}
