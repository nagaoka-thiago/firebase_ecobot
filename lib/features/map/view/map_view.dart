import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_dragmarker/dragmarker.dart';
import 'package:flutter_map_line_editor/polyeditor.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';
import 'package:permission_handler/permission_handler.dart';

class MapView extends StatefulWidget {
  const MapView({Key? key}) : super(key: key);

  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  late PolyEditor _polyEditor;
  List<Polygon> _polygons = [];
  late Location location;
  LatLng firstLocation = LatLng(45, 45);

  var _testPolygon = Polygon(
      color: Colors.red,
      points: [],
      borderStrokeWidth: 5,
      borderColor: Colors.red);

  @override
  void initState() {
    super.initState();

    Permission.location.request();
    Permission.locationAlways.request();
    Permission.locationWhenInUse.request();
    _polyEditor = PolyEditor(
        points: _testPolygon.points,
        pointIcon: Icon(Icons.location_on, size: 23, color: Colors.red),
        addClosePathMarker: true,
        intermediateIcon: Icon(Icons.lens, size: 15, color: Colors.red),
        callbackRefresh: () {
          setState(() {});
        });
    _polygons.add(_testPolygon);

    location = Location();

    location.getLocation().then((loc) => {
          setState(() {
            firstLocation = LatLng(loc.latitude!, loc.longitude!);
          })
        });

    location.onLocationChanged.listen((event) {
      setState(() {
        firstLocation = LatLng(event.latitude!, event.longitude!);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Map'),
      ),
      body: Center(
        child: FlutterMap(
          options: MapOptions(
            allowPanningOnScrollingParent: false,
            center: firstLocation,
            onTap: (_, p) {
              setState(() {
                _polyEditor.add(_testPolygon.points, p);
              });
            },
            plugins: [
              DragMarkerPlugin(),
            ],
            zoom: 13.0,
          ),
          layers: [
            TileLayerOptions(
                urlTemplate:
                    'https://api.mapbox.com/styles/v1/thiago-nagaoka/cl5cfhwav000614mowkhsgznp/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoidGhpYWdvLW5hZ2Fva2EiLCJhIjoiY2w1YXgxY2NnMDIwcjNqcXNlbzk2YjhkdSJ9.RHK_i-FMPZ0qg3Bnk6cQ4w',
                additionalOptions: {
                  'accessToken':
                      'pk.eyJ1IjoidGhpYWdvLW5hZ2Fva2EiLCJhIjoiY2w1YXgxY2NnMDIwcjNqcXNlbzk2YjhkdSJ9.RHK_i-FMPZ0qg3Bnk6cQ4w',
                  'id': 'mapbox.mapbox-streets-v8'
                }),
            MarkerLayerOptions(markers: [
              Marker(
                  point: firstLocation,
                  builder: (context) {
                    return Icon(
                      Icons.location_on_outlined,
                      color: Colors.red,
                    );
                  })
            ]),
            PolygonLayerOptions(
              polygons: _polygons,
            ),
            DragMarkerPluginOptions(markers: _polyEditor.edit()),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              _testPolygon.points.removeLast();
            });
          },
          child: Icon(Icons.delete)),
    );
  }
}
