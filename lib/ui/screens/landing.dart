import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../data/model/rover.dart';
import '../../utils/constants.dart';
import '../../utils/router_constants.dart';
import '../widgets/home_drawer.dart';

class Landing extends StatelessWidget {
  const Landing({super.key});

  @override
  Widget build(BuildContext context) {
    final Rover rover = Hive.box<Rover>(roverDetailsKey).get(roverDetails)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.appTitle),
      ),
      drawer: const HomeDrawer(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const SizedBox(width: double.infinity),
          FilledButton(
            onPressed: () => context.push(home),
            child: const Text("Latest Photos"),
          ),
          FilledButton(
            onPressed: () async {
              await showDatePicker(
                context: context,
                initialDate: rover.maxDate,
                firstDate: rover.landingDate,
                lastDate: rover.maxDate,
              ).then((date) {
                if(date != null){
                  context.push(home,extra: date);
                }
              });
            },
            child: const Text("Date Photos"),
          ),
        ],
      ),
    );
  }
}
