import "package:hive_flutter/hive_flutter.dart";
import 'package:json_annotation/json_annotation.dart';

part 'mars_photo.g.dart';

@HiveType(typeId: 0)
@JsonSerializable(createToJson: false)
class MarsPhoto {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final int sol;
  @HiveField(2)
  @JsonKey(fromJson: Camera.fromJson)
  final Camera camera;
  @HiveField(3)
  @JsonKey(name: "img_src")
  final String imgSrc;
  @HiveField(4)
  @JsonKey(name: "earth_date", fromJson: _dateFromString)
  final DateTime earthDate;

  MarsPhoto({
    required this.id,
    required this.sol,
    required this.camera,
    required this.imgSrc,
    required this.earthDate,
  });

  factory MarsPhoto.fromJson(Map<String, dynamic> json) =>
      _$MarsPhotoFromJson(json);

  static DateTime _dateFromString(String date) => DateTime.parse(date);
}

@HiveType(typeId: 1)
@JsonSerializable(createToJson: false)
class Camera {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  @JsonKey(name: "rover_id")
  final int roverId;
  @HiveField(3)
  @JsonKey(name: "full_name")
  final String fullName;

  Camera({
    required this.id,
    required this.name,
    required this.roverId,
    required this.fullName,
  });

  factory Camera.fromJson(Map<String, dynamic> json) => _$CameraFromJson(json);
}
