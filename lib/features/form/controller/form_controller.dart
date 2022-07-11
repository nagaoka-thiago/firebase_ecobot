import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ecobot/core/generics/firebase_response.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
part 'form_controller.g.dart';

class FormController = _FormControllerBase with _$FormController;

abstract class _FormControllerBase with Store {
  final _uID = FirebaseAuth.instance.currentUser!.uid;

  @observable
  String favoritePlace = "";

  @action
  void changeFavoritePlace(String newValue) => favoritePlace = newValue;

  @observable
  List<String> latitude = [];

  @action
  void changeLatitude(String newValue) => latitude.add(newValue);

  @observable
  List<String> longitude = [];

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

//! TODO find a way to store lat and long in firebase.


}
