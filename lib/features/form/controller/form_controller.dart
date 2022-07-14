// ignore_for_file: library_private_types_in_public_api

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ecobot/core/generics/firebase_response.dart';
import 'package:firebase_ecobot/features/form/controller/generate_pdf_with_coordinates.dart';
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
  ObservableList<double> latitude = <double>[].asObservable();

  @observable
  ObservableList<double> longitude = <double>[].asObservable();

  @action
  Future saveFavoritePlaceCoordinates(BuildContext context) async {
    try {
      await FirebaseFirestore.instance
          .collection("data")
          .doc(_uID)
          .set({'id': _uID});

      await FirebaseFirestore.instance
          .collection("data")
          .doc(_uID)
          .collection("favorite-places")
          .doc(favoritePlace)
          .set(
        {
          'nameOfFavoritePlace': favoritePlace,
          'latitude': latitude,
          'longitude': longitude,
        },
      );

      FirebaseResponse.success();
      return AwesomeDialog(
        context: context,
        dialogType: DialogType.SUCCES,
        animType: AnimType.TOPSLIDE,
        title: "Saved",
        desc: "Your information has been successfuly saved",
        btnOk: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.green),
          ),
          onPressed: () async {
            await generatePDFwithCoordinates(favoritePlace, latitude, longitude);
          },
          child: const Icon(Icons.picture_as_pdf),
        ),
        btnCancel: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.green),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Icon(Icons.check_circle),
        ),
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
  Future deleteTempData() async {
    await box.clear();
    latitude.clear();
    longitude.clear();
  }

  @action
  syncHiveData() {
    for (var coordinates in box.values) {
      latitude.add(coordinates.latitude);
      longitude.add(coordinates.longitude);
    }
  }
}
