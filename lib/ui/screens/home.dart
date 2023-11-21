// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:mars_photo_nasa/ui/widgets/mars_photo_card.dart';
import '../../logic/cubit/mars_cubit.dart';

class Home extends StatelessWidget {
  final DateTime? earthDate;

  const Home({super.key, required this.earthDate});

  @override
  Widget build(BuildContext context) {
    final MarsCubit cubit = context.read<MarsCubit>();
    cubit.resetHomePage();
    cubit.fetchMarsPhotos(earthDate);
    cubit.scrollController.addListener(
      () => cubit.checkScrollPosition(earthDate!),
    );
    return Scaffold(
      appBar: AppBar(
        title: Text(
          earthDate == null
              ? "Latest Photos"
              : DateFormat.yMMMd().format(earthDate!),
          style: Theme.of(context).textTheme.titleSmall,
        ),
      ),
      body: BlocBuilder<MarsCubit, MarsState>(
        builder: (context, state) {
          return ConditionalBuilder(
            condition: cubit.isPhotosLoaded,
            builder: (context) => ListView.builder(
              controller: cubit.scrollController,
              itemCount: cubit.photosList.length,
              itemBuilder: (_, i) => MarsPhotoCard(
                marsPhoto: cubit.photosList[i],
              ),
            ),
            fallback: (_) => const Center(child: CircularProgressIndicator()),
          );
        },
      ),
    );
  }
}
