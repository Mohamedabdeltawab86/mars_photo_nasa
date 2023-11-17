// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rover.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RoverAdapter extends TypeAdapter<Rover> {
  @override
  final int typeId = 2;

  @override
  Rover read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Rover(
      id: fields[0] as int,
      name: fields[1] as String,
      landingDate: fields[2] as DateTime,
      launchDate: fields[3] as DateTime,
      maxDate: fields[6] as DateTime,
      status: fields[4] as String,
      maxSol: fields[5] as int,
      totalPhotos: fields[7] as int,
      cameras: (fields[8] as List).cast<RoverCamera>(),
    );
  }

  @override
  void write(BinaryWriter writer, Rover obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.landingDate)
      ..writeByte(3)
      ..write(obj.launchDate)
      ..writeByte(4)
      ..write(obj.status)
      ..writeByte(5)
      ..write(obj.maxSol)
      ..writeByte(6)
      ..write(obj.maxDate)
      ..writeByte(7)
      ..write(obj.totalPhotos)
      ..writeByte(8)
      ..write(obj.cameras);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RoverAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class RoverCameraAdapter extends TypeAdapter<RoverCamera> {
  @override
  final int typeId = 3;

  @override
  RoverCamera read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RoverCamera(
      name: fields[0] as String,
      fullName: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, RoverCamera obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.fullName);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RoverCameraAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Rover _$RoverFromJson(Map<String, dynamic> json) => Rover(
      id: json['id'] as int,
      name: json['name'] as String,
      landingDate: DateTime.parse(json['landing_date'] as String),
      launchDate: DateTime.parse(json['launch_date'] as String),
      maxDate: DateTime.parse(json['max_date'] as String),
      status: json['status'] as String,
      maxSol: json['max_sol'] as int,
      totalPhotos: json['total_photos'] as int,
      cameras: (json['cameras'] as List<dynamic>)
          .map((e) => RoverCamera.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

RoverCamera _$RoverCameraFromJson(Map<String, dynamic> json) => RoverCamera(
      name: json['name'] as String,
      fullName: json['full_name'] as String,
    );
