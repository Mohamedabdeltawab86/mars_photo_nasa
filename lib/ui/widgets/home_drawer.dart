import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
// import 'package:mars_photo_nasa/l10n/app_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:mars_photo_nasa/utils/constants.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context)!;
    final settingsBox = Hive.box(settingsKey);
    return Drawer(
      child: ListView(
        shrinkWrap: true,
        children: [
          ListTile(
            title: Text(strings.theme),
            trailing: Switch(
              value: settingsBox.get(isDarkKey, defaultValue: false),
              onChanged: (v) => settingsBox.put(isDarkKey, v),
            ),
          ),
          ListTile(
              title: Text(strings.language),
              trailing: DropdownButton(
                items: <String>['en', 'ar']
                    .map((e) => DropdownMenuItem(
                          value: e,
                          child: Text(e == 'ar' ? 'Arabic' : 'English'),
                        ))
                    .toList(),
                onChanged: (v) => settingsBox.put(langkey, v),
              ),),
        ],
      ),
    );
  }
}
