import 'package:demo_revised_project/appbar/custom_appbar.dart';
import 'package:demo_revised_project/bloc/user/user_bloc.dart';
import 'package:demo_revised_project/bloc/user/user_event.dart';
import 'package:demo_revised_project/bloc/user/user_state.dart';
import 'package:demo_revised_project/dependency_injection.dart';
import 'package:demo_revised_project/models/user/user.dart';
import 'package:demo_revised_project/pages/home/user_widget.dart';
import 'package:demo_revised_project/shimmer/user_shimmer.dart';
import 'package:demo_revised_project/utils/snackbar_util.dart';
import 'package:demo_revised_project/widgets/custom_error_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<void> _onRefresh() async {
    getIt<UserBloc>().add(FetchUserList());
  }

  @override
  void initState() {
    getIt<UserBloc>().add(FetchUserList());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const CustomAppbar(title: "Home", showBackButton: false),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: RefreshIndicator(
                onRefresh: _onRefresh,
                child: BlocConsumer<UserBloc, UserState>(
                  bloc: getIt<UserBloc>(),
                  builder: (context, UserState state) {
                    if (state.isLoading) {
                      return const UserShimmer();
                    } else if (state.data != null) {
                      final List<User> userList = state.data ?? [];
                      return ListView.builder(
                        padding: EdgeInsets.zero,
                        itemCount: userList.length,
                        itemBuilder: (context, index) {
                          return UserWidget(user: userList[index]);
                        },
                      );
                    } else {
                      return CustomErrorWidget(errorMessage: state.error!);
                    }
                  },
                  listener: (context, UserState state) {
                    if (state.error != null) {
                      SnackbarUtils.showSnackbar(
                          context, "Something went wrong!");
                    }
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
