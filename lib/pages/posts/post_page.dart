import 'package:demo_revised_project/bloc/post/post_bloc.dart';
import 'package:demo_revised_project/bloc/post/post_event.dart';
import 'package:demo_revised_project/bloc/post/post_state.dart';
import 'package:demo_revised_project/dependency_injection.dart';
import 'package:demo_revised_project/models/post/post.dart';
import 'package:demo_revised_project/models/user/user.dart';
import 'package:demo_revised_project/pages/posts/post_widget.dart';
import 'package:demo_revised_project/shimmer/post_shimmer.dart';
import 'package:demo_revised_project/utils/snackbar_util.dart';
import 'package:demo_revised_project/widgets/custom_error_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostPage extends StatefulWidget {
  final User user;
  const PostPage({super.key, required this.user});

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  @override
  void initState() {
    getIt<PostBloc>().add(FetchUserPostsList(widget.user.id!));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<PostBloc, PostState>(
        bloc: getIt<PostBloc>(),
        builder: (context, PostState state) {
          if (state.isLoading) {
            return const PostShimmer();
          } else if (state.data != null) {
            final List<Post> postList = state.data ?? [];
            return ListView.builder(
              itemCount: postList.length,
              itemBuilder: (context, index) {
                return PostWidget(post: postList[index]);
              },
            );
          } else {
            return CustomErrorWidget(errorMessage: state.error!);
          }
        },
        listener: (context, PostState state) {
          if (state.error != null) {
            SnackbarUtils.showSnackbar(context, "Something went wrong!");
          }
        },
      ),
    );
  }
}
