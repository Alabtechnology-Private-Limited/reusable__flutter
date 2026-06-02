// ignore_for_file: avoid_print

part of 'alabtechnology.dart';

abstract final class FileDirectory {
  static const List<String> _createFolders = [
    'lib/core/database',
    'lib/core/util',
    'lib/core/images',
    'lib/core/payment',
    'lib/core/enums',
    'lib/core/theme',
    'lib/core/helper',
    'lib/core/routes',
    'lib/core/global',
    'lib/core/services',
    'lib/core/swr',
    'lib/feature/auth/',
    'lib/feature/auth/controllers',
    'lib/feature/auth/widgets',
    'lib/feature/auth/screens',
    'lib/feature/profile/',
    'lib/feature/profile/controllers',
    'lib/feature/profile/widgets',
    'lib/feature/profile/screens',
  ];

  static Future<void> createFolderStructure() async {
    for (final folder in _createFolders) {
      await Directory(folder).create(recursive: true);
      print('Created: $folder');
    }
  }
}
