import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class LocationService {
  static Future<Position> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception('Les services de localisation sont désactivés.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception('Les permissions de localisation sont refusées.');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw Exception(
          'Les permissions de localisation sont définitivement refusées.');
    }

    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
  }

  static Future<String> getAddressFromLatLng(double lat, double lng) async {
    try {
      final places = await placemarkFromCoordinates(lat, lng);
      if (places.isNotEmpty) {
        final place = places.first;
        return '${place.street}, ${place.locality}, ${place.postalCode}';
      }
      return 'Adresse non trouvée';
    } catch (e) {
      return 'Erreur de géocodage';
    }
  }

  static Future<Location> getLatLngFromAddress(String address) async {
    try {
      final locations = await locationFromAddress(address);
      if (locations.isNotEmpty) {
        final location = locations.first;
        return location;
      }
      throw Exception('Adresse non trouvée');
    } catch (e) {
      throw Exception('Erreur de géocodage: $e');
    }
  }

  static double calculateDistance(
      double startLat, double startLng, double endLat, double endLng) {
    return Geolocator.distanceBetween(startLat, startLng, endLat, endLng);
  }
}
