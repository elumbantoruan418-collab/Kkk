import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Kirigakure App',
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
      ),
      home: const DashboardWebView(),
    );
  }
}

class DashboardWebView extends StatefulWidget {
  const DashboardWebView({super.key});

  @override
  State<DashboardWebView> createState() => _DashboardWebViewState();
}

class _DashboardWebViewState extends State<DashboardWebView> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      // ⚠️ GANTI LINK DI BAWAH INI dengan link GitHub Pages hasil dari repository barumu!
      ..loadRequest(
        Uri.parse('https://elumbantoruan418-collab.github.io/panel-xtr/'),
      ); 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: WebViewWidget(controller: _controller),
      ),
    );
  }
}
