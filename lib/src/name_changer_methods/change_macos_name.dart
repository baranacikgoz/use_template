import 'dart:io';

import 'package:dcli/dcli.dart';

/// Changes MacOS name of the project.
void changeMacOSName({
  required String baseFolderPath,
  required String oldName,
  required String newNameSnakeCase,
  required String newNameUpperedFirstChars,
}) {
  // Check if MacOS path exists.
  if (!Directory(join(baseFolderPath, 'macos')).existsSync()) {
    printerr(
      "Couldn't found MacOS directory, probably your app doesn't have a MacOS project.",
    );
    return;
  }

  // Read Info.plist and replace name.
  final infoPlistFile = File(join(baseFolderPath, 'macos', 'Runner', 'Info.plist'));
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

  final List<File> filesToChange = [
    File(
      join(baseFolderPath, 'macos', 'Runner', 'Configs', 'AppInfo.xcconfig'),
    ),
    File(join(baseFolderPath, 'macos', 'Runner.xcodeproj', 'project.pbxproj')),
    File(
      join(
        baseFolderPath,
        'macos',
        'Runner.xcodeproj',
        'xcsharreddata',
        'xcschemes',
        'Runner.xcscheme',
      ),
    ),
  ];

  for (final file in filesToChange) {
    try {
      file.writeAsStringSync(
        file.readAsStringSync().replaceAll(oldName, newNameSnakeCase),
      );
    } catch (e) {
      // Ignore.
    }
  }
}
