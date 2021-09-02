import 'package:cleanarch/assets.dart';
import 'package:cleanarch/injection.dart';
import 'package:cleanarch/locales.dart';
import 'package:cleanarch/configuration.dart';
import 'package:cleanarch/location.dart';
import 'package:cleanarch/log.dart';
import 'package:cleanarch/security.dart';
import 'package:package_info_plus/package_info_plus.dart';

abstract class IApplicationContext
{
  IInjector get injector;

  IAssets get assets;

  IIntl get intl;

  IConfiguration get configuration;

  PackageInfo get appInfo;

  IAppPermissions get permissions;

  /// TODO This shouldn't be part of application context.
  ILogger get log;

  ILocationService get location;
}

