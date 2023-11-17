import "package:hive_flutter/hive_flutter.dart";
import 'package:json_annotation/json_annotation.dart';

part 'rover.g.dart';

@HiveType(typeId: 2)
@JsonSerializable(createToJson: false)
class Rover {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  @JsonKey(name: "landing_date")
  final DateTime landingDate;
  @HiveField(3)
  @JsonKey(name: "launch_date")
  final DateTime launchDate;
  @HiveField(4)
  final String status;
  @HiveField(5)
  @JsonKey(name: 'max_sol')
  final int maxSol;
  @HiveField(6)
  @JsonKey(name: "max_date")
  final DateTime maxDate;
  @HiveField(7)
  @JsonKey(name: "total_photos")
  final int totalPhotos;
  @HiveField(8)
  final List<RoverCamera> cameras;

  factory Rover.fromJson(Map<String, dynamic> json) => _$RoverFromJson(json);

  Rover(
      {required this.id,
      required this.name,
      required this.landingDate,
      required this.launchDate,
      required this.maxDate,
      required this.status,
      required this.maxSol,
      required this.totalPhotos,
      required this.cameras});

  static DateTime _dateFromString(String date) => DateTime.parse(date);
}

@HiveType(typeId: 3)
@JsonSerializable(createToJson: false)
class RoverCamera {
  @HiveField(0)
  final String name;
  @HiveField(1)
  @JsonKey(name: 'full_name')
  final String fullName;

  RoverCamera({
    required this.name,
    required this.fullName,
  });

  factory RoverCamera.fromJson(Map<String, dynamic> json) =>
      _$RoverCameraFromJson(json);
}
