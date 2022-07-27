import 'dart:io';

import 'package:dcli/dcli.dart';

/// Changes Web name of the project.
void changeWebName({
  required String baseFolderPath,
  required String oldName,
  required String newNameSnakeCase,
  required String newNameUpperedFirstChars,
}) {
  final webIndexFile = File(join(baseFolderPath, 'web', 'index.html'));
  final webIndexContent = webIndexFile.readAsStringSync();

  webIndexFile.writeAsStringSync(
    webIndexContent.replaceAll(oldName, newNameUpperedFirstChars),
  );

  final webManifestFile = File(join(baseFolderPath, 'web', 'manifest.json'));
  final webManifestContent = webManifestFile.readAsStringSync();

  webManifestFile.writeAsStringSync(
    webManifestContent.replaceAll(oldName, newNameSnakeCase),
  );
}
