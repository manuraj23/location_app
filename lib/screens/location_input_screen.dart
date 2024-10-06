import 'package:flutter/material.dart';
import 'package:location_app/screens/map_screen.dart';

class LocationInputScreen extends StatefulWidget {
  @override
  _LocationInputScreenState createState() => _LocationInputScreenState();
}

class _LocationInputScreenState extends State<LocationInputScreen> {
  final _locationController = TextEditingController();
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _locationController.addListener(() {
      setState(() {
        if (_errorMessage != null && _locationController.text.isNotEmpty) {
          _errorMessage = null;
        }
      });
    });
  }

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
  void dispose() {
    _locationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Find Location'),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            SizedBox(height: 10),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Enter Location',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 8),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, width: 2),
                borderRadius: BorderRadius.circular(8),
                color: Colors.white,
              ),
              child: TextField(
                controller: _locationController,
                decoration: InputDecoration(
                  errorText: _errorMessage,
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(10),
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submitLocation,
              child: Text('Find Location'),
            ),
            // Removed the image widget
          ],
        ),
      ),
    );
  }
}
