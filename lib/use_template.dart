import 'dart:io';

import 'package:dcli/dcli.dart';
import 'package:use_template/src/name_changer_methods/change_android_name.dart';
import 'package:use_template/src/name_changer_methods/change_flutter_name.dart';
import 'package:use_template/src/name_changer_methods/change_ios_name.dart';
import 'package:use_template/src/name_changer_methods/change_linux_name.dart';
import 'package:use_template/src/name_changer_methods/change_macos_name.dart';
import 'package:use_template/src/name_changer_methods/change_web_name.dart';
import 'package:use_template/src/name_changer_methods/change_windows_name.dart';

part 'src/constants.dart';
part 'src/extensions.dart';

/// Repository class to handle operations.
class UseTemplate {
  /// Private constructor.
  UseTemplate._();

  /// Singleton instance.
  static final instance = UseTemplate._();

  late final String _oldName;

  late final String _pathToInstall;

  /// Executes all the necessary operations.
  /// Uses other methods inside!
  void exec({
    required String newAppNameSnakeCase,
    required String addressOfTemplate,
    required String givenPath,
  }) {
    _pathToInstall = Directory(join(givenPath, newAppNameSnakeCase)).path;

    /* Creating directory and clonning operations. */
    try {
      // First, create the directory.
      _createDirectory(_pathToInstall);
    } catch (e) {
      printerr('${ConstStrings.couldntCreateDirectory} : $e');
      // Abort.
      return;
    }

    // If its a git repository, clone it. Else copy it from given path.
    if (addressOfTemplate.startsWith('https')) {
      String gitAddress = addressOfTemplate;

      // If address not ends with .git, add it.
      if (!addressOfTemplate.endsWith('.git')) {
        gitAddress = '$gitAddress.git';
      }
      try {
        // Clone the repository in it.
        _cloneRepository(gitAddress, _pathToInstall);
      } catch (e) {
        printerr('${ConstStrings.couldntCloneRepository} : $e');
        // Abort.
        return;
      }

      // Once repository is clonned, now check if its a valid Flutter application.
      if (!_dirContainsPubspec(_pathToInstall)) {
        printerr(ConstStrings.noPubspec);
        return;
      }
    } else {
      // If directory not exists, abort.
      if (!Directory(addressOfTemplate).existsSync()) {
        printerr('${ConstStrings.noDirectory} : $addressOfTemplate');
        return;
      }

      // If directory not contains pubspec.yaml, then it is not a valid Flutter project.
      if (!_dirContainsPubspec(addressOfTemplate)) {
        printerr(ConstStrings.noPubspec);
        return;
      }

      try {
        // Copy the project in it.
        _copyPath(from: addressOfTemplate, to: _pathToInstall);
      } catch (e) {
        printerr('${ConstStrings.couldntCopyFilesFromTemplate} : $e');
        // Abort.
        return;
      }
    }

    /* Getting old name from pubspec and doing necessary naming operations of the project. */
    try {
      // Set oldName
      _oldName = _getOldName(_pathToInstall);
    } catch (e) {
      printerr('${ConstStrings.couldntGetOldName} : $e');
      // Abort.
      return;
    }
    // Split and upper first chars of words.
    List<String> newNameSplittedList = newAppNameSnakeCase.split('_');
    newNameSplittedList =
        newNameSplittedList.map((word) => word.capitalize()).toList();
    final newNameUpperedFirstChars = newNameSplittedList.join(' ');

    /* Changing different platform names. */

    // If Android path does not exists, do not try to change Android name.
    if (!Directory(join(_pathToInstall, 'android')).existsSync()) {
      printerr(
        ConstStrings.couldntFindDir('Android'),
      );
    } else {
      try {
        // Change Android name.
        changeAndroidName(
          baseFolderPath: _pathToInstall,
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
    if (!Directory(join(_pathToInstall, 'ios')).existsSync()) {
      printerr(
        ConstStrings.couldntFindDir('IOS'),
      );
    } else {
      try {
        // Change iOS name.
        changeIOSName(
          baseFolderPath: _pathToInstall,
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
    if (!Directory(join(_pathToInstall, 'web')).existsSync()) {
      printerr(
        ConstStrings.couldntFindDir('Web'),
      );
    } else {
      try {
        // Change web name.
        changeWebName(
          baseFolderPath: _pathToInstall,
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
    if (!Directory(join(_pathToInstall, 'linux')).existsSync()) {
      printerr(
        ConstStrings.couldntFindDir('Linux'),
      );
    } else {
      try {
        // Change Linux name.
        changeLinuxName(
          baseFolderPath: _pathToInstall,
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
    if (!Directory(join(_pathToInstall, 'macos')).existsSync()) {
      printerr(
        ConstStrings.couldntFindDir('MacOS'),
      );
    } else {
      try {
        // Change MacOS name.
        changeMacOSName(
          baseFolderPath: _pathToInstall,
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
    if (!Directory(join(_pathToInstall, 'windows')).existsSync()) {
      printerr(
        ConstStrings.couldntFindDir('Windows'),
      );
    } else {
      try {
        // Change Windows name.
        changeWindowsName(
          baseFolderPath: _pathToInstall,
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
        baseFolderPath: _pathToInstall,
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
        baseFolderPath: _pathToInstall,
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
        baseFolderPath: _pathToInstall,
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
      _removeOldGitFiles(_pathToInstall);
    } catch (e) {
      printerr('${ConstStrings.couldntRemoveOldGit} : $e');
      // Didn't use return. Because it's not a critical error.
    }

    /* Finally, run 'flutter pub get' */
    _runFlutterPubGet(_pathToInstall);

    // ignore: avoid_print
    print('DONE.');
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

  // Copies the files from the folder to the new folder.
  void _copyPath({required String from, required String to}) {
    if (Platform.isWindows) {
      run('xcopy /E /Y $from $to', runInShell: true);
    } else {
      run('cp -r $from $to', runInShell: true);
    }
  }

  bool _dirContainsPubspec(String path) {
    return File(join(path, 'pubspec.yaml')).existsSync();
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
