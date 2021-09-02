abstract class IAppPermissions
{
  Future<bool> get isAllGranted async =>
      await isCameraGranted
          && await isLocationGranted
          && await isReadExternalStorageGranted
          && await isWriteExternalStorageGranted;

  Future<bool> get isNotAllGranted async =>
      !await isAllGranted;

  Future requestPermissions();

  Future<bool> get isCameraGranted;

  Future<bool> get isLocationGranted;

  Future<bool> get isWriteExternalStorageGranted;

  Future<bool> get isReadExternalStorageGranted;
}
