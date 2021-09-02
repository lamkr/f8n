import 'package:f8n/assets.dart';
import 'package:f8n/injection.dart';
import 'package:f8n/locales.dart';
import 'package:f8n/configuration.dart';
import 'package:f8n/location.dart';
import 'package:f8n/log.dart';
import 'package:f8n/security.dart';
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

