# Location-Based Flutter App

## Overview
This Flutter application allows users to input a location (city name or address) and displays it on a map. The app demonstrates key skills in managing user input, integrating maps, and implementing state management.

## Features
- **Location Input:** A simple screen where users can input a location using a text field.
- **Map Integration:** Displays the entered location on a map with a marker.
- **Basic Validation:** Ensures that the location input is not left empty.
- **Error Handling:** Graceful handling of invalid or non-existent locations.

## Screens
1. **Location Input Screen:**
   - A text field where users can input a location (city name, address, or coordinates).
   - Basic validation to ensure the field is not left empty.
   - A button that takes the user to the map screen after the location is entered.

2. **Map Display Screen:**
   - Displays a map showing the entered location.
   - The location is marked on the map using a marker.
   - The map is integrated using a Flutter package like `google_maps_flutter`.



## Screensorts: 

![image](https://github.com/user-attachments/assets/3d9f1093-48bd-4bb7-8c1d-6dd15ccab123)
<br>
![Screenshot from 2024-10-07 15-30-21](https://github.com/user-attachments/assets/0a4105b4-fe5c-4f24-85e3-ccef0c923b36)
<br>
![Screenshot from 2024-10-07 15-30-30](https://github.com/user-attachments/assets/65b00794-1ca7-4745-ad2b-d18bd4521141)
<br>
![Screenshot from 2024-10-07 15-33-35](https://github.com/user-attachments/assets/ca2f82d1-c059-4dea-bb9e-7f8bdd3c0264)

### Prerequisites
- Ensure you have [Flutter](https://flutter.dev/docs/get-started/install) installed on your machine.
- You will also need an IDE like Android Studio, Visual Studio Code, or IntelliJ IDEA.

### Steps to Run the App

1. **Clone the Repository:**
   Open your terminal and clone the repository:
   ```bash
   git clone https://github.com/manuraj23/location_app/

2.Install Dependencies: Navigate to the project directory and run:

bash
Copy code
flutter pub get
Obtain Google Maps API Key:

Create a project in the Google Cloud Console.
Enable the Maps SDK for Android and Maps SDK for iOS.
Create an API key and restrict it to your app's package name (Android) and Bundle ID (iOS).

3. Run the App:

Connect a device or start an emulator.
Run the app using the following command:
bash
Copy code
flutter run
