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

  @override
  void initState() {
    if (box.isNotEmpty) {
      _controller.syncHiveData();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
              Observer(builder: (_) {
                return Card(
                  color: Colors.green[50],
                  child: SingleChildScrollView(
                    child: ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: box.values.length,
                      itemBuilder: (context, index) {
                        return Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Flexible(
                              child: Column(
                                children: [
                                  Text(
                                    "Latitude: ${_controller.latitude[index]}",
                                    overflow: TextOverflow.fade,
                                  ),
                                ],
                              ),
                            ),
                            Flexible(
                              child: Column(
                                children: [
                                  Text(
                                    "Longitude: ${_controller.longitude[index]}",
                                    overflow: TextOverflow.fade,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                );
              }),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      await _controller
                          .saveFavoritePlaceCoordinates(context)
                          .whenComplete(() => _controller.deleteTempData());
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
