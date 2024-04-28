import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:noidaone/screens/scheduledpoint.dart';


class NavigateScreen extends StatefulWidget {

  final double? lat;
  final double? long;
  NavigateScreen({super.key, this.lat, this.long});

  @override
  State<NavigateScreen> createState() => _MyAppState();
}

class _MyAppState extends State<NavigateScreen> {

  late GoogleMapController mapController;
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    // marker
    final marker = Marker(
      markerId: MarkerId('place_name'),
      position: _center,
      // icon: BitmapDescriptor.,
      infoWindow: InfoWindow(
        title: 'Position',
        snippet: '',
      ),
    );

    setState(() {
      markers[MarkerId('place_name')] = marker;
    });
  }
  late LatLng _center;
  void initState() {
    // TODO: implement initState
    print('----24---lat--${widget.lat}');
    print('----24---long---${widget.long}');
    _center = LatLng(widget.lat ?? 0.0, widget.long ?? 0.0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      // theme: ThemeData(
      //   useMaterial3: true,
      //   colorSchemeSeed: Colors.green[700],
      // ),
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Color(0xFF255899),
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
              // Navigator.push(context,
              //     MaterialPageRoute(builder: (context) => const ScheduledPointScreen()));
            },
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(Icons.arrow_back_ios,color: Colors.white),
            ),
          ),
          title: const Text(
            'Scheduled Point',
            style: TextStyle(
              fontFamily: 'Montserrat',
              color: Colors.white,
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: GoogleMap(
          mapType: MapType.normal,
         // myLocationEnabled: true,
          compassEnabled: true,
          onMapCreated: _onMapCreated,
          initialCameraPosition: CameraPosition(
            target: _center,
            zoom: 11.0,
          ),
          markers: markers.values.toSet(),
        ),
      ),
    );
  }
}

