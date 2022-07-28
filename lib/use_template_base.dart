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
      printerr('${ConstStrings.couldntCreateDirectory} : $e');
      // Abort.
      return;
    }

    try {
      // Then, clone the repository in it.
      _cloneRepository(repositoryOfTemplate, pathToInstall);
    } catch (e) {
      printerr('${ConstStrings.couldntCloneRepository} : $e');
      // Abort.
      return;
    }

    /* Getting old name from pubspec and necessary name of the project. */
    try {
      // Set oldName
      _oldName = _getOldName(pathToInstall);
    } catch (e) {
      printerr('${ConstStrings.couldntGetOldName} : $e');
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
        ConstStrings.couldntFindDir('Android'),
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
        final errorMessage = ConstStrings.couldntChangeName('Android');
        printerr('$errorMessage : $e');
      }
    }

    // If iOS path does not exists, do not try to change IOS name.
    if (!Directory(join(pathToInstall, 'ios')).existsSync()) {
      printerr(
        ConstStrings.couldntFindDir('IOS'),
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
        final errorMessage = ConstStrings.couldntChangeName('IOS');
        printerr('$errorMessage : $e');
      }
    }

    // If Web path does not exists, do not try to change Web name.
    if (!Directory(join(pathToInstall, 'web')).existsSync()) {
      printerr(
        ConstStrings.couldntFindDir('Web'),
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
        final errorMessage = ConstStrings.couldntChangeName('Web');
        printerr('$errorMessage : $e');
      }
    }

    // If Linux path does not exists, do not try to change Linux name.
    if (!Directory(join(pathToInstall, 'linux')).existsSync()) {
      printerr(
        ConstStrings.couldntFindDir('Linux'),
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
        final errorMessage = ConstStrings.couldntChangeName('Linux');
        printerr('$errorMessage : $e');
      }
    }

    // If MacOS path does not exists, do not try to change MacOS name.
    if (!Directory(join(pathToInstall, 'macos')).existsSync()) {
      printerr(
        ConstStrings.couldntFindDir('MacOS'),
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
        final errorMessage = ConstStrings.couldntChangeName('MacOS');
        printerr('$errorMessage : $e');
      }
    }

    // If Windows path does not exists, do not try to change Windows name.
    if (!Directory(join(pathToInstall, 'windows')).existsSync()) {
      printerr(
        ConstStrings.couldntFindDir('Windows'),
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
        final errorMessage = ConstStrings.couldntChangeName('Windows');
        printerr('$errorMessage : $e');
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
      final errorMessage = ConstStrings.couldntChangeName('pubspec');
      printerr('$errorMessage : $e');
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
      final errorMessage = ConstStrings.couldntChangeImports('lib');
      printerr('$errorMessage : $e');
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
      final errorMessage = ConstStrings.couldntChangeImports('test');
      printerr('$errorMessage : $e');
    }

    try {
      // Remove old git files coming with clonned repository.
      _removeOldGitFiles(pathToInstall);
    } catch (e) {
      printerr('${ConstStrings.couldntRemoveOldGit} : $e');
      // Didn't use return. Because it's not a critical error.
    }

    _runFlutterPubGet(pathToInstall);

    // try {
    //   // Run 'flutter pub get'
    //   _runFlutterPubGet(pathToInstall);
    // } catch (e) {
    //   printerr('${ConstStrings.couldntRunPubGet} : $e');
    //   // Didn't use return. Because it's not a critical error.
    // }
  }
  /* Exec method ends here. */

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

  void _runFlutterPubGet(String path) {
    run('flutter pub get', workingDirectory: path, runInShell: true);
  }
}
