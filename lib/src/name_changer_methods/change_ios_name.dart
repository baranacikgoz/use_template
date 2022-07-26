import 'dart:io';

import 'package:dcli/dcli.dart';

/// Changes IOS name of the project.
void changeIOSName({
  required String baseFolderPath,
  required String oldName,
  required String newNameSnakeCase,
  required String newNameUpperedFirstChars,
}) {
  // Check if iOS path exists.
  if (!Directory(join(baseFolderPath, 'ios')).existsSync()) {
    printerr(
      "Couldn't found iOS directory, probably your app doesn't have an iOS project.",
    );
    return;
  }

  final infoPlistFile = File(join(baseFolderPath, 'ios', 'Runner', 'Info.plist'));

  final List<String> lines = infoPlistFile.readAsLinesSync();
  for (int i = 0; i < lines.length; i++) {
    if (lines[i].contains('CFBundleDisplayName')) {
      lines[i + 1] = '<string>$newNameUpperedFirstChars</string>';
    }

    if (lines[i].contains('CFBundleName')) {
      lines[i + 1] = '<string>$newNameSnakeCase</string>';
    }
  }
  infoPlistFile.writeAsStringSync(lines.join('\n'));
}
