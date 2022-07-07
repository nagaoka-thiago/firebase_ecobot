import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  String latitude = " ";

  @action
  void changeLatitude(String newValue) => latitude = newValue;

  @observable
  String longitude = " ";

  @action
  void changeLongitude(String newValue) => longitude = newValue;

  @action
  Future saveFavoritePlaceCoordinates() async {
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

    } on FirebaseException catch (e) {
      print(e.code);
    }
  }

//TODO! Implement user feedback and reload the page

}
