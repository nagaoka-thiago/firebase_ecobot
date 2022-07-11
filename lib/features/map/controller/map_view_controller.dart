import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_line_editor/polyeditor.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';
import 'package:mobx/mobx.dart';
part 'map_view_controller.g.dart';

class MapViewController = _MapViewControllerBase with _$MapViewController;

abstract class _MapViewControllerBase with Store {
  @observable
  var _testPolygon = Polygon(
      color: Colors.red,
      points: [],
      borderStrokeWidth: 5,
      borderColor: Colors.red);

  @observable
  late PolyEditor polyEditor;

  @observable
  late ObservableList<Polygon> polygons;

  @observable
  late Location location;

  @observable
  late LatLng firstLocation;

  @observable
  bool isInitialized = false;

  @observable
  bool aux = false;

  @action
  initializeAll() {
    isInitialized = false;
    _testPolygon = Polygon(
        color: Colors.red,
        points: [],
        borderStrokeWidth: 5,
        borderColor: Colors.red);

    polyEditor = PolyEditor(
        points: _testPolygon.points,
        pointIcon: Icon(Icons.location_on, size: 23, color: Colors.red),
        addClosePathMarker: true,
        intermediateIcon: Icon(Icons.lens, size: 15, color: Colors.red),
        callbackRefresh: () {
          aux = !aux;
        });
    polygons = ObservableList<Polygon>();
    polygons.add(_testPolygon);

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
    polyEditor.add(_testPolygon.points, point);
  }

  @action
  removePoint() {
    _testPolygon.points.removeLast();
  }
}
