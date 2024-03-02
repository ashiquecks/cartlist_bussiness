import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapScreen extends StatefulWidget {
  final double orderLat;
  final double orderlong;
  const GoogleMapScreen(
      {super.key, required this.orderLat, required this.orderlong});

  @override
  State<GoogleMapScreen> createState() => _GoogleMapScreenState();
}

class _GoogleMapScreenState extends State<GoogleMapScreen> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  // static const CameraPosition _kGooglePlex = CameraPosition(
  //   target: LatLng(37.42796133580664, -122.085749655962),
  //   zoom: 14.4746,
  // );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Order Location"),
      ),
      body: GoogleMap(
        myLocationEnabled: true,
        markers: {
          Marker(
            markerId: const MarkerId("marker1"),
            position: LatLng(widget.orderLat, widget.orderlong),
            draggable: true,
            onDragEnd: (value) {
              // value is the new position
            },
            // To do: custom marker icon
          ),
        },
        mapType: MapType.normal,
        initialCameraPosition: CameraPosition(
          target: LatLng(widget.orderLat, widget.orderlong),
          zoom: 14.4746,
        ),
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
    );
  }
}
