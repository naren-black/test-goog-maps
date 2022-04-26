import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'src/locations.dart' as locations;
// import 'package:google_maps_flutter_web/google_maps_flutter_web.dart';

void main() {
  runApp(const NarMap());
}

class NarMap extends StatefulWidget {
  const NarMap({Key? key}) : super(key: key);

  @override
  State<NarMap> createState() => _NarMapState();
}

class _NarMapState extends State<NarMap> {
  // late GoogleMapController mapCtlr;
  // final LatLng _center = const LatLng(27.2046, 77.4977);

  final Map<String, Marker> _markers = {};

  Future<void> _onMapCreated(GoogleMapController ctlr) async {
    final googOfc = await locations.getGoogleOffices();
    setState(() {
      _markers.clear();
      for (final offc in googOfc.offices) {
        final mrkr = Marker(
          markerId: MarkerId(offc.name),
          position: LatLng(offc.lat, offc.lng),
          infoWindow: InfoWindow(
            title: offc.name,
            snippet: offc.address,
          ),
        );
        _markers[offc.name] = mrkr;
      }
    });
    // mapCtlr = ctlr;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Naren shows his maps",
      home: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: const CameraPosition(
          // target: LatLng(0, 0),
          target: LatLng(33.9791, 150.8545),
          zoom: 2.0,
        ),
        markers: _markers.values.toSet(),
      ),
    );
  }
}
