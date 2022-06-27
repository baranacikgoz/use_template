part of 'repository.dart';

/// Static class to hold constants.
class Constants {
  /// Git clone command.
  static const gitClone = 'git clone ';

  /// Default template.
  static const defaultTemplate =
      'https://github.com/baranacikgoz/BloC_repository_pattern_template.git';

  /// Enter new app's name text.
  static const enterAppNameText = 'Enter your new app name: ';

  /// You must pass a snack case text.
  static const mustPassSnackCaseName = 'You must pass a snack case like my_new_app_name';

  /// Repository of template text.
  static const repoOfTemplateText = 'Enter the git repository of the template. '
      'Leave empty if you want to use the default template: ';

  /// Path to install text.
  static const pathToInstallText = 'Absolute path to install your app. '
      'The default is the current path if you leave empty: ';
}
