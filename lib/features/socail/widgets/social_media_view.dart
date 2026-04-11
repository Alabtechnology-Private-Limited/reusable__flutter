import 'package:alabtechnology/core/assets/plugin_images.dart';
import 'package:alabtechnology/features/socail/entities/socail_item_entities.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SocialMediaView extends StatelessWidget {
  const SocialMediaView({super.key, this.socailItems});
  final List<SocialItemEntities>? socailItems;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 0, 24, 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Follow Us',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: Colors.grey.shade700,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: _socials.map((s) {
              return Padding(
                padding: const EdgeInsetsGeometry.symmetric(horizontal: 12),
                child: GestureDetector(
                  onTap: () => _open(s.url),
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: s.color.withValues(alpha: 0.3),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadiusGeometry.circular(26),
                          child: Image.asset(
                            s.imagePath!,
                            width: 52,
                            height: 52,
                            fit: BoxFit.contain,
                            package: 'alabtechnology',
                          ),
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        s.label,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade800,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '© ${DateTime.now().year} Crafted with ',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade600,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Icon(Icons.favorite_rounded, color: Colors.red, size: 13),
              Text(
                ' Alabtechnology Pvt Ltd.',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade600,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  static final _socials = [
    SocialItemEntities(
      label: 'Facebook',
      color: Colors.blue,
      url: 'https://www.facebook.com/Alabtechnologypvtltd/',
      imagePath: PluginImages.faceBook,
    ),
    SocialItemEntities(
      label: 'Instagram',
      color: Colors.orangeAccent,
      url:
          'https://www.instagram.com/alabtechnologypvtltd?igsh=MTBjZjgyeWp4MmVjMQ==',
      imagePath: PluginImages.instagram,
    ),
    SocialItemEntities(
      label: 'YouTube',
      color: Colors.red,
      url: 'https://youtube.com/@alabtechnologypvtltd?si=eZtnQ7ItSQx6djl1',
      imagePath: PluginImages.youtub,
    ),
  ];

  Future<void> _open(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }
}
