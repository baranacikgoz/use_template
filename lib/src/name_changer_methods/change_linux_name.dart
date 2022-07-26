import 'dart:io';

import 'package:dcli/dcli.dart';

void changeLinuxName({
  required String path,
  required String oldName,
  required String newNameSnakeCase,
  required String newNameUpperedFirstChars,
}) {
  // Check if Linux path exists.
  if (!Directory(join(path, 'linux')).existsSync()) {
    printerr(
      "Couldn't found Linux directory, probably your app doesn't have a Linux project.",
    );
    return;
  }

  // Read CMakeLists.txt and replace name.
  final cmakeListsFile = File(join(path, 'linux', 'CMakeLists.txt'));
  final cmakeListsFileContent = cmakeListsFile.readAsStringSync();

  cmakeListsFile.writeAsStringSync(
    cmakeListsFileContent.replaceAll(oldName, newNameSnakeCase),
  );

  // Read my_application.cc and replace name.
  final myApplicationFile = File(join(path, 'linux', 'my_application.cc'));
  final myApplicationFileContent = myApplicationFile.readAsStringSync();

  myApplicationFile.writeAsStringSync(
    myApplicationFileContent.replaceAll(oldName, newNameUpperedFirstChars),
  );
}
