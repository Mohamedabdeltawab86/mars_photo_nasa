import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:mars_photo_nasa/data/api/api.dart';
import 'package:mars_photo_nasa/data/db/db_functions.dart';
import 'package:mars_photo_nasa/data/model/mars_photo.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mars_photo_nasa/data/model/rover.dart';
import 'package:mars_photo_nasa/utils/constants.dart';

class Repo {
  late Api _api;
  int _currentPage = 1;
  static const int _pageSize = 20;

  Repo() {
    _api = Api();
  }
  Future<List<MarsPhoto>> fetchLatestPhotos() async {
    final data = await _api.fetchLatestPhotos();
    final photos =
        data.map((marsPhoto) => MarsPhoto.fromJson(marsPhoto)).toList();
    savePhotosList(photos);
    return photos;
  }



  Future<List<MarsPhoto>> fetchDatePhotos(DateTime earthDate, {int? page}) async {
    bool online = await InternetConnectionChecker().hasConnection;
    if (online == true) {
      final formattedDate = DateFormat('yyyy-MM-dd').format(earthDate);
      final data = await _api.fetchDatePhotos(formattedDate, page:page);
      final photos =
          data.map((photoMap) => MarsPhoto.fromJson(photoMap)).toList();
      savePhotosList(photos);
      return photos;
    } else {
      return fetchDatePhotosFromDB(earthDate);
    }
  }

  Future<bool> fetchCuriosityData() async {
    try {
      final data = await _api.fetchCuriosityData();
      Rover rover = Rover.fromJson(data);
      Hive.box<Rover>(roverDetailsKey).put(roverDetails, rover);

      Hive.box<Rover>(roverDetailsKey).put(roverDetails, rover);
      return true;
    } catch (e) {
      return false;
    }
  }
}
