import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:mars_photo_nasa/data/model/mars_photo.dart';
import 'package:mars_photo_nasa/utils/constants.dart';

import '../model/rover.dart';

Future<void> initDB() async {
  await Hive.initFlutter();

  Hive.registerAdapter(CameraAdapter());
  Hive.registerAdapter(MarsPhotoAdapter());
  Hive.registerAdapter(RoverAdapter());
  Hive.registerAdapter(RoverCameraAdapter());

  await Hive.openBox(settingsKey);
  await Hive.openBox<MarsPhoto>(marsPhotosKey);
  await Hive.openBox<Rover>(roverDetailsKey);
}
