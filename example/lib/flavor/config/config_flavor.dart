import 'package:package_info_plus/package_info_plus.dart';

enum ProjectType { dev, prod }

class FlavorConfig {
  final String baseUrl;
  final ProjectType projectType;
  final PackageInfo? packageInfo;
  final String? version;

  static FlavorConfig? _instance;

  static FlavorConfig get instance {
    if (_instance == null) {
      throw UnimplementedError('FlavorConfig not initialized');
    } else {
      return _instance!;
    }
  }

  String get versionLabel {
    return instance.projectType.name == ProjectType.dev.name
        ? '${instance.version} (Dev)'
        : '${instance.packageInfo?.appName} ${instance.packageInfo?.buildNumber}';
  }

  bool get isDev {
    return instance.projectType == ProjectType.dev;
  }

  FlavorConfig._({
    required this.baseUrl,
    required this.projectType,
    this.version,
    this.packageInfo,
  });

  factory FlavorConfig.init({
    required String baseUrl,
    required ProjectType projectType,
    String? version,
    PackageInfo? packageInfo,
  }) {
    return _instance ??= FlavorConfig._(
      baseUrl: baseUrl,
      projectType: projectType,
      version: version,
      packageInfo: packageInfo,
    );
  }
}

