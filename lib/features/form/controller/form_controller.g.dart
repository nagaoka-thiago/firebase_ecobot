// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'form_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$FormController on _FormControllerBase, Store {
  late final _$favoritePlaceAtom =
      Atom(name: '_FormControllerBase.favoritePlace', context: context);

  @override
  String get favoritePlace {
    _$favoritePlaceAtom.reportRead();
    return super.favoritePlace;
  }

  @override
  set favoritePlace(String value) {
    _$favoritePlaceAtom.reportWrite(value, super.favoritePlace, () {
      super.favoritePlace = value;
    });
  }

  late final _$latitudeAtom =
      Atom(name: '_FormControllerBase.latitude', context: context);

  @override
  ObservableList<double> get latitude {
    _$latitudeAtom.reportRead();
    return super.latitude;
  }

  @override
  set latitude(ObservableList<double> value) {
    _$latitudeAtom.reportWrite(value, super.latitude, () {
      super.latitude = value;
    });
  }

  late final _$longitudeAtom =
      Atom(name: '_FormControllerBase.longitude', context: context);

  @override
  ObservableList<double> get longitude {
    _$longitudeAtom.reportRead();
    return super.longitude;
  }

  @override
  set longitude(ObservableList<double> value) {
    _$longitudeAtom.reportWrite(value, super.longitude, () {
      super.longitude = value;
    });
  }

  late final _$saveFavoritePlaceCoordinatesAsyncAction = AsyncAction(
      '_FormControllerBase.saveFavoritePlaceCoordinates',
      context: context);

  @override
  Future<dynamic> saveFavoritePlaceCoordinates(BuildContext context) {
    return _$saveFavoritePlaceCoordinatesAsyncAction
        .run(() => super.saveFavoritePlaceCoordinates(context));
  }

  late final _$deleteTempDataAsyncAction =
      AsyncAction('_FormControllerBase.deleteTempData', context: context);

  @override
  Future<dynamic> deleteTempData() {
    return _$deleteTempDataAsyncAction.run(() => super.deleteTempData());
  }

  late final _$_FormControllerBaseActionController =
      ActionController(name: '_FormControllerBase', context: context);

  @override
  void changeFavoritePlace(String newValue) {
    final _$actionInfo = _$_FormControllerBaseActionController.startAction(
        name: '_FormControllerBase.changeFavoritePlace');
    try {
      return super.changeFavoritePlace(newValue);
    } finally {
      _$_FormControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic syncHiveData() {
    final _$actionInfo = _$_FormControllerBaseActionController.startAction(
        name: '_FormControllerBase.syncHiveData');
    try {
      return super.syncHiveData();
    } finally {
      _$_FormControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
favoritePlace: ${favoritePlace},
latitude: ${latitude},
longitude: ${longitude}
    ''';
  }
}
