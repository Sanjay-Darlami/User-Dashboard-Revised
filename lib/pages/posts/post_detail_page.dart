import 'package:demo_revised_project/appbar/custom_appbar.dart';
import 'package:demo_revised_project/bloc/comment/comment_bloc.dart';
import 'package:demo_revised_project/bloc/comment/comment_event.dart';
import 'package:demo_revised_project/bloc/comment/comment_state.dart';
import 'package:demo_revised_project/dependency_injection.dart';
import 'package:demo_revised_project/models/post/comments.dart';
import 'package:demo_revised_project/models/post/post.dart';
import 'package:demo_revised_project/pages/posts/comments_widget.dart';
import 'package:demo_revised_project/pages/posts/new_comment_page.dart';
import 'package:demo_revised_project/pages/posts/post_intro_card.dart';
import 'package:demo_revised_project/shimmer/post_shimmer.dart';
import 'package:demo_revised_project/widgets/custom_error_widget.dart';
import 'package:demo_revised_project/widgets/custom_floating_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostDetailPage extends StatefulWidget {
  final Post post;
  const PostDetailPage({super.key, required this.post});

  @override
  State<PostDetailPage> createState() => _PostDetailPageState();
}

class _PostDetailPageState extends State<PostDetailPage> {
  @override
  void initState() {
    getIt<CommentsBloc>().add(FetchPostComments(widget.post.id!));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        title: widget.post.title,
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              PostIntroCard(post: widget.post),
              const SizedBox(height: 20),
              BlocConsumer<CommentsBloc, CommentsState>(
                bloc: getIt<CommentsBloc>(),
                builder: (context, CommentsState state) {
                  if (state.isLoading) {
                    return const PostShimmer();
                  } else if (state.data != null) {
                    final List<Comments> commentsList = state.data ?? [];
                    return CommentsWidget(commentsList: commentsList);
                  } else {
                    return CustomErrorWidget(errorMessage: state.error!);
                  }
                },
                listener: (context, CommentsState state) {},
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: CustomFloatingButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => NewCommentPage(post: widget.post),
              ),
            );
          },
          icon: Icons.comment),
    );
  }
}
