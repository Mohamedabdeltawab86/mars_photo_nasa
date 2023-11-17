import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mars_photo_nasa/data/model/mars_photo.dart';
import 'package:mars_photo_nasa/data/repo/repo.dart';
// import 'package:mars_photo_nasa/l10n/app_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:mars_photo_nasa/ui/widgets/home_drawer.dart';
import 'package:mars_photo_nasa/ui/widgets/mars_photo_card.dart';
import 'package:mars_photo_nasa/utils/constants.dart';

import '../../data/model/rover.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool dataReady = false;
  List<MarsPhoto> marsPhotos = [];
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    _scrollController.addListener(_scrollListener);
    Repo().fetchCuriosityData().then((bool value) {
      dataReady = value;
      if (dataReady) {
        _fetchNextPageOfPhotos();
      }
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      // User has reached the end of the list, fetch the next page of photos
      _fetchNextPageOfPhotos();
    }
  }

  Future<void> _fetchNextPageOfPhotos() async {
    final nextPagePhotos = await Repo().fetchNextPageOfPhotos();
    if (nextPagePhotos.isNotEmpty) {
      marsPhotos.addAll(nextPagePhotos);
      setState(() {});
    }
  }

    @override
    Widget build(BuildContext context) {
      final strings = AppLocalizations.of(context)!;
      final Rover rover = Hive.box<Rover>(roverDetailsKey).get(roverDetails)!;
      return Scaffold(
        appBar: AppBar(
          title: Text(
            strings.appTitle,
            style: Theme.of(context).textTheme.displayLarge,
          ),
        ),
        drawer: const HomeDrawer(),
        body: !dataReady
            ? const Text("Loading")
            : Column(children: [
                ListTile(
                  title: Text(strings.date),
                  trailing: const Icon(Icons.calendar_month),
                  onTap: () async {
                    DateTime? date = await showDatePicker(
                      context: context,
                      initialDate: rover.maxDate,
                      firstDate: rover.landingDate,
                      lastDate: rover.maxDate,
                    );
                    marsPhotos =
                        await Repo().fetchDatePhotos(date ?? rover.maxDate);
                    setState(() {});
                  },
                ),
                Expanded(
                    child: ListView.builder(
                        itemCount: marsPhotos.length,
                        itemBuilder: (_, index) =>
                            MarsPhotoCard(marsPhoto: marsPhotos[index])))
              ]),
        floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.webhook),
            onPressed: () {
              Repo().fetchCuriosityData();
            }),
      );
    }
  }
