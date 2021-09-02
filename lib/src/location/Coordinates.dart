import 'package:f8n/f8n.dart';

class Coordinates implements INullSafetyObject
{
  static const empty = _EmptyCoordinates();

  final double latitude;
  final double longitude;

  const Coordinates(this.latitude, this.longitude);

  @override
  bool operator ==(other) {
    return (other is Coordinates)
        && other.latitude == latitude
        && other.longitude == longitude;
  }

  @override
    int get hashCode => latitude.hashCode ^ longitude.hashCode;

  @override
  String toString() {
    return 'latitude=$latitude, longitude=$longitude';
  }

  @override
  bool get isEmpty => false;

  @override
  bool get isNotEmpty => !isEmpty;
}

class _EmptyCoordinates extends Coordinates {
  const _EmptyCoordinates() : super(double.nan, double.nan);

  @override
  bool get isEmpty => false;

}