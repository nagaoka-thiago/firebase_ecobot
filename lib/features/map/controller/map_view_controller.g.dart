// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'map_view_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$MapViewController on _MapViewControllerBase, Store {
  late final _$_testPolygonAtom =
      Atom(name: '_MapViewControllerBase._testPolygon', context: context);

  @override
  Polygon get _testPolygon {
    _$_testPolygonAtom.reportRead();
    return super._testPolygon;
  }

  @override
  set _testPolygon(Polygon value) {
    _$_testPolygonAtom.reportWrite(value, super._testPolygon, () {
      super._testPolygon = value;
    });
  }

  late final _$polyEditorAtom =
      Atom(name: '_MapViewControllerBase.polyEditor', context: context);

  @override
  PolyEditor get polyEditor {
    _$polyEditorAtom.reportRead();
    return super.polyEditor;
  }

  @override
  set polyEditor(PolyEditor value) {
    _$polyEditorAtom.reportWrite(value, super.polyEditor, () {
      super.polyEditor = value;
    });
  }

  late final _$polygonsAtom =
      Atom(name: '_MapViewControllerBase.polygons', context: context);

  @override
  ObservableList<Polygon> get polygons {
    _$polygonsAtom.reportRead();
    return super.polygons;
  }

  @override
  set polygons(ObservableList<Polygon> value) {
    _$polygonsAtom.reportWrite(value, super.polygons, () {
      super.polygons = value;
    });
  }

  late final _$locationAtom =
      Atom(name: '_MapViewControllerBase.location', context: context);

  @override
  Location get location {
    _$locationAtom.reportRead();
    return super.location;
  }

  @override
  set location(Location value) {
    _$locationAtom.reportWrite(value, super.location, () {
      super.location = value;
    });
  }

  late final _$firstLocationAtom =
      Atom(name: '_MapViewControllerBase.firstLocation', context: context);

  @override
  LatLng get firstLocation {
    _$firstLocationAtom.reportRead();
    return super.firstLocation;
  }

  @override
  set firstLocation(LatLng value) {
    _$firstLocationAtom.reportWrite(value, super.firstLocation, () {
      super.firstLocation = value;
    });
  }

  late final _$isInitializedAtom =
      Atom(name: '_MapViewControllerBase.isInitialized', context: context);

  @override
  bool get isInitialized {
    _$isInitializedAtom.reportRead();
    return super.isInitialized;
  }

  @override
  set isInitialized(bool value) {
    _$isInitializedAtom.reportWrite(value, super.isInitialized, () {
      super.isInitialized = value;
    });
  }

  late final _$auxAtom =
      Atom(name: '_MapViewControllerBase.aux', context: context);

  @override
  bool get aux {
    _$auxAtom.reportRead();
    return super.aux;
  }

  @override
  set aux(bool value) {
    _$auxAtom.reportWrite(value, super.aux, () {
      super.aux = value;
    });
  }

  late final _$_MapViewControllerBaseActionController =
      ActionController(name: '_MapViewControllerBase', context: context);

  @override
  dynamic initializeAll() {
    final _$actionInfo = _$_MapViewControllerBaseActionController.startAction(
        name: '_MapViewControllerBase.initializeAll');
    try {
      return super.initializeAll();
    } finally {
      _$_MapViewControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic refresh() {
    final _$actionInfo = _$_MapViewControllerBaseActionController.startAction(
        name: '_MapViewControllerBase.refresh');
    try {
      return super.refresh();
    } finally {
      _$_MapViewControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic addPoint(LatLng point) {
    final _$actionInfo = _$_MapViewControllerBaseActionController.startAction(
        name: '_MapViewControllerBase.addPoint');
    try {
      return super.addPoint(point);
    } finally {
      _$_MapViewControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic removePoint() {
    final _$actionInfo = _$_MapViewControllerBaseActionController.startAction(
        name: '_MapViewControllerBase.removePoint');
    try {
      return super.removePoint();
    } finally {
      _$_MapViewControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
polyEditor: ${polyEditor},
polygons: ${polygons},
location: ${location},
firstLocation: ${firstLocation},
isInitialized: ${isInitialized},
aux: ${aux}
    ''';
  }
}