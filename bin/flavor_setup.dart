// ignore_for_file: avoid_print

part of 'alabtechnology.dart';

abstract final class FlavorSetup {
  static const String _pro = 'lib/flavor/pro/pro_flavor.dart';
  static const String _dev = 'lib/flavor/dev/dev_flavor.dart';
  static const String _config = 'lib/flavor/config/config_flavor.dart';
  static const String _appGradle = 'android/app/build.gradle.kts';
  static const String _maniFest = 'android/app/src/main/AndroidManifest.xml';

  static Future<ProcessResult> _addPackage() async {
    return Process.run(
      'flutter',
      [
        'pub',
        'add',
        'package_info_plus',
      ],
    );
  }

  static Future<void> _createFolderFile({
    required String path,
    required String value,
  }) async {
    final file = await File(path).create(recursive: true);
    await file.writeAsString(value);
  }

  static int _findAndroidClosingBrace(String content) {
    final androidIndex = content.indexOf('android {');

    if (androidIndex == -1) {
      throw Exception('android block not found');
    }

    final openBraceIndex = content.indexOf('{', androidIndex);

    var depth = 1;

    for (var i = openBraceIndex + 1; i < content.length; i++) {
      if (content[i] == '{') {
        depth++;
      } else if (content[i] == '}') {
        depth--;

        if (depth == 0) {
          return i;
        }
      }
    }

    throw Exception('No matching closing brace found');
  }

  static Future<void> _appGradleEditor({
    required String path,
    required String value,
  }) async {
    final File file = File(path);
    final String text = file.readAsStringSync();
    try {
      final int closeIndex = _findAndroidClosingBrace(text);
      final updated =
          text.substring(0, closeIndex) + value + text.substring(closeIndex);

      await file.writeAsString(updated);
    } catch (e) {
      print(e);
    }
  }

  static Future<void> _updateAndroidLabel(String manifestPath) async {
    try {
      final file = File(manifestPath);

      if (!await file.exists()) {
        throw Exception('AndroidManifest.xml not found');
      }

      var content = await file.readAsString();

      content = content.replaceFirst(
        RegExp(r'android:label="[^"]*"'),
        'android:label="@string/app_name"',
      );

      await file.writeAsString(content);
    } catch (e) {
      print(e);
    }
  }

  static Future<void> _createFlavorFloder() async {
    await _createFolderFile(path: _config, value: _configData);
    await _createFolderFile(path: _dev, value: _devData);
    await _createFolderFile(path: _pro, value: _proData);
    await _appGradleEditor(path: _appGradle, value: _appBuild);
    await _updateAndroidLabel(_maniFest);
    await MakefileCreation.createMakeFile();
    Process.run('make', ['clean-get']);

  }

  static Future<void> setup() async {
    _addPackage().then(
      (value) async {
        await _createFlavorFloder();
      },
      onError: (dynamic error) {
        print('Error : $error');
      },
    );
  }
}

final String _configData = '''
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
        ? '\${instance.version} (Dev)'
        : '\${instance.packageInfo?.appName} \${instance.packageInfo?.buildNumber}';
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

''';

final String _devData = '''

import 'package:flutter/material.dart';


  /**
   * 
   *  INFO : Try to import the FlavorConfig file.
   * 
   **/

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  FlavorConfig.init(
    baseUrl: "[[[ ADD YOU'R DEVELOPMENT URL  ]]]",
    projectType: .dev,
    version: "[[[ ADD YOU'R DEVELOPMENT VERSION  ]]]",
  );

    /**
     *  [here you can add dependency injection]
     **/
     
  runApp(const MyApp());
}
''';

final String _proData = '''

import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';


  /**
   * 
   *  INFO : Try to import the FlavorConfig file.
   * 
   **/

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final PackageInfo packageInfo = await PackageInfo.fromPlatform();

  FlavorConfig.init(
    baseUrl: "[[[ ADD YOU'R PRODUCTION URL  ]]]",
    projectType: .dev,
    packageInfo: packageInfo,
  );
    /**
     *  [here you can add dependency injection]
     **/
  runApp(const MyApp());
}

''';

final String _appBuild = '''
 flavorDimensions += "version"
    productFlavors {
        create("pro") {
            resValue("string", "app_name", "[[[ ADD YOU'R APPLICATION NAME (PRODUCTION) ]]]")
        }
        create("dev") {
            resValue("string", "app_name", "[[[ ADD YOU'R APPLICATION NAME (DEVELOPMENT) ]]]")
            applicationIdSuffix = ".dev"
        }
    }
''';
