import 'package:demo_revised_project/appbar/custom_appbar.dart';
import 'package:demo_revised_project/bloc/photo/photo_bloc.dart';
import 'package:demo_revised_project/bloc/photo/photo_event.dart';
import 'package:demo_revised_project/bloc/photo/photo_state.dart';
import 'package:demo_revised_project/dependency_injection.dart';
import 'package:demo_revised_project/models/albums/album.dart';
import 'package:demo_revised_project/models/albums/photos.dart';
import 'package:demo_revised_project/pages/photo/photo_widget.dart';
import 'package:demo_revised_project/shimmer/photo_shimmer.dart';
import 'package:demo_revised_project/utils/snackbar_util.dart';
import 'package:demo_revised_project/widgets/custom_error_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PhotoPage extends StatefulWidget {
  final Album album;
  const PhotoPage({super.key, required this.album});

  @override
  State<PhotoPage> createState() => PhotoPageState();
}

class PhotoPageState extends State<PhotoPage> {
  @override
  void initState() {
    getIt<PhotoBloc>().add(FetchUserPhotosList(widget.album.id!));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(title: '${widget.album.title}'),
      body: BlocConsumer<PhotoBloc, PhotosState>(
        bloc: getIt<PhotoBloc>(),
        builder: (context, PhotosState state) {
          if (state.isLoading) {
            return const PhotoShimmer();
          } else if (state.data != null) {
            final List<Photos> photoList = state.data ?? [];
            return ListView.builder(
              itemCount: photoList.length,
              itemBuilder: (context, index) {
                return PhotoWidget(photo: photoList[index]);
              },
            );
          } else {
            return CustomErrorWidget(errorMessage: state.error!);
          }
        },
        listener: (context, PhotosState state) {
          if (state.error != null) {
            SnackbarUtils.showSnackbar(context, "Something went wrong!");
          }
        },
      ),
    );
  }
}
