import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_ecobot/core/classes/my_app.dart';
import 'package:firebase_ecobot/core/models/geo_coordinates_model.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Hive.registerAdapter(GeoCoordinatesModelAdapter());
  await Hive.initFlutter();
  await Hive.openBox<GeoCoordinatesModel>('temp-coordinates');
  runApp(const MyApp());
}
