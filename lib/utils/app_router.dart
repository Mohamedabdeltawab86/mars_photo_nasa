import "package:flutter_bloc/flutter_bloc.dart";
import "package:go_router/go_router.dart";
import "package:mars_photo_nasa/data/repo/repo.dart";
import "package:mars_photo_nasa/logic/cubit/mars_cubit.dart";
import "package:mars_photo_nasa/ui/screens/home.dart";
import "package:mars_photo_nasa/ui/screens/landing.dart";
import "package:mars_photo_nasa/ui/screens/settings.dart";

import "package:mars_photo_nasa/utils/router_constants.dart";
GoRouter router() {
  final MarsCubit marsCubit = MarsCubit(repo: Repo());

  return GoRouter(
    routes: [
      GoRoute(
        path: "/",
        builder: (context, state) => BlocProvider<MarsCubit>.value(
          value: marsCubit,
          child: const Landing(),
        ),
      ),
      GoRoute(
        path: home,
        builder: (context, state) => BlocProvider<MarsCubit>.value(
          value: marsCubit,
          child: Home(
            earthDate: state.extra as DateTime?,
          ),
        ),
      ),
      GoRoute(
        path: settingsPath,
        builder: (context, state) => BlocProvider<MarsCubit>.value(
          value: marsCubit,
          child: const Settings(),
        ),
      ),
    ],
  );
}
