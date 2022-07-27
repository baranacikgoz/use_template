import 'dart:io';

import 'package:dcli/dcli.dart';
import 'package:use_template/src/extensions.dart';
import 'package:use_template/src/name_changer_methods/change_android_name.dart';
import 'package:use_template/src/name_changer_methods/change_flutter_name.dart';
import 'package:use_template/src/name_changer_methods/change_ios_name.dart';
import 'package:use_template/src/name_changer_methods/change_linux_name.dart';
import 'package:use_template/src/name_changer_methods/change_macos_name.dart';
import 'package:use_template/src/name_changer_methods/change_web_name.dart';
import 'package:use_template/src/name_changer_methods/change_windows_name.dart';

part 'src/constants.dart';

/// Repository class to handle operations.
class UseTemplateBase {
  /// Private constructor.
  UseTemplateBase._();

  /// Singleton instance.
  static final instance = UseTemplateBase._();

  late final String _oldName;

  /// Executes all necessary operations.
  /// Uses other methods inside!
  void exec({
    required String newAppNameSnakeCase,
    required String repositoryOfTemplate,
    required String pathToInstall,
  }) {
    /* Crating directory and clonning operations. */
    try {
      // First, create the directory.
      _createDirectory(pathToInstall);
    } catch (e) {
      printerr('Could not create directory to clone repository! : $e');
      // Abort.
      return;
    }

    try {
      // Then, clone the repository in it.
      _cloneRepository(repositoryOfTemplate, pathToInstall);
    } catch (e) {
      printerr('Could not clone repository! : $e');
      // Abort.
      return;
    }

    /* Getting old name from pubspec and necessary name of the project. */
    try {
      // Set oldName
      _oldName = _getOldName(pathToInstall);
    } catch (e) {
      printerr('Could not get the old name from pubspec! : $e');
      // Abort.
      return;
    }
    // Split and upper first chars of words.
    List<String> newNameSplittedList = newAppNameSnakeCase.split('_');
    newNameSplittedList = newNameSplittedList.map((word) => word.capitalize()).toList();
    final newNameUpperedFirstChars = newNameSplittedList.join(' ');

    /* Changing different platform names. */

    // If Android path does not exists, do not try to change Android name.
    if (!Directory(join(pathToInstall, 'android')).existsSync()) {
      printerr(
        "Couldn't found Android directory, probably your app doesn't have an Android project.",
      );
    } else {
      try {
        // Change Android name.
        changeAndroidName(
          baseFolderPath: pathToInstall,
          oldName: _oldName,
          newNameSnakeCase: newAppNameSnakeCase,
          newNameUpperedFirstChars: newNameUpperedFirstChars,
        );
      } catch (e) {
        printerr('Could not change Android name : $e');
      }
    }

    // If iOS path does not exists, do not try to change IOS name.
    if (!Directory(join(pathToInstall, 'ios')).existsSync()) {
      printerr(
        "Couldn't found iOS directory, probably your app doesn't have an iOS project.",
      );
    } else {
      try {
        // Change iOS name.
        changeIOSName(
          baseFolderPath: pathToInstall,
          oldName: _oldName,
          newNameSnakeCase: newAppNameSnakeCase,
          newNameUpperedFirstChars: newNameUpperedFirstChars,
        );
      } catch (e) {
        printerr('Could not change iOS name : $e');
      }
    }

    // If Web path does not exists, do not try to change Web name.
    if (!Directory(join(pathToInstall, 'web')).existsSync()) {
      printerr(
        "Couldn't found web directory, probably your app doesn't have a web project.",
      );
    } else {
      try {
        // Change web name.
        changeWebName(
          baseFolderPath: pathToInstall,
          oldName: _oldName,
          newNameSnakeCase: newAppNameSnakeCase,
          newNameUpperedFirstChars: newNameUpperedFirstChars,
        );
      } catch (e) {
        printerr('Could not change web name : $e');
      }
    }

    // If Linux path does not exists, do not try to change Linux name.
    if (!Directory(join(pathToInstall, 'linux')).existsSync()) {
      printerr(
        "Couldn't found Linux directory, probably your app doesn't have a Linux project.",
      );
    } else {
      try {
        // Change Linux name.
        changeLinuxName(
          baseFolderPath: pathToInstall,
          oldName: _oldName,
          newNameSnakeCase: newAppNameSnakeCase,
          newNameUpperedFirstChars: newNameUpperedFirstChars,
        );
      } catch (e) {
        printerr('Could not change Linux name : $e');
      }
    }

    // If MacOS path does not exists, do not try to change MacOS name.
    if (!Directory(join(pathToInstall, 'macos')).existsSync()) {
      printerr(
        "Couldn't found MacOS directory, probably your app doesn't have a MacOS project.",
      );
    } else {
      try {
        // Change MacOS name.
        changeMacOSName(
          baseFolderPath: pathToInstall,
          oldName: _oldName,
          newNameSnakeCase: newAppNameSnakeCase,
          newNameUpperedFirstChars: newNameUpperedFirstChars,
        );
      } catch (e) {
        printerr('Could not change MacOS name : $e');
      }
    }

    // If Windows path does not exists, do not try to change Windows name.
    if (!Directory(join(pathToInstall, 'windows')).existsSync()) {
      printerr(
        "Couldn't found Windows directory, probably your app doesn't have a Windows project.",
      );
    } else {
      try {
        // Change Windows name.
        changeWindowsName(
          baseFolderPath: pathToInstall,
          oldName: _oldName,
          newNameSnakeCase: newAppNameSnakeCase,
          newNameUpperedFirstChars: newNameUpperedFirstChars,
        );
      } catch (e) {
        printerr('Could not change Windows name : $e');
      }
    }

    /* Final operations */
    try {
      // Change pubspec name.
      changePubspecName(
        baseFolderPath: pathToInstall,
        oldName: _oldName,
        newNameSnakeCase: newAppNameSnakeCase,
        newNameUpperedFirstChars: newNameUpperedFirstChars,
      );
    } catch (e) {
      printerr('Could not change pubspec name, you have to change manually! : $e');
    }

    try {
      // Change lib import names.
      changeLibImports(
        baseFolderPath: pathToInstall,
        oldName: _oldName,
        newNameSnakeCase: newAppNameSnakeCase,
        newNameUpperedFirstChars: newNameUpperedFirstChars,
      );
    } catch (e) {
      printerr('Could not change lib imports, you have to change manually! : $e');
    }

    try {
      // Change test import names.
      changeTestImports(
        baseFolderPath: pathToInstall,
        oldName: _oldName,
        newNameSnakeCase: newAppNameSnakeCase,
        newNameUpperedFirstChars: newNameUpperedFirstChars,
      );
    } catch (e) {
      printerr('Could not change test imports, you have to change manually! : $e');
    }

    try {
      /// Remove old git files coming with clonned repository.
      _removeOldGitFiles(pathToInstall);
    } catch (e) {
      printerr('Could not remove old git files, you have to remove manually! : $e');
      // Didn't use return. Because it's not a critical error.
    }
  }

  void _createDirectory(String path) {
    if (!Directory(path).existsSync()) {
      Directory(path).createSync(recursive: true);
    }
  }

  void _cloneRepository(String repository, String path) {
    'git clone $repository $path'.run;
  }

  void _removeOldGitFiles(String baseFolderPath) {
    final gitFolder = Directory(join(baseFolderPath, '.git'));
    if (gitFolder.existsSync()) {
      gitFolder.deleteSync(recursive: true);
    }
  }

  String _getOldName(String path) {
    final pubspecFile = File(join(path, 'pubspec.yaml'));

    late final String oldName;
    final linesOfPubspec = pubspecFile.readAsLinesSync();

    for (final line in linesOfPubspec) {
      if (line.startsWith('name')) {
        oldName = line.split('name: ').last;
        break;
      }
    }

    return oldName;
  }
}
