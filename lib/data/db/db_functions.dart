import 'package:hive_flutter/hive_flutter.dart';
import 'package:mars_photo_nasa/data/model/mars_photo.dart';
import 'package:mars_photo_nasa/utils/constants.dart';

// Box<MarsPhoto> marsPhotosBox = Hive.box<MarsPhoto>(marsPhotosKey);

// void savePhotosList(List<MarsPhoto> photos) {
//   for (MarsPhoto photo in photos) {
//     final MarsPhoto? localPhoto = marsPhotosBox.get(photo.id);
//     if (localPhoto != photo) {
//       marsPhotosBox.put(photo.id, photo);
//     }
//   }
// }

// List<MarsPhoto> fetchDatePhotosFromDB(DateTime date) {
//   return marsPhotosBox.values
//       .where((MarsPhoto marsPhoto) => marsPhoto.earthDate == date)
//       .toList();
// }

// 2 function to save image list in hive then fetch them from database

Box<MarsPhoto> marsPhotosBox = Hive.box<MarsPhoto>(marsPhotosKey);

void savePhotosList(List<MarsPhoto> photos) {
  for (MarsPhoto photo in photos) {
    final MarsPhoto? localPhoto = marsPhotosBox.get(photo.id);
    if (localPhoto != photo) {
      marsPhotosBox.put(photo.id, photo);
    }
  }
}

List<MarsPhoto> fetchDatePhotosFromDB(DateTime date) {
  return marsPhotosBox.values
      .where((MarsPhoto marsPhoto) => marsPhoto.earthDate == date)
      .toList();
}
