import 'package:demo_revised_project/bloc/album/album_bloc.dart';
import 'package:demo_revised_project/bloc/album/album_event.dart';
import 'package:demo_revised_project/bloc/album/album_state.dart';
import 'package:demo_revised_project/dependency_injection.dart';
import 'package:demo_revised_project/models/albums/album.dart';
import 'package:demo_revised_project/models/user/user.dart';
import 'package:demo_revised_project/pages/album/album_widget.dart';
import 'package:demo_revised_project/shimmer/album_shimmer.dart';
import 'package:demo_revised_project/utils/snackbar_util.dart';
import 'package:demo_revised_project/widgets/custom_error_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AlbumPage extends StatefulWidget {
  final User user;
  const AlbumPage({super.key, required this.user});

  @override
  State<AlbumPage> createState() => _AlbumPageState();
}

class _AlbumPageState extends State<AlbumPage> {
  @override
  void initState() {
    getIt<AlbumBloc>().add(FetchUserAlbumsList(widget.user.id!));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AlbumBloc, AlbumState>(
        bloc: getIt<AlbumBloc>(),
        builder: (context, AlbumState state) {
          if (state.isLoading) {
            return const AlbumShimmer();
          } else if (state.data != null) {
            final List<Album> albumList = state.data ?? [];
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
              ),
              itemCount: albumList.length,
              itemBuilder: (context, index) {
                final album = albumList[index];
                return AlbumWidget(album: album);
              },
            );
          } else {
            return CustomErrorWidget(errorMessage: state.error!);
          }
        },
        listener: (context, AlbumState state) {
          if (state.error != null) {
            SnackbarUtils.showSnackbar(context, "Something went wrong!");
          }
        },
      ),
    );
  }
}
