// ignore_for_file: avoid_print

import 'dart:async';
import 'dart:io';

part 'makefile_creation.dart';
part 'flavor_setup.dart';
part 'file_directory.dart';

void main(List<String> args) {
  if (args[0] == 'flavor-setup') {
    FlavorSetup.setup();
  } else if (args[0] == 'create-folder-setup') {
    FileDirectory.createFolderStructure();
  } else {
    print('''

  flavor-setup : this command setup flaovr dimensions and kindly check app/build.gradle.kts file.

''');
  }
}
