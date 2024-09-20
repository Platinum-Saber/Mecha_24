import 'package:flutter/material.dart';

class ImagePreloader {
  static Future<void> preloadImages(BuildContext context) async {
    await Future.wait([
      precacheImage(const AssetImage('assets/3.jpg'), context),
      precacheImage(const AssetImage('assets/10.jpg'), context),
      precacheImage(const AssetImage('assets/1.jpg'), context),
    ]);
  }
}
