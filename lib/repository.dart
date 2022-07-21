import 'dart:io';

import 'package:dcli/dcli.dart';

part 'constants.dart';

/// Extension for capitalizing a string.
extension StringExtension on String {
  /// Capitalize the first letter of the string.
  String capitalize() {
    return '${this[0].toUpperCase()}${substring(1).toLowerCase()}';
  }
}

/// Repository class to handle operations.
class Repository {
  /// Private constructor.
  Repository._();

  /// Singleton instance.
  static final instance = Repository._();

  late final String _oldName;

  /// Executes all necessary operations.
  /// Uses other internal methods in the class.
  void exec({
    required String newAppNameSnakeCase,
    required String repositoryOfTemplate,
    required String pathToInstall,
  }) {
    // First, create the directory.
    _createDirectory(pathToInstall);

    // Then, clone the repository in it.
    _cloneRepository(repositoryOfTemplate, pathToInstall);

    // Set oldName
    _oldName = _getOldName(pathToInstall);

    // Split and upper first chars of words.
    List<String> newNameSplittedList = newAppNameSnakeCase.split('_');

    newNameSplittedList = newNameSplittedList.map((word) => word.capitalize()).toList();

    final newNameUpperedFirstChars = newNameSplittedList.join(' ');

    // Change Android name.
    _changeAndroidName(
      path: pathToInstall,
      oldName: _oldName,
      newNameSnakeCase: newAppNameSnakeCase,
      newNameUpperedFirstChars: newNameUpperedFirstChars,
    );

    // Change IOS name.
    _changeIOSName(
      path: pathToInstall,
      oldName: _oldName,
      newNameSnakeCase: newAppNameSnakeCase,
      newNameUpperedFirstChars: newNameUpperedFirstChars,
    );
  }

  void _createDirectory(String path) {
    if (!Directory(path).existsSync()) {
      Directory(path).createSync(recursive: true);
    }
  }

  void _cloneRepository(String repository, String path) {
    'git clone $repository $path'.run;
  }

  String _getOldName(String path) {
    final pubspecFile = File(join(path, 'pubspec.yaml'));

    return pubspecFile.readAsLinesSync().first.split('name: ').last;
  }

  void _changeAndroidName({
    required String path,
    required String oldName,
    required String newNameSnakeCase,
    required String newNameUpperedFirstChars,
  }) {
    // Check if Android path exists.
    if (!Directory(join(path, 'android')).existsSync()) {
      printerr(
        "Couldn't found Andorid directory, probably your app doesn't have an Android project.",
      );
      return;
    }

    final _basePath = join(path, 'android', 'app');

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

  // Change the IOS name of the app.
  void _changeIOSName({
    required String path,
    required String oldName,
    required String newNameSnakeCase,
    required String newNameUpperedFirstChars,
  }) {
    // Check if iOS path exists.
    if (!Directory(join(path, 'ios')).existsSync()) {
      printerr(
        "Couldn't found iOS directory, probably your app doesn't have an iOS project.",
      );
      return;
    }

    final infoPlistFile = File(join(path, 'ios', 'Runner', 'Info.plist'));

    final List<String> lines = infoPlistFile.readAsLinesSync();
    for (int i = 0; i < lines.length; i++) {
      if (lines[i].contains('CFBundleDisplayName')) {
        lines[i + 1] = '<string>$newNameUpperedFirstChars</string>';
      }

      if (lines[i].contains('CFBundleDisplayName')) {
        lines[i + 1] = '<string>$newNameUpperedFirstChars</string>';
      }

      if (lines[i].contains('CFBundleName')) {
        lines[i + 1] = '<string>$newNameSnakeCase</string>';
      }
    }
    infoPlistFile.writeAsStringSync(lines.join('\n'));
  }
}
