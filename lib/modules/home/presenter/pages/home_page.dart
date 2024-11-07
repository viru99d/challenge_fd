import 'package:challenge_fd/core/config/routes.dart';
import 'package:challenge_fd/core/constants.dart';
import 'package:challenge_fd/core/spacing.dart';
import 'package:challenge_fd/modules/home/domain/entity/post_entity.dart';
import 'package:challenge_fd/modules/home/presenter/bloc/bloc.dart';
import 'package:challenge_fd/widgets/primary_button.dart';
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
        title: Text(
          Constants.text.homeTitle,
          style: const TextStyle(
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
              } else if (state is EmptyPostState) {
                return EmptyState(homeBloc: homeBloc);
              }
              final posts = state.model.posts;
              return LoadedState(
                homeBloc: homeBloc,
                posts: posts,
              );
            },
          ),
        ),
      ),
    );
  }
}

class LoadedState extends StatelessWidget {
  const LoadedState({
    super.key,
    required this.homeBloc,
    required this.posts,
  });

  final HomeBloc homeBloc;
  final List<PostEntity> posts;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async => homeBloc.add(
        GetPostsEvent(),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: Spacing.md,
              right: Spacing.md,
              top: Spacing.md,
            ),
            child: TextField(
              onChanged: (query) {
                homeBloc.add(SearchPostsEvent(query));
              },
              decoration: InputDecoration(
                labelText: Constants.text.searchLabel,
                border: const OutlineInputBorder(),
              ),
            ),
          ),
          VerticalSpace.xs,
          Expanded(
            child: Scrollbar(
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
                        '${post.userId}- ${post.title}',
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
            ),
          ),
        ],
      ),
    );
  }
}

class EmptyState extends StatelessWidget {
  const EmptyState({
    super.key,
    required this.homeBloc,
  });

  final HomeBloc homeBloc;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            Constants.text.homePageErrorMessage,
            style: const TextStyle(fontWeight: FontWeight.w700),
          ),
          PrimaryButton(
            onPressed: () => homeBloc.add(GetPostsEvent()),
            title: Constants.text.reload,
          )
        ],
      ),
    );
  }
}
