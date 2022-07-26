import 'dart:io';

import 'package:dcli/dcli.dart';

void changePubspecName(
  String baseFolderPath,
  String oldName,
  String newNameSnakeCase,
  String newNameUpperedFirstChars,
) {
  final pubspecFile = File(join(baseFolderPath, 'pubspec.yaml'));
  final pubspecContent = pubspecFile.readAsStringSync();

  pubspecFile.writeAsStringSync(
    pubspecContent.replaceFirst(oldName, newNameSnakeCase),
  );
}
