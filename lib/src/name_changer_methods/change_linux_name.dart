import 'dart:io';

import 'package:dcli/dcli.dart';

/// Changes Linux name of the project.
void changeLinuxName({
  required String baseFolderPath,
  required String oldName,
  required String newNameSnakeCase,
  required String newNameUpperedFirstChars,
}) {
  // Check if Linux path exists.
  if (!Directory(join(baseFolderPath, 'linux')).existsSync()) {
    printerr(
      "Couldn't found Linux directory, probably your app doesn't have a Linux project.",
    );
    return;
  }

  // Read CMakeLists.txt and replace name.
  final cmakeListsFile = File(join(baseFolderPath, 'linux', 'CMakeLists.txt'));
  final cmakeListsFileContent = cmakeListsFile.readAsStringSync();

  cmakeListsFile.writeAsStringSync(
    cmakeListsFileContent.replaceAll(oldName, newNameSnakeCase),
  );

  // Read my_application.cc and replace name.
  final myApplicationFile = File(join(baseFolderPath, 'linux', 'my_application.cc'));
  final myApplicationFileContent = myApplicationFile.readAsStringSync();

  myApplicationFile.writeAsStringSync(
    myApplicationFileContent.replaceAll(oldName, newNameUpperedFirstChars),
  );
}
