import 'package:firebase_ecobot/features/form/controller/form_controller.dart';
import 'package:firebase_ecobot/features/form/view/widgets/my_text_field.dart';
import 'package:firebase_ecobot/features/map/view/map_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

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

  @override
  void initState() {
    if (box.isNotEmpty) {
      _controller.syncHiveData();
    }
    Permission.location.request();
    Permission.locationWhenInUse.request();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Firebase Test"),
        backgroundColor: Colors.green[300],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              height: 64,
            ),
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
            SizedBox(
              height: 64,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: MyTextField(
                textEditingController: _favoritePlaceTextController,
                labelText: "Enter the name of your favorite place:",
                onChanged: _controller.changeFavoritePlace,
              ),
            ),
            SizedBox(
              height: 64,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    await _controller
                        .saveFavoritePlaceCoordinates(context)
                        .whenComplete(
                            () async => await _controller.deleteTempData());
                    _favoritePlaceTextController.clear();
                    setState(() {
                      _controller.syncHiveData();
                    });
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                      Colors.green[300],
                    ),
                  ),
                  child: const Icon(Icons.save),
                ),
                ElevatedButton(
                  onPressed: () async {
                    await Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const MapView()));
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                      Colors.green[300],
                    ),
                  ),
                  child: const Icon(Icons.map),
                ),
              ],
            ),
            SizedBox(
              height: 64,
            ),
            box.isNotEmpty
                ? ExpansionTile(
                    title: const Text(
                      "Latitude",
                      style: TextStyle(color: Colors.black),
                    ),
                    children: [
                      ListView.builder(
                        itemCount: box.values.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Observer(builder: (_) {
                              return Text(
                                "${_controller.latitude[index]}",
                                style: TextStyle(fontSize: 12),
                              );
                            }),
                          );
                        },
                      )
                    ],
                  )
                : Container(),
                SizedBox(
              height: 64,
            ),
            box.isNotEmpty
                ? ExpansionTile(
                    title: const Text("Longitude",
                        style: TextStyle(color: Colors.black)),
                    children: [
                      ListView.builder(
                        itemCount: box.values.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Observer(builder: (_) {
                              return Text(
                                "${_controller.longitude[index]}",
                                style: TextStyle(fontSize: 12),
                              );
                            }),
                          );
                        },
                      )
                    ],
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
