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
      title: 'XTR WINZ 5.6.2',
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.light, // ✨ Mengubah tema dasar menjadi warna terang/putih
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
      ..setBackgroundColor(const Color(0xFFFFFFFF)) // ✨ Mengubah latar belakang WebView jadi putih pekat
      ..loadRequest(
        Uri.parse('https://elumbantoruan418-collab.github.io/Dasboroat_nya-base-winz/'),
      ); 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // ✨ Memastikan dasar halaman aplikasi tetap putih
      body: SafeArea(
        child: WebViewWidget(controller: _controller),
      ),
    );
  }
}
