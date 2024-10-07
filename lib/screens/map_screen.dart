import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
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
  MapType _currentMapType = MapType.normal;
  LatLng? _userLocation; // For user's current location

  @override
  void initState() {
    super.initState();
    _getCoordinates();
    _getUserLocation();
  }

  Future<void> _getCoordinates() async {
    try {
      LatLng coordinates = await GeocodingService().getCoordinatesFromAddress(widget.location);
      setState(() {
        _locationCoordinates = coordinates;
      });
      // Move the camera to the searched location once coordinates are obtained
      if (_mapController != null) {
        _mapController.animateCamera(
          CameraUpdate.newLatLng(coordinates),
        );
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Location not found';
      });
    }
  }

  Future<void> _getUserLocation() async {
    Location location = new Location();
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _locationData = await location.getLocation();
    setState(() {
      _userLocation = LatLng(_locationData.latitude!, _locationData.longitude!);
    });

    if (_mapController != null && _locationCoordinates != null) {
      _mapController.animateCamera(
        CameraUpdate.newLatLng(_locationCoordinates!),
      );
    }
  }

  void _selectMapType() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.map),
              title: Text('Normal'),
              onTap: () {
                setState(() {
                  _currentMapType = MapType.normal;
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.satellite),
              title: Text('Satellite'),
              onTap: () {
                setState(() {
                  _currentMapType = MapType.satellite;
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.terrain),
              title: Text('Terrain'),
              onTap: () {
                setState(() {
                  _currentMapType = MapType.terrain;
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.layers),
              title: Text('Hybrid'),
              onTap: () {
                setState(() {
                  _currentMapType = MapType.hybrid;
                });
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Map View'),
        backgroundColor: Colors.green, // Set AppBar color to green
      ),
      body: Column(
        children: [
          Expanded(
            child: _locationCoordinates == null
                ? Center(
              child: _errorMessage == null
                  ? CircularProgressIndicator()
                  : Text(_errorMessage!),
            )
                : Stack(
              children: [
                GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: _locationCoordinates!,
                    zoom: 12,
                  ),
                  markers: {
                    Marker(
                      markerId: MarkerId('location'),
                      position: _locationCoordinates!,
                    ),
                    if (_userLocation != null)
                      Marker(
                        markerId: MarkerId('user_location'),
                        position: _userLocation!,
                        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
                      ),
                  },
                  mapType: _currentMapType,
                  onMapCreated: (controller) => _mapController = controller,
                ),
                Positioned(
                  bottom: 16, // Position at the bottom
                  left: 16,   // Position on the left
                  child: FloatingActionButton(
                    onPressed: _selectMapType,
                    child: Icon(Icons.layers),
                    tooltip: 'Switch Map Type',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
