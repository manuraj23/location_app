import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GeocodingService {
  Future<LatLng> getCoordinatesFromAddress(String address) async {
    List<Location> locations = await locationFromAddress(address);
    return LatLng(locations.first.latitude, locations.first.longitude);
  }
}
