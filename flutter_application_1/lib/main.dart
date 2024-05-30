import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';
import 'package:webview_flutter_platform_interface/webview_flutter_platform_interface.dart';

void main() => runApp(const MaterialApp(home: HomePage()));

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) => Scaffold(
        body: Center(
          child: ElevatedButton(
            child: const Text("Show WebView in BottomSheet"),
            onPressed: () {
              showModalBottomSheet<void>(
                context: context,
                isScrollControlled: true,
                builder: (context) =>
                    const SizedBox(height: 600, child: InAppWebViewPage()),
              );
            },
          ),
        ),
      );
}

class InAppWebViewPage extends StatefulWidget {
  const InAppWebViewPage({super.key});

  @override
  State<InAppWebViewPage> createState() => _InAppWebViewPageState();
}

class _InAppWebViewPageState extends State<InAppWebViewPage> {
  @override
  Widget build(BuildContext context) {
    final controller =
        AndroidWebViewController(AndroidWebViewControllerCreationParams());
    final params = AndroidWebViewWidgetCreationParams(
      controller: controller,
      displayWithHybridComposition: true,
    );
    controller
        .loadRequest(LoadRequestParams(uri: Uri.parse('https://buy.line.me/')));

    return Scaffold(
      appBar: AppBar(title: const Text('WebView Flutter')),
      body: WebViewWidget.fromPlatformCreationParams(params: params),
    );
  }
}
