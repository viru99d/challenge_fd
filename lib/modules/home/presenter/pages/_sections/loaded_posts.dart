part of '../home_page.dart';

class LoadedPosts extends StatelessWidget {
  const LoadedPosts({
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
                      left: Spacing.sl,
                      top: Spacing.sl,
                      right: Spacing.sl,
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
