import 'package:dio/dio.dart';
import 'package:geolocator/geolocator.dart';
import '../../../../core/network/dio_client.dart';

class LocationResult {
  final String locality;
  final String pincode;
  final String fullAddress;

  LocationResult({
    required this.locality,
    required this.pincode,
    required this.fullAddress,
  });

  String get displayLocation => '$locality-$pincode';
}

class LocationService {
  final DioClient _dioClient;

  LocationService({DioClient? dioClient})
      : _dioClient = dioClient ?? DioClient.instance;

  /// Fetch location via GPS with IP-geolocation fallback
  Future<LocationResult> fetchCurrentLocation() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        return await _fetchIpLocation();
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          return await _fetchIpLocation();
        }
      }

      if (permission == LocationPermission.deniedForever) {
        return await _fetchIpLocation();
      }

      final position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(accuracy: LocationAccuracy.low),
      ).timeout(const Duration(seconds: 6));

      // Reverse geocode lat, lon via Nominatim OSM
      final response = await _dioClient.get(
        'https://nominatim.openstreetmap.org/reverse',
        queryParameters: {
          'format': 'json',
          'lat': position.latitude,
          'lon': position.longitude,
        },
        options: Options(headers: {
          'User-Agent': 'FashionApp/1.0',
        }),
      );

      if (response.statusCode == 200 && response.data != null) {
        final address = response.data['address'] ?? {};
        final city = address['city'] ?? address['town'] ?? address['village'] ?? address['county'] ?? 'Madurai';
        final pincode = address['postcode'] ?? '625006';
        final suburb = address['suburb'] ?? address['neighbourhood'] ?? city;

        return LocationResult(
          locality: '$suburb',
          pincode: '$pincode',
          fullAddress: '$suburb, $city - $pincode',
        );
      }
    } catch (_) {
      // Fallback gracefully to IP geolocation on error or timeout
    }

    return await _fetchIpLocation();
  }

  /// Fallback IP geolocation
  Future<LocationResult> _fetchIpLocation() async {
    try {
      final response = await _dioClient.get('http://ip-api.com/json');
      if (response.statusCode == 200 && response.data != null) {
        final data = response.data;
        final city = data['city'] ?? 'Madurai';
        final zip = data['zip'] ?? '625006';
        return LocationResult(
          locality: city,
          pincode: zip,
          fullAddress: '$city - $zip',
        );
      }
    } catch (_) {}

    return LocationResult(
      locality: 'Madurai',
      pincode: '625006',
      fullAddress: 'Madurai - 625006',
    );
  }

  /// Free Pincode to City & Locality API lookup with automatic fallback
  Future<List<LocationResult>> fetchLocalitiesByPincode(String pincode) async {
    final cleanPin = pincode.trim();
    
    // 1. Try India Postal Pincode API
    try {
      final response = await _dioClient.get('https://api.postalpincode.in/pincode/$cleanPin');
      if (response.statusCode == 200 && response.data != null && response.data is List) {
        final resList = response.data as List;
        if (resList.isNotEmpty && resList[0]['Status'] == 'Success') {
          final postOffices = resList[0]['PostOffice'] as List? ?? [];
          if (postOffices.isNotEmpty) {
            return postOffices.map<LocationResult>((po) {
              final name = po['Name'] ?? 'Area';
              final district = po['District'] ?? po['Block'] ?? name;
              final pin = po['Pincode'] ?? cleanPin;
              return LocationResult(
                locality: '$district ($name)',
                pincode: '$pin',
                fullAddress: '$name, $district, ${po['State'] ?? ''} - $pin',
              );
            }).toList();
          }
        }
      }
    } catch (_) {
      // Fallback to secondary API
    }

    // 2. Fallback to Zippopotam API
    try {
      final response = await _dioClient.get('https://api.zippopotam.us/in/$cleanPin');
      if (response.statusCode == 200 && response.data != null) {
        final places = response.data['places'] as List? ?? [];
        if (places.isNotEmpty) {
          return places.map<LocationResult>((place) {
            final placeName = place['place name'] ?? 'City';
            final state = place['state'] ?? '';
            return LocationResult(
              locality: placeName,
              pincode: cleanPin,
              fullAddress: '$placeName, $state - $cleanPin',
            );
          }).toList();
        }
      }
    } catch (_) {}

    return [];
  }
}