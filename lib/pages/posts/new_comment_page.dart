import 'package:demo_revised_project/appbar/custom_appbar.dart';
import 'package:demo_revised_project/bloc/comment/comment_bloc.dart';
import 'package:demo_revised_project/bloc/comment/comment_event.dart';
import 'package:demo_revised_project/bloc/comment/comment_state.dart';
import 'package:demo_revised_project/dependency_injection.dart';
import 'package:demo_revised_project/models/post/post.dart';
import 'package:demo_revised_project/utils/color_util.dart';
import 'package:demo_revised_project/utils/snackbar_util.dart';
import 'package:demo_revised_project/utils/style_util.dart';
import 'package:demo_revised_project/widgets/custom_circular_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewCommentPage extends StatefulWidget {
  final Post post;
  const NewCommentPage({super.key, required this.post});

  @override
  State<NewCommentPage> createState() => _NewCommentPageState();
}

class _NewCommentPageState extends State<NewCommentPage> {
  TextEditingController commentController = TextEditingController();

  handlePostComment() {
    if (commentController.text.isEmpty) {
      SnackbarUtils.showSnackbar(context, "Please provide your comment");

      return;
    }
    Map<String, dynamic>? map = {};
    map['userId'] = 1;
    map['comments'] = commentController.text;
    getIt<CommentsBloc>().add(PostNewComment(widget.post.id!, map));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppbar(
        title: "Post a comment",
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: BlocConsumer<CommentsBloc, CommentsState>(
          bloc: getIt<CommentsBloc>(),
          builder: (context, CommentsState state) {
            return Stack(
              children: [
                SingleChildScrollView(
                  child: Column(
                    children: [
                      TextFormField(
                        controller: commentController,
                        maxLines: 5,
                        maxLength: 150,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          focusColor: ColorUtil.colorOrange,
                          hintStyle: StyleUtil.style14Grey,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                            borderSide: const BorderSide(
                              color: ColorUtil.colorGrey,
                              width: 1.0,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                            borderSide: const BorderSide(
                              color: ColorUtil.colorOrange,
                              width: 2.0,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                            borderSide: const BorderSide(
                              color: ColorUtil.colorGrey,
                              width: 1.0,
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          handlePostComment();
                        },
                        child: Container(
                          width: double.infinity,
                          margin: const EdgeInsets.symmetric(vertical: 16),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 24.0, vertical: 16.0),
                          decoration: BoxDecoration(
                            color: ColorUtil.colorOrange,
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          child: const Center(
                            child: Text(
                              "Submit",
                              style: StyleUtil.style14White,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                if (state.isLoading) const CustomCircularIndicator()
              ],
            );
          },
          listener: (context, CommentsState state) {
            if (state.isCommentPosted) {
              SnackbarUtils.showSnackbar(
                  context, "Your comment has been posted successfully");
              Navigator.pop(context);
            } else if (state.error != null) {
              SnackbarUtils.showSnackbar(context, state.error!);
            }
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    commentController.dispose();
    super.dispose();
  }
}
