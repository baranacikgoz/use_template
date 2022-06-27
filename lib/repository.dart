import 'dart:io';

import 'package:dcli/dcli.dart';

part 'constants.dart';

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
    required String newAppName,
    required String repositoryOfTemplate,
    required String pathToInstall,
  }) {
    // First, create the directory.
    _createDirectory(pathToInstall);

    // Get into the directory.
    _changeDirectory(pathToInstall);

    // Then, clone the repository in it.
    _cloneRepository(repositoryOfTemplate);

    // Set oldName
    _oldName = _getOldName();
  }

  void _createDirectory(String path) {
    if (!Directory(path).existsSync()) {
      Directory(path).createSync(recursive: true);
    }
  }

  void _changeDirectory(String path) {
    'cd $path'.run;
  }

  void _cloneRepository(String repository) {
    'git clone $repository'.run;
  }

  String _getOldName() {
    final pubspecFile = find('pubspec.yaml', caseSensitive: true, recursive: false);

    return pubspecFile.firstLine!.split('name: ')[1];
  }
}
