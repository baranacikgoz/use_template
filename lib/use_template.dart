import 'dart:io';

import 'package:dcli/dcli.dart';

part 'constants.dart';

/// Class to handle operations.
class UseTemplate {
  /// Private constructor.
  UseTemplate._();

  /// Singleton instance.
  static final instance = UseTemplate._();

  /// This method executes all necessary operations.
  /// Uses the other internal methods in the class.
  void exec({
    required String newAppName,
    required String repositoryOfTemplate,
    required String pathToInstall,
  }) {
    // First, create the directory.
    _createDirectory(pathToInstall);

    // Then, clone the repository in it.
    _cloneRepository(repositoryOfTemplate, pathToInstall);
  }

  void _createDirectory(String path) {
    if (!Directory(path).existsSync()) {
      Directory(path).createSync(recursive: true);
    }
  }

  void _cloneRepository(String repository, String path) {
    'git clone $repository $path'.run;
  }
}
