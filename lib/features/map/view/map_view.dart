import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_dragmarker/dragmarker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../form/view/form_page.dart';
import '../controller/map_view_controller.dart';

class MapView extends StatefulWidget {
  const MapView({Key? key}) : super(key: key);

  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  late MapViewController controller;
  MapController mapController = MapController();

  @override
  void initState() {
    super.initState();

    Permission.location.request();
    Permission.locationAlways.request();
    Permission.locationWhenInUse.request();

    controller = MapViewController();
    controller.initializeAll();
    controller.initializeLocation(mapController);
  }

  @override
  Widget build(BuildContext context) {
    Widget widget = Scaffold(
      appBar: AppBar(
        title: const Text('Map'),
      ),
      body: Center(
        child: Observer(builder: (_) {
          return FlutterMap(
            mapController: mapController,
            options: MapOptions(
              allowPanningOnScrollingParent: false,
              center: controller.firstLocation,
              onTap: (_, p) {
                controller.addPoint(p);
                debugPrint(controller.testPolygon.points.toString());
              },
              plugins: [
                DragMarkerPlugin(),
              ],
              zoom: 9.2,
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
                    point: controller.firstLocation,
                    builder: (context) {
                      return const Icon(
                        Icons.location_on_outlined,
                        color: Colors.red,
                      );
                    })
              ]),
              PolygonLayerOptions(
                polygons: controller.polygons,
              ),
              DragMarkerPluginOptions(markers: controller.polyEditor.edit()),
            ],
          );
        }),
      ),
      floatingActionButton: Observer(builder: (_) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              onPressed: () async {
                await controller.formatCoordinates();
                await controller.temporarilySaveLocationCoordinates();
                await Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const FormPage(),
                  ),
                );
                // Navigator.pop(context);
              },
              child: const Icon(Icons.save),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: FloatingActionButton(
                onPressed: () {
                  controller.removePoint();
                  controller.deleteHiveTempData();
                },
                child: const Icon(Icons.delete),
              ),
            ),
          ],
        );
      }),
    );

    return widget;
  }
}
