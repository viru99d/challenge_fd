import 'package:challenge_fd/core/config/routes.dart';
import 'package:challenge_fd/core/constants.dart';
import 'package:challenge_fd/core/spacing.dart';
import 'package:challenge_fd/modules/home/domain/entity/post_entity.dart';
import 'package:challenge_fd/modules/home/presenter/bloc/bloc.dart';
import 'package:challenge_fd/widgets/primary_button.dart';
import 'package:challenge_fd/widgets/primary_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:fluttertoast/fluttertoast.dart';

part '_sections/create_post.dart';
part '_sections/empty_posts.dart';
part '_sections/loaded_posts.dart';

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
        onPressed: () {
          homeBloc.add(ClearTextFieldEvent());
          createPost(
            context,
            homeBloc: homeBloc,
          );
        },
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

            if (state is SavedPostState) {
              Modular.to.pop();
              Fluttertoast.showToast(
                msg: Constants.text.savePostSuccess,
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.TOP,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.green,
                fontSize: 16.0,
              );
              homeBloc.add(GetPostsEvent());
            }
          },
          child: BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              if (state is LoadingPostState || state is SavingPostState) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is EmptyPostState) {
                return EmptyState(homeBloc: homeBloc);
              }
              final posts = state.model.posts;
              return LoadedPosts(
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
