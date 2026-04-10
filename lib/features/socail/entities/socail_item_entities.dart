import 'package:flutter/cupertino.dart';

class SocialItemEntities {
  const SocialItemEntities({
    required this.label,
    required this.color,
    required this.url,
    this.icon,
    this.imagePath,
  });
  
  final String label;
  final Color color;
  final String url;
  final IconData? icon;
  final String? imagePath;
}
