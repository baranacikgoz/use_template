import 'dart:io';

import 'package:dcli/dcli.dart';

/// Changes the name of the new clonned Flutter package / project from pubspec.
void changePubspecName({
  required String baseFolderPath,
  required String oldName,
  required String newNameSnakeCase,
  required String newNameUpperedFirstChars,
}) {
  final pubspecFile = File(join(baseFolderPath, 'pubspec.yaml'));
  final pubspecContent = pubspecFile.readAsStringSync();

  pubspecFile.writeAsStringSync(
    pubspecContent.replaceAll(oldName, newNameSnakeCase),
  );
}

/// Changes the all import names under lib folder from old project name to new project name.
void changeLibImportNames({
  required String baseFolderPath,
  required String oldName,
  required String newNameSnakeCase,
  required String newNameUpperedFirstChars,
}) {
  final libFolder = Directory(join(baseFolderPath, 'lib'));
  final libFiles = libFolder.listSync();

  for (final file in libFiles) {
    if (file is File) {
      final fileContent = file.readAsStringSync();
      file.writeAsStringSync(
        fileContent.replaceAll(oldName, newNameSnakeCase),
      );
    }
  }
}
