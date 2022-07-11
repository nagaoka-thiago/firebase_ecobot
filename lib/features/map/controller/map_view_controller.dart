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
      PolyEditor(points: [], pointIcon: Icon(Icons.abc_outlined));

  @observable
  late ObservableList<Polygon> polygons = [Polygon(points: [])].asObservable();

  @observable
  late Location location = Location();

  @observable
  late LatLng firstLocation = LatLng(0, 0);

  @observable
  bool isInitialized = false;

  @observable
  bool aux = false;

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
        pointIcon: Icon(Icons.location_on, size: 23, color: Colors.red),
        addClosePathMarker: true,
        intermediateIcon: Icon(Icons.lens, size: 15, color: Colors.red),
        callbackRefresh: () {
          aux = !aux;
        });
    polygons = ObservableList<Polygon>();
    polygons.add(testPolygon);

    location = Location();

    location
        .getLocation()
        .then((loc) => {firstLocation = LatLng(loc.latitude!, loc.longitude!)});

    location.onLocationChanged.listen((event) {
      firstLocation = LatLng(event.latitude!, event.longitude!);
    });
    isInitialized = true;
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
