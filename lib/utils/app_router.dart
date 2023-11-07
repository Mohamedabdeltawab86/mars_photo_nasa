import "package:go_router/go_router.dart";
import "package:mars_photo_nasa/ui/screens/home.dart";
import "package:mars_photo_nasa/ui/screens/settings.dart";
import "package:mars_photo_nasa/utils/constants.dart";

GoRouter router() {
  return GoRouter(routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const Home(),
    ),
    GoRoute(
      path: settingsPath,
      builder: (context, state) => const Settings(),
    ),
  ]);
}
