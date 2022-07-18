// ignore_for_file: library_private_types_in_public_api

import 'package:firebase_ecobot/core/models/geo_coordinates_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_line_editor/polyeditor.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';
import 'package:mobx/mobx.dart';
part 'map_view_controller.g.dart';

class MapViewController = _MapViewControllerBase with _$MapViewController;

abstract class _MapViewControllerBase with Store {
  var box = Hive.box<GeoCoordinatesModel>('temp-coordinates');

  // final List<GeoCoordinatesModel> formatedsPoints = [];

  @observable
  ObservableList<GeoCoordinatesModel> formatedsPoints2 =
      <GeoCoordinatesModel>[].asObservable();

  @observable
  var testPolygon = Polygon(
      color: Colors.red,
      points: [],
      borderStrokeWidth: 5,
      borderColor: Colors.red);

  @observable
  late PolyEditor polyEditor =
      PolyEditor(points: [], pointIcon: const Icon(Icons.abc_outlined));

  @observable
  late ObservableList<Polygon> polygons = [Polygon(points: [])].asObservable();

  @observable
  late Location location = Location();

  @observable
  late LatLng firstLocation = LatLng(45.0, -0.09);

  @observable
  bool isInitialized = false;

  @observable
  bool aux = false;

  @action
  setFirstLocation(LatLng newValue) {
    firstLocation = newValue;
  }

  @action
  initializeAll() {
    isInitialized = false;
    testPolygon = Polygon(
        color: Colors.red,
        points: [],
        borderStrokeWidth: 5,
        borderColor: Colors.red);

    polyEditor = PolyEditor(
        points: testPolygon.points,
        pointIcon: const Icon(Icons.location_on, size: 23, color: Colors.red),
        addClosePathMarker: true,
        intermediateIcon: const Icon(Icons.lens, size: 15, color: Colors.red),
        callbackRefresh: () {
          aux = !aux;
        });
    polygons = ObservableList<Polygon>();
    polygons.add(testPolygon);
    isInitialized = true;
  }

  @action
  initializeLocation(MapController mapController) async {
    LocationData locData;
    location = Location();

    locData = await location.getLocation();

    setFirstLocation(LatLng(locData.latitude!, locData.longitude!));

    location.onLocationChanged.listen((event) =>
        {setFirstLocation(LatLng(event.latitude!, event.longitude!))});

    mapController.onReady.then((_) => mapController.move(firstLocation, 17));
  }

  @action
  refresh() {
    aux = !aux;
  }

  @action
  addPoint(LatLng point) {
    polyEditor.add(testPolygon.points, point);
  }

  @action
  removePoint() {
    testPolygon.points.removeLast();
  }

  @action
  formatCoordinates() {
    final polygonCoordinates = testPolygon.points;
    for (var coordinate in polygonCoordinates) {
      formatedsPoints2.add(GeoCoordinatesModel(
        latitude: coordinate.latitude,
        longitude: coordinate.longitude,
      ));
    }
    return formatedsPoints2;
  }

  @action
  temporarilySaveLocationCoordinates() {
    for (var coordinate in formatedsPoints2) {
      box.add(
        GeoCoordinatesModel(
          latitude: coordinate.latitude,
          longitude: coordinate.longitude,
        ),
      );
    }
    debugPrint("This is what is saved: ${box.values.first.latitude}");
  }

  @action
  deleteHiveTempData() {
    box.clear();
    debugPrint(box.values.toString());
  }
}
