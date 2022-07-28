import 'package:dcli/dcli.dart';
import 'package:use_template/use_template_base.dart';

void main(List<String> arguments) {
  late final String _newAppName;

  late final String _repositoryOfTemplate;

  late final String _pathToInstall;

  /// Arguments is empty therefore user will use interactive interface.
  if (arguments.isEmpty) {
    _newAppName = ask(
      ConstStrings.enterAppNameText,
      validator: Ask.regExp(
        r'^[a-z_]+$',
        error: ConstStrings.mustPassSnackCaseName,
      ),
    );

    final _givenRepository = ask(
      ConstStrings.repoOfTemplateText,
      required: false,
    );

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
    repositoryOfTemplate: _repositoryOfTemplate,
    pathToInstall: _pathToInstall,
  );
}
