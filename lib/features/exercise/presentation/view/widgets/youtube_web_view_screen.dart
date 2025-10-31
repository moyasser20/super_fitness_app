import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../../../core/contants/app_icons.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/utils/styles.dart';

class YouTubeWebViewScreen extends StatefulWidget {
  final String videoUrl;
  final bool isFood;

  const YouTubeWebViewScreen({super.key, required this.videoUrl, required this.isFood});

  @override
  State<YouTubeWebViewScreen> createState() => _YouTubeWebViewScreenState();
}

class _YouTubeWebViewScreenState extends State<YouTubeWebViewScreen> {
  late final WebViewController _controller;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _controller =
        WebViewController()
          ..setJavaScriptMode(JavaScriptMode.unrestricted)
          ..loadRequest(Uri.parse(widget.videoUrl))
          ..setNavigationDelegate(
            NavigationDelegate(
              onPageFinished: (_) => setState(() => _isLoading = false),
            ),
          );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: AppColors.black,
        title: Text(
          widget.isFood ? 'Recipe Video' : "Exercise Video",
          style: balooThambi2BoldLarge.copyWith(
            color: AppColors.white,
            fontSize: 22,
          ),
        ),
        leading: Padding(
          padding: EdgeInsets.all(10),
          child: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: AppColors.main,
                borderRadius: BorderRadius.circular(20),
              ),
              child: SvgPicture.asset(AppIcons.backIcon),
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          WebViewWidget(controller: _controller),
          if (_isLoading)
            const Center(child: CircularProgressIndicator(color: Colors.white)),
        ],
      ),
    );
  }
}
