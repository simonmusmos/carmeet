import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
// import 'package:location/location.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final locationController = Location();
  static const LatLng sourceLocation = LatLng(14.360833441472716, 120.89692393704539);
  Set<Marker>? _markers = <Marker>{};
  BitmapDescriptor? myMarker;
  LatLng? currentPosition;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async => await fetchLocationUpdates());
  }

  @override
  Widget build(BuildContext context) {

    setMarkerIcon();
    return Scaffold(
      body: currentPosition == null ? 
        const Center(
          child: CircularProgressIndicator(),
        ) : 
        GoogleMap(
          initialCameraPosition: CameraPosition(
            target: currentPosition!, 
            zoom: 16
          ),
          markers: {
            Marker(
              markerId: const MarkerId('currentLocation'),
              icon: myMarker!,
              position: currentPosition!,
              anchor: Offset(0.5, 0.5)
              
            )
          },
          circles: Set.from([
            Circle(
              circleId: CircleId('currentLocationCircle'),
              center: currentPosition!,
              radius: 500,
              fillColor: Colors.blue.shade100.withOpacity(0.5),
              strokeColor:  Color(0xFF42A5F5).withOpacity(0.5),
              strokeWidth: 1,
            )
          ]),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.pin_drop),
              label: "Map"
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today),
              label: "Schedule"
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: "Settings"
            ),
          ],
        ),
    );
  }

  Future<void> fetchLocationUpdates() async{
    bool serviceEnaled;
    PermissionStatus permissionGranted;
    serviceEnaled = await locationController.serviceEnabled();
    if (serviceEnaled) {
      serviceEnaled = await locationController.requestService();
    } else {
      return;
    }
    permissionGranted = await locationController.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await locationController.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
    locationController.onLocationChanged.listen((currentLocation) {
      if (currentLocation.latitude != null && currentLocation.longitude != null) {
        setState(() {
          currentPosition = LatLng(currentLocation.latitude!, currentLocation.longitude!);
        });
        print("current Position");
        print(currentPosition);
      }
    });
  }

  
  void setMarkerIcon() async {
    myMarker = await BitmapDescriptor.fromAssetImage(
    const ImageConfiguration(size: Size(0.5, 0.5)),'assets/images/current_location_outside_marker.png');
  }
}