import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mars_photo_nasa/utils/app_router.dart';
import 'package:mars_photo_nasa/utils/color_scheme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mars_photo_nasa/utils/typography.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox("settings");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: Hive.box('settings').listenable(),
        builder: (_, value, __) {
          // final strings = AppLocalizations.of(context);
          final bool isDark =
              Hive.box('settings').get('isDark', defaultValue: false);
          final String lang =
              Hive.box('settings').get('lang', defaultValue: 'en');
          return MaterialApp.router(
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            locale: Locale(lang),

            // title: strings.appTitle,
            theme: ThemeData(
              useMaterial3: true,
              colorScheme: lightColorScheme,
              textTheme: textTheme,
            ),
            darkTheme: ThemeData(
              useMaterial3: true,
              colorScheme: darkColorScheme,
              textTheme: textTheme,
            ),
            themeMode:
                isDark ? ThemeMode.dark : ThemeMode.light, // Default is system
            debugShowCheckedModeBanner: false,
            routerConfig: router(),
          );
        });
  }
}
