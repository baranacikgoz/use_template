import 'dart:io';

import 'package:dcli/dcli.dart';
import 'package:use_template/use_template_base.dart';

void main(List<String> arguments) {
  late final String _newAppName;

  late final String _repositoryOfTemplate;

  late final String _pathToInstall;

  /*
  3 arguments means all of the name, repository and path is given.
  0 arguments means nothing is given, user will continue to the cli.
   */
  if (!(arguments.length == 3 || arguments.isEmpty)) {
    printerr(ConstStrings.wrongNumberOfArguments);
    return;
  }

  if (arguments.length == 3) {
    // Check if arguments[0] obeys regexp for being a valid flutter name.
    if (!RegExp(r'^[a-z_]+$').hasMatch(arguments[0])) {
      printerr(ConstStrings.mustPassSnackCaseName);
      return;
    }

    _newAppName = arguments[0];

    // Check if arguments[1] obeys regexp for a valid git repository or if it is an existing directory in the computer.
    if (!(RegExp('^(https|git)://').hasMatch(arguments[1]) ||
        Directory(arguments[1]).existsSync())) {
      printerr(ConstStrings.repoOfTemplateText);
      return;
    }

    _repositoryOfTemplate = arguments[1];

    _pathToInstall = arguments[2];
  } else {
    // Arguments is empty therefore user will use interactive interface.
    _newAppName = ask(
      ConstStrings.enterAppNameText,
      validator: Ask.regExp(
        r'^[a-z_]+$',
        error: ConstStrings.mustPassSnackCaseName,
      ),
    );

    String _givenRepository = '_';

    // While given repository is not empty nor valid, ask again.
    while (!(_givenRepository.isEmpty ||
        RegExp('^(https|git)://').hasMatch(_givenRepository) ||
        Directory(_givenRepository).existsSync())) {
      _givenRepository = ask(
        ConstStrings.repoOfTemplateText,
        required: false,
      );
    }

    // If given repository address is empty, use default template.
    // Else use the given.
    _givenRepository.isEmpty
        ? _repositoryOfTemplate = ConstStrings.defaultTemplate
        : _repositoryOfTemplate = _givenRepository;

    final _givenPath = ask(
      ConstStrings.pathToInstallText,
      required: false,
    );

    // If given path is empty, use current path.
    // Else use the given.
    _givenPath.isEmpty
        ? _pathToInstall = truepath(_newAppName)
        : _pathToInstall = truepath('$_givenPath/$_newAppName');
  }

  // Execute the operations.
  UseTemplateBase.instance.exec(
    newAppNameSnakeCase: _newAppName,
    addressOfTemplate: _repositoryOfTemplate,
    pathToInstall: _pathToInstall,
  );
}
