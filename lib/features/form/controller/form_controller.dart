import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ecobot/core/generics/firebase_response.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mobx/mobx.dart';

import '../../../core/models/geo_coordinates_model.dart';
part 'form_controller.g.dart';

class FormController = _FormControllerBase with _$FormController;

abstract class _FormControllerBase with Store {

  var box = Hive.box<GeoCoordinatesModel>('temp-coordinates');

  final _uID = FirebaseAuth.instance.currentUser!.uid;

  @observable
  String favoritePlace = "";

  @action
  void changeFavoritePlace(String newValue) => favoritePlace = newValue;

  @observable
  ObservableList<String> latitude = <String>[].asObservable();

  @action
  void changeLatitude(String newValue) => latitude.add(newValue);

  @observable
  ObservableList<String> longitude = <String>[].asObservable();


  @action
  void changeLongitude(String newValue) => longitude.add(newValue);


  @action
  Future saveFavoritePlaceCoordinates(BuildContext context) async {
    try {
      await FirebaseFirestore.instance
          .collection("data")
          .doc(_uID)
          .set({'id': _uID}).whenComplete(
        () => FirebaseFirestore.instance
            .collection("data")
            .doc(_uID)
            .collection("favorite-places")
            .doc(favoritePlace)
            .set({
          'nameOfFavoritePlace': favoritePlace,
          'latitude': latitude,
          'longitude': longitude,
        }),
      );
      FirebaseResponse.success();
      return AwesomeDialog(
        context: context,
        dialogType: DialogType.SUCCES,
        animType: AnimType.TOPSLIDE,
        showCloseIcon: true,
        title: "Saved",
        desc: "Your information has been successfuly saved",
                btnOkIcon: Icons.check_circle,
      ).show();
    } on FirebaseException catch (e) {
      FirebaseResponse.failed(error: e.code);
      return AwesomeDialog(
        context: context,
        dialogType: DialogType.ERROR,
        animType: AnimType.TOPSLIDE,
        showCloseIcon: true,
        title: "Error",
        desc: e.code,
        btnOkIcon: Icons.check_circle,
      ).show();
    }
  }

  @action
  void syncFavoritePlaceCoordinates() {
    for (var element in box.values) {
      latitude.add(element.latitude.toString());
      longitude.add(element.longitude.toString());
    }
 
  }

//! TODO find a way to store lat and long in firebase.


}
