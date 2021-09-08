class AppInfo
{
  /// The app name. `CFBundleDisplayName` on iOS, `application/label` on Android.
  final String name;

  /// The package name. `bundleIdentifier` on iOS, `getPackageName` on Android.
  final String package;

  /// The package version. `CFBundleShortVersionString` on iOS, `versionName` on Android.
  final String version;

  /// The build number. `CFBundleVersion` on iOS, `versionCode` on Android.
  final String buildNumber;

  AppInfo(this.name, this.package, this.version, this.buildNumber);
}