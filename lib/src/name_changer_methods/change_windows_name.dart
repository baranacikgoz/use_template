import 'dart:io';

import 'package:dcli/dcli.dart';

void changeWindowsName({
  required String path,
  required String oldName,
  required String newNameSnakeCase,
  required String newNameUpperedFirstChars,
}) {
  // Check if Windows path exists.
  if (!Directory(join(path, 'windows')).existsSync()) {
    printerr(
      "Couldn't found Windows directory, probably your app doesn't have an Windows project.",
    );
    return;
  }

  // Read CMakeLists.txt and replace name.
  final cmakeListsFile = File(join(path, 'windows', 'CMakeLists.txt'));
  final cmakeListsFileContent = cmakeListsFile.readAsStringSync();

  cmakeListsFile.writeAsStringSync(
    cmakeListsFileContent.replaceAll(oldName, newNameSnakeCase),
  );

  // Read my_application.cc and replace name.
  final myApplicationFile = File(join(path, 'windows', 'runner', 'main.cpp'));
  final myApplicationFileContent = myApplicationFile.readAsStringSync();

  myApplicationFile.writeAsStringSync(
    myApplicationFileContent.replaceAll(oldName, newNameUpperedFirstChars),
  );

  // Read Runner.rc and replace name.
  final runnerRcFile = File(join(path, 'windows', 'runner', 'Runner.rc'));
  final runnerRcFileContent = runnerRcFile.readAsStringSync();

  runnerRcFile.writeAsStringSync(
    runnerRcFileContent.replaceAll(oldName, newNameSnakeCase),
  );
}
