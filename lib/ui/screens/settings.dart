import 'package:flutter/material.dart';
// import 'package:mars_photo_nasa/l10n/app_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(title: Text(strings.settings)),
    );
  }
}
