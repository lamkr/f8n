abstract class IAppPermissions
{
  Future<bool> get isAllGranted;

  Future<bool> get isNotAllGranted async =>
      !await isAllGranted;

  Future requestPermissions();

  /// Returns if the [permission] is granted or not.
  /// Examples of [permission]: 'camera', 'location', 'write_external_storage',
  /// 'read_external_storage', etc.
  Future<bool> isGranted(String permission);

}
