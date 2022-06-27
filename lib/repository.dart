import 'dart:io';

import 'package:dcli/dcli.dart';

part 'constants.dart';

/// Repository class to handle operations.
class Repository {
  /// Private constructor.
  Repository._();

  /// Singleton instance.
  static final instance = Repository._();

  /// Executes all necessary operations.
  /// Uses other internal methods in the class.
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
