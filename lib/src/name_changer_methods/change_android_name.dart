import 'dart:io';

import 'package:dcli/dcli.dart';

/// Changes Android name of the project.
void changeAndroidName({
  required String baseFolderPath,
  required String oldName,
  required String newNameSnakeCase,
  required String newNameUpperedFirstChars,
}) {
  // Check if Android path exists.
  if (!Directory(join(baseFolderPath, 'android')).existsSync()) {
    printerr(
      "Couldn't found Andorid directory, probably your app doesn't have an Android project.",
    );
    return;
  }

  final _basePath = join(baseFolderPath, 'android', 'app');

  // ! Fix it
  // // Read AndroidManifest.xml and check if it has 'android:label' attribute.
  // final androidManifest = File(join(_basePath, 'src', 'main', 'AndroidManifest.xml'));
  // final androidManifestContent = androidManifest.readAsStringSync();
  // if (androidManifestContent.contains('android:label')) {
  //   // Change label.
  //   androidManifest.writeAsStringSync(
  //     androidManifestContent.replaceAll(
  //       'android:label="$oldName"',
  //       'android:label="$newNameUpperedFirstChars"',
  //     ),
  //   );
  // }

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
}
