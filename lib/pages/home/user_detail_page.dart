import 'package:demo_revised_project/appbar/custom_appbar.dart';
import 'package:demo_revised_project/bloc/post/post_bloc.dart';
import 'package:demo_revised_project/bloc/post/post_event.dart';
import 'package:demo_revised_project/dependency_injection.dart';
import 'package:demo_revised_project/models/user/user.dart';
import 'package:demo_revised_project/pages/album/album_page.dart';
import 'package:demo_revised_project/pages/posts/post_page.dart';
import 'package:demo_revised_project/pages/todos/todos_page.dart';
import 'package:demo_revised_project/utils/color_util.dart';
import 'package:flutter/material.dart';

class UserDetailPage extends StatefulWidget {
  final User user;
  const UserDetailPage({super.key, required this.user});

  @override
  State<UserDetailPage> createState() => _UserDetailPageState();
}

class _UserDetailPageState extends State<UserDetailPage> {
  final PageStorageBucket bucket = PageStorageBucket();
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: CustomAppbar(
          title: "${widget.user.name}",
          showBackButton: true,
          tabBar: TabBar(
            indicatorColor: ColorUtil.colorOrange,
            labelColor: ColorUtil.colorOrange,
            overlayColor: MaterialStateProperty.all<Color>(
                ColorUtil.colorOrange.withOpacity(0.1)),
            tabs: const [
              Tab(text: 'Posts'),
              Tab(text: 'Albums'),
              Tab(text: 'Todos'),
            ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: TabBarView(
            children: [
              PostPage(user: widget.user),
              AlbumPage(user: widget.user),
              TodosPage(user: widget.user),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    getIt<PostBloc>().add((ClearCachedPosts(userId: widget.user.id!)));
    super.dispose();
  }
}
