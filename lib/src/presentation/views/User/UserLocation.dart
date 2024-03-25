import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:location/location.dart' as loc;
import 'package:lottie/lottie.dart';
import 'package:permission_handler/permission_handler.dart';

class LocationPage extends StatefulWidget {
  const LocationPage({Key? key}) : super(key: key);

  @override
  State<LocationPage> createState() => _LocationState();
}

class _LocationState extends State<LocationPage> {
  bool isLoading = false;
  loc.LocationData? locationData;
  List<Placemark>? placemarks;

  @override
  void initState() {
    super.initState();
    getPermission();
  }

  void getPermission() async {
    if (await Permission.location.isGranted) {
      getLocation();
    } else {
      Permission.location.request();
    }
  }

  void getLocation() async {
    setState(() {
      isLoading = true;
    });
    locationData = await loc.Location.instance.getLocation();
    setState(() {
      isLoading = false;
    });
  }

  void getAddress() async {
    if (locationData != null &&
        locationData!.latitude != null &&
        locationData!.longitude != null) {
      setState(() {
        isLoading = true;
      });
      try {
        placemarks = await placemarkFromCoordinates(
            locationData!.latitude!, locationData!.longitude!);
      } catch (e) {
        print('Error getting address: $e');
      } finally {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Location',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            const SizedBox(
              height: 80,
            ),
            Lottie.asset(
              'assets/location.json', 
              width: 200,
              height: 200,
              fit: BoxFit.cover,
            ),
            const SizedBox(
              height: 20,
            ),
            Text(locationData != null
                ? "Latitude: ${locationData!.latitude}"
                : "Latitude: Not Available"),
            Text(locationData != null
                ? "Longitude: ${locationData!.longitude}"
                : "Longitude: Not Available"),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: getPermission,
              child: const Text("Get Location"),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(placemarks != null && placemarks!.isNotEmpty
                ? "Address: ${placemarks![0].street},${placemarks![0].locality},${placemarks![0].postalCode}, ${placemarks![0].country}"
                : "Address: Not Available"),
            const SizedBox(
              height: 40,
            ),
            ElevatedButton(
              onPressed: getAddress,
              child: const Text("Get Address"),
            ),
          ],
        ),
      ),
    );
  }
}