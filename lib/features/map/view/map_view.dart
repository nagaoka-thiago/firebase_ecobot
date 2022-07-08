import 'package:flutter/material.dart';
import 'package:mapbox_gl/mapbox_gl.dart';

class MapView extends StatelessWidget {
  const MapView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Map'),
      ),
      body: MapboxMap(
        accessToken:
            'pk.eyJ1IjoidGhpYWdvLW5hZ2Fva2EiLCJhIjoiY2w1YXgxY2NnMDIwcjNqcXNlbzk2YjhkdSJ9.RHK_i-FMPZ0qg3Bnk6cQ4w',
        styleString: 'mapbox://styles/thiago-nagaoka/cl5cfhwav000614mowkhsgznp',
        initialCameraPosition: CameraPosition(
          zoom: 15.0,
          target: LatLng(14.508, 46.048),
        ),
      ),
    );
  }
}
