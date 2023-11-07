// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mars_photo.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MarsPhotoAdapter extends TypeAdapter<MarsPhoto> {
  @override
  final int typeId = 0;

  @override
  MarsPhoto read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MarsPhoto(
      id: fields[0] as int,
      sol: fields[1] as int,
      camera: fields[2] as Camera,
      imgSrc: fields[3] as String,
      earthDate: fields[4] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, MarsPhoto obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.sol)
      ..writeByte(2)
      ..write(obj.camera)
      ..writeByte(3)
      ..write(obj.imgSrc)
      ..writeByte(4)
      ..write(obj.earthDate);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MarsPhotoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class CameraAdapter extends TypeAdapter<Camera> {
  @override
  final int typeId = 1;

  @override
  Camera read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Camera(
      id: fields[0] as int,
      name: fields[1] as String,
      roverId: fields[2] as int,
      fullName: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Camera obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.roverId)
      ..writeByte(3)
      ..write(obj.fullName);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CameraAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MarsPhoto _$MarsPhotoFromJson(Map<String, dynamic> json) => MarsPhoto(
      id: json['id'] as int,
      sol: json['sol'] as int,
      camera: Camera.fromJson(json['camera'] as Map<String, dynamic>),
      imgSrc: json['img_src'] as String,
      earthDate: MarsPhoto._dateFromString(json['earth_date'] as String),
    );

Camera _$CameraFromJson(Map<String, dynamic> json) => Camera(
      id: json['id'] as int,
      name: json['name'] as String,
      roverId: json['rover_id'] as int,
      fullName: json['full_name'] as String,
    );
