import 'package:firebase_ecobot/features/form/controller/form_controller.dart';
import 'package:firebase_ecobot/features/form/view/widgets/my_text_field.dart';
import 'package:firebase_ecobot/features/map/view/map_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../core/models/geo_coordinates_model.dart';

class FormPage extends StatefulWidget {
  const FormPage({
    Key? key,
  }) : super(key: key);

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  var box = Hive.box<GeoCoordinatesModel>('temp-coordinates');

  final _controller = FormController();
  final TextEditingController _favoritePlaceTextController =
      TextEditingController();
  final TextEditingController _latitudeTextController = TextEditingController();
  final TextEditingController _longitudeTextController =
      TextEditingController();

  @override
  void initState() {
    if (box.isNotEmpty) {
      _controller.syncFavoritePlaceCoordinates();
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Firebase Test"),
        backgroundColor: Colors.green[300],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                height: 80,
                width: 170,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.fitHeight,
                    image: AssetImage("assets/generic-logo.png"),
                  ),
                ),
              ),
              MyTextField(
                textEditingController: _favoritePlaceTextController,
                labelText: "Enter the name of your favorite place:",
                onChanged: _controller.changeFavoritePlace,
              ),
              // MyTextField(
              //   textEditingController: _latitudeTextController,
              //   labelText: "Latitude",
              //   onChanged: _controller.changeLatitude,
              // ),
              // MyTextField(
              //   textEditingController: _longitudeTextController,
              //   labelText: "Longitude",
              //   onChanged: _controller.changeLongitude,
              // ),
              Observer(builder: (_) {
                return ListView.builder(shrinkWrap: true, itemCount: _controller.latitude.length, itemBuilder: (context, index) {
                  return Text(_controller.latitude[index].toString());
                },);
              }),
                Observer(builder: (_) {
                return ListView.builder(shrinkWrap: true, itemCount: _controller.latitude.length, itemBuilder: (context, index) {
                  return Text(_controller.longitude[index].toString());
                },);
              }),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      await _controller.saveFavoritePlaceCoordinates(context);
                      _latitudeTextController.clear();
                      _favoritePlaceTextController.clear();
                      _longitudeTextController.clear();
                    },
                    child: Icon(Icons.save),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                        Colors.green[300],
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      await Navigator.push(context,
                          MaterialPageRoute(builder: (context) => MapView()));
                    },
                    child: Icon(Icons.map),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                        Colors.green[300],
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
