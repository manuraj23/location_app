import 'package:flutter/material.dart';
import 'package:location_app/screens/map_screen.dart';

class LocationInputScreen extends StatefulWidget {
  @override
  _LocationInputScreenState createState() => _LocationInputScreenState();
}

class _LocationInputScreenState extends State<LocationInputScreen> {
  final _locationController = TextEditingController();
  String? _errorMessage;

  void _submitLocation() {
    if (_locationController.text.isEmpty) {
      setState(() {
        _errorMessage = 'Please enter a location';
      });
      return;
    }
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => MapScreen(location: _locationController.text),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Find Location')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _locationController,
              decoration: InputDecoration(
                labelText: 'Enter Location',
                errorText: _errorMessage,
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submitLocation,
              child: Text('Find Location'),
            ),
          ],
        ),
      ),
    );
  }
}
