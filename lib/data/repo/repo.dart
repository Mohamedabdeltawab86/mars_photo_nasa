import 'package:mars_photo_nasa/data/api/api.dart';
import 'package:mars_photo_nasa/data/model/mars_photo.dart';

class Repo {
  late Api _api;

  Repo() {
    _api = Api();
  }

  Future<List<MarsPhoto>> fetchLatestPhotos() async {
    final data = await _api.fetchLatestPhotos();
    // print(data);
    final photos =
        data.map((photoMap) => MarsPhoto.fromJson(photoMap)).toList();
    print(photos.length);
    return photos;
  }
}
