import 'package:f8n/f8n.dart';

class Location implements INullSafetyObject
{
  static Location invalid = _InvalidLocation();

  /// Latitude, in degrees
  final double latitude;
  /// Longitude, in degrees
  final double longitude;
  /// Estimated horizontal accuracy of this location, radial, in meters
  final double accuracy;
  /// In meters above the WGS 84 reference ellipsoid
  final double altitude;
  /// In meters/second
  final double speed;
  /// In meters/second, always 0 on iOS
  final double speedAccuracy;
  /// Heading is the horizontal direction of travel of this device, in degrees
  final double heading;
  /// timestamp of the Location
  final DateTime time;

  const Location(this.latitude, this.longitude, this.accuracy, this.altitude
      , this.speed, this.speedAccuracy, this.heading, this.time);

  Location.fromCoordinates(double latitude, double longitude)
    : this(latitude, longitude, 0, 0, 0, 0, 0, DateTime.now());

  @override
  bool operator ==(other) {
    return (other is Location)
        && other.latitude == latitude
        && other.longitude == longitude
        && other.accuracy == accuracy
        && other.altitude == altitude
        && other.speed == speed
        && other.speedAccuracy == speedAccuracy
        && other.heading == heading
        && other.time == time;
  }

  @override
  int get hashCode =>
      latitude.hashCode
    ^ longitude.hashCode
    ^ accuracy.hashCode
    ^ altitude.hashCode
    ^ speed.hashCode
    ^ speedAccuracy.hashCode
    ^ heading.hashCode
    ^ time.hashCode;

  @override
  bool get isEmpty => !isNotEmpty;

  @override
  bool get isNotEmpty => true;
}

class _InvalidLocation extends Location {
  _InvalidLocation()
    : super(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, DateTime(0));

  @override
  bool get isNotEmpty => false;
}