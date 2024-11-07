part of '../home_page.dart';

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
