import 'dart:io';

import 'package:dcli/dcli.dart';

/// Changes Android name of the project.
void changeAndroidName({
  required String baseFolderPath,
  required String oldName,
  required String newNameSnakeCase,
  required String newNameUpperedFirstChars,
}) {
  final _basePath = join(baseFolderPath, 'android', 'app');
  final List<File> filesToChange = [
    File(join(_basePath, 'build.gradle')),
    File(join(_basePath, 'src', 'debug', 'AndroidManifest.xml')),
    //androidManifest,
    File(join(_basePath, 'src', 'main', 'AndroidManifest.xml')),
    File(
      join(
        _basePath,
        'src',
        'main',
        'kotlin',
        'com',
        'example',
        oldName,
        'MainActivity.kt',
      ),
    ),
    File(join(_basePath, 'src', 'profile', 'AndroidManifest.xml')),
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

  //! Double check to make sure 'android label: ....' name is changed.
  final androidManifest =
      File(join(_basePath, 'src', 'main', 'AndroidManifest.xml'));
  final androidManifestLines = androidManifest.readAsLinesSync();

  final newLines = androidManifestLines.map((e) {
    if (e.contains('android:label')) {
      return 'android:label="$newNameUpperedFirstChars"';
    } else {
      return e;
    }
  }).toList();

  androidManifest.writeAsStringSync(newLines.join('\n'));
}
