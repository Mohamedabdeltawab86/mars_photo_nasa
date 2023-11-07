import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mars_photo_nasa/data/model/mars_photo.dart';
import 'package:mars_photo_nasa/data/repo/repo.dart';
import 'package:mars_photo_nasa/utils/constants.dart';
import 'package:sizer/sizer.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<MarsPhoto> photos = [];
  @override
  void initState() {
    super.initState();
    fetchPhotos();
  }

  Future<void> fetchPhotos() async {
    final repo = Repo();
    final fetchedPhotos = await repo.fetchLatestPhotos();
    setState(() {
      photos = fetchedPhotos;
    });
  }

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context)!;
    final settingsBox = Hive.box('settings');
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          strings.appTitle,
          style: Theme.of(context).textTheme.headlineLarge,
        ),
        actions: [
          IconButton(
            onPressed: () {
              context.push(settingsPath);
            },
            icon: const Icon(Icons.settings),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          shrinkWrap: true,
          children: [
            ListTile(
              title: Text(strings.theme),
              trailing: Switch(
                value: settingsBox.get('isDark', defaultValue: false),
                onChanged: (v) => settingsBox.put("isDark", v),
              ),
            ),
            ListTile(
              title: Text(strings.language),
              trailing: DropdownButton(
                items: <String>['en', 'ar']
                    .map((e) => DropdownMenuItem(
                        value: e,
                        child: Text(e == "ar" ? "Arabic" : "English")))
                    .toList(),
                onChanged: (value) {
                  Hive.box('settings').put('lang', value);
                },
              ),
            ),
          ],
        ),
      ),
      body: Center(
        child: ListView.builder(
            itemCount: photos.length,
            itemBuilder: (context, index) {
              final photo = photos[index];
              return ListTile(
                title: Text('Photo ID: ${photo.id}'),
                subtitle: Row(
                  children: [
                    Text('photo Date ${photo.earthDate}'),
                    Text('Camera Name ${photo.camera}'),
                    Text('Sol "Martian Day ${photo.sol}'),
                  ],
                ),
                leading: Image.network(photo.imgSrc),
              );
            }),
      ),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.photo),
          onPressed: () {
            Repo().fetchLatestPhotos();
          }),
    );
  }
}
