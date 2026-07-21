import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
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
        brightness: Brightness.light,
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
  WebViewController? _controller;
  bool _isLoading = true;
  String? _errorMessage;

  // Link Raw JSON tempat menyimpan vps_url
  final String _jsonUrl =
      'https://raw.githubusercontent.com/elumbantoruan418-collab/Eid/main/tokens.json';

  // Fallback URL jika fetch gagal / nilainya masih localhost
  final String _defaultUrl =
      'https://elumbantoruan418-collab.github.io/Dasboroat_nya-base-winz/';

  @override
  void initState() {
    super.initState();
    _fetchUrlAndLoadWebView();
  }

  Future<void> _fetchUrlAndLoadWebView() async {
    String targetUrl = _defaultUrl;

    try {
      final response = await http.get(Uri.parse(_jsonUrl));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);

        // Cari objek yang punya key 'vps_url'
        for (var item in data) {
          if (item is Map<String, dynamic> && item.containsKey('vps_url')) {
            String urlFromGithub = item['vps_url'];
            
            // Jika url di JSON bukan localhost, gunakan url tersebut
            if (urlFromGithub.isNotEmpty && !urlFromGithub.contains('localhost')) {
              targetUrl = urlFromGithub;
            }
            break;
          }
        }
      }
    } catch (e) {
      debugPrint("Gagal mengambil config URL dari GitHub: $e");
    }

    // Inisialisasi WebViewController dengan URL hasil fetch
    final controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0xFF0B0F19)) // Disesuaikan dengan warna background index.html
      ..loadRequest(Uri.parse(targetUrl));

    setState(() {
      _controller = controller;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B0F19),
      body: SafeArea(
        child: _isLoading
            ? const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(color: Color(0xFF38BDF8)),
                    SizedBox(height: 15),
                    Text(
                      'Menghubungkan ke Server Winz XTR...',
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                  ],
                ),
              )
            : WebViewWidget(controller: _controller!),
      ),
    );
  }
}
