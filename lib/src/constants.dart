part of '../use_template_base.dart';

/// Static class to hold constants.
class ConstStrings {
  // /// Default template.
  // static const defaultTemplate =
  //     'https://github.com/baranacikgoz/BloC_repository_pattern_template.git';

  /// Default template.
  static const defaultTemplate =
      'https://github.com/baranacikgoz/use_template_trial_repository.git';

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

  static const couldntCreateDirectory = 'Could not create directory to clone repository!';

  static const couldntCloneRepository = 'Could not clone repository!';

  static const couldntGetOldName = 'Could not get old name from pubspec.yaml!';

  static String couldntFindDir(String dirName) {
    return "Couldn't found $dirName directory, probably your app doesn't have a $dirName project.";
  }

  static String couldntChangeName(String platformName) {
    return 'Could not change $platformName name, you have to change manually!';
  }

  static String couldntChangeImports(String platformName) {
    return 'Could not change $platformName imports, you have to change manually!';
  }

  static String couldntRemoveOldGit =
      'Could not remove old git files, you have to remove manually!';
}
