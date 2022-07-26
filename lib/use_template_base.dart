import 'dart:io';

import 'package:dcli/dcli.dart';
import 'package:use_template/src/extensions.dart';
import 'package:use_template/src/name_changer_methods/change_android_name.dart';
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
    /// First, create the directory.
    _createDirectory(pathToInstall);

    /// Then, clone the repository in it.
    _cloneRepository(repositoryOfTemplate, pathToInstall);

    /// Then, remove old git files.
    _removeOldGitFiles(pathToInstall);

    /// Set oldName
    _oldName = _getOldName(pathToInstall);

    /// Split and upper first chars of words.
    List<String> newNameSplittedList = newAppNameSnakeCase.split('_');

    newNameSplittedList = newNameSplittedList.map((word) => word.capitalize()).toList();

    final newNameUpperedFirstChars = newNameSplittedList.join(' ');

    /// Change Android name.
    changeAndroidName(
      baseFolderPath: pathToInstall,
      oldName: _oldName,
      newNameSnakeCase: newAppNameSnakeCase,
      newNameUpperedFirstChars: newNameUpperedFirstChars,
    );

    /// Change IOS name.
    changeIOSName(
      baseFolderPath: pathToInstall,
      oldName: _oldName,
      newNameSnakeCase: newAppNameSnakeCase,
      newNameUpperedFirstChars: newNameUpperedFirstChars,
    );

    /// Change Web name.
    changeWebName(
      baseFolderPath: pathToInstall,
      oldName: _oldName,
      newNameSnakeCase: newAppNameSnakeCase,
      newNameUpperedFirstChars: newNameUpperedFirstChars,
    );

    /// Change linux name.
    changeLinuxName(
      baseFolderPath: pathToInstall,
      oldName: _oldName,
      newNameSnakeCase: newAppNameSnakeCase,
      newNameUpperedFirstChars: newNameUpperedFirstChars,
    );

    /// Change windows name.
    changeWindowsName(
      baseFolderPath: pathToInstall,
      oldName: _oldName,
      newNameSnakeCase: newAppNameSnakeCase,
      newNameUpperedFirstChars: newNameUpperedFirstChars,
    );

    /// Change macos name.
    changeMacOSName(
      baseFolderPath: pathToInstall,
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

  void _removeOldGitFiles(String baseFolderPath) {
    final gitFolder = Directory(join(baseFolderPath, '.git'));
    if (gitFolder.existsSync()) {
      gitFolder.deleteSync(recursive: true);
    }
  }

  String _getOldName(String path) {
    final pubspecFile = File(join(path, 'pubspec.yaml'));

    return pubspecFile.readAsLinesSync().first.split('name: ').last;
  }
}
