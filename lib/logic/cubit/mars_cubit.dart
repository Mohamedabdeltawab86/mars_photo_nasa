import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mars_photo_nasa/data/model/mars_photo.dart';

import '../../data/repo/repo.dart';

part 'mars_state.dart';

class MarsCubit extends Cubit<MarsState> {
  final Repo repo;

  MarsCubit({required this.repo}) : super(MarsInitial()) {
    fetchRoverData();
  }

  static MarsCubit get(context) => BlocProvider.of<MarsCubit>(context);

  Future<void> fetchRoverData() async {
    emit(RoverDataLoading());
    await repo.fetchCuriosityData();
    emit(RoverDataLoaded());
  }

  final ScrollController scrollController = ScrollController();

  void checkScrollPosition(DateTime earthDate){
    if(scrollController.offset >=
        scrollController.position.maxScrollExtent &&
        !scrollController.position.outOfRange){
      fetchMarsPhotos(earthDate,page: pageCount++);
    }
  }

  int pageCount = 1;

  List<MarsPhoto> photosList = [];

  bool isPhotosLoaded = false;

  void resetHomePage() {
    photosList = [];
    isPhotosLoaded = true;
  }



  void fetchMarsPhotos(DateTime? earthDate,{int? page}) async {
    emit(MarsPhotosLoading());
    final lPhotos = earthDate != null
        ? await repo.fetchDatePhotos(earthDate,page: page ?? pageCount)
        : await repo.fetchLatestPhotos();

    isPhotosLoaded = true;
    photosList.addAll(lPhotos);
    emit(MarsPhotosLoaded());
  }
}