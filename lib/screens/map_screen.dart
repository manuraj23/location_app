import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location_app/services/geocoding_service.dart';

class MapScreen extends StatefulWidget {
  final String location;

  MapScreen({required this.location});

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late GoogleMapController _mapController;
  LatLng? _locationCoordinates;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _getCoordinates();
  }

  Future<void> _getCoordinates() async {
    try {
      LatLng coordinates = await GeocodingService().getCoordinatesFromAddress(widget.location);
      setState(() {
        _locationCoordinates = coordinates;
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'Location not found';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Map View')),
      body: _locationCoordinates == null
          ? Center(
        child: _errorMessage == null
            ? CircularProgressIndicator()
            : Text(_errorMessage!),
      )
          : GoogleMap(
        initialCameraPosition: CameraPosition(
          target: _locationCoordinates!,
          zoom: 12,
        ),
        markers: {
          Marker(
            markerId: MarkerId('location'),
            position: _locationCoordinates!,
          ),
        },
        onMapCreated: (controller) => _mapController = controller,
      ),
    );
  }
}
