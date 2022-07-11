
import 'package:hive_flutter/hive_flutter.dart';
part 'geo_coordinates_model.g.dart';

@HiveType(typeId: 0)
class GeoCoordinatesModel {

  @HiveField(0)
  double latitude;

  @HiveField(1)
  double longitude;

  GeoCoordinatesModel({
    required this.latitude,
    required this.longitude,}
  );

}
