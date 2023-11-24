import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mars_photo_nasa/data/db/init_db.dart';
// import 'package:mars_photo_nasa/l10n/app_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mars_photo_nasa/utils/app_router.dart';
import 'package:mars_photo_nasa/utils/bloc_observer.dart';
import 'package:mars_photo_nasa/utils/color_scheme.dart';
import 'package:mars_photo_nasa/utils/constants.dart';
import 'package:mars_photo_nasa/utils/typography.dart';
import 'package:sizer/sizer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer =  MyBlocObserver();
  await initDB();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // final strings = AppLocalizations.of(context)!;
    return ValueListenableBuilder(
        valueListenable: Hive.box(settingsKey).listenable(),
        builder: (_, box, __) {
          final bool isDark =
              Hive.box(settingsKey).get(isDarkKey, defaultValue: false);
          final String lang =
              Hive.box(settingsKey).get(langkey, defaultValue: defaultLang);
          return Sizer(builder: (context, orientation, deviceType) {
            return MaterialApp.router(
              debugShowCheckedModeBanner: false,
              // title: "strings.appTitle",
              // 3 locals: l.Delegates, supportedLocales, locale
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              supportedLocales: AppLocalizations.supportedLocales,
              locale: Locale(lang),
              // theme, darkTheme, themeMode
              // theme : light = default, darkTheme = dart
              // colorScheme, materials3, textTheme
              theme: ThemeData(
                colorScheme: lightColorScheme,
                useMaterial3: true,
                textTheme: textTheme,
              ),
              darkTheme: ThemeData(
                colorScheme: darkColorScheme,
                useMaterial3: true,
                textTheme: textTheme,
              ),
              themeMode: isDark ? ThemeMode.dark : ThemeMode.light,
              routerConfig: router(),
            );
          });
        });
  }
}
