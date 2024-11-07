import 'package:challenge_fd/core/config/routes.dart';
import 'package:challenge_fd/core/constants.dart';
import 'package:challenge_fd/modules/home/presenter/bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:fluttertoast/fluttertoast.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
    required this.homeBloc,
  });

  final HomeBloc homeBloc;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      appBar: AppBar(
        title: const Text(
          'Posts',
          style: TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: Colors.orange,
        centerTitle: true,
        actions: [
          GestureDetector(
            onTap: () => homeBloc.add(
              LogOutEvent(),
            ),
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(
                Icons.logout,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
      body: BlocProvider(
        create: (context) => homeBloc
          ..add(
            GetPostsEvent(),
          ),
        child: BlocListener<HomeBloc, HomeState>(
          listener: (context, state) {
            if (state is ErrorState) {
              Fluttertoast.showToast(
                msg: state.errorMessage,
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.TOP,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                fontSize: 16.0,
              );
            }

            if (state is UnloggedState) {
              Modular.to.navigate(Routes.login);
            }
          },
          child: BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              if (state is LoadingPostState) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is LoadedPostState) {
                final posts = state.model.posts;
                return Scrollbar(
                  child: ListView.builder(
                    itemCount: posts.length,
                    itemBuilder: (context, index) {
                      final post = posts[index];

                      return Container(
                        margin: const EdgeInsets.only(
                          left: 10.0,
                          top: 10.0,
                          right: 10.0,
                        ),
                        padding: const EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.orange,
                        ),
                        child: ListTile(
                          title: Text(
                            '${post.id}- ${post.title}',
                            style: const TextStyle(
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          subtitle: Text(
                            post.body,
                            style: const TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              } else {
                return Center(
                  child: Text(
                    Constants.text.homePageErrorMessage,
                    style: const TextStyle(fontWeight: FontWeight.w700),
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
