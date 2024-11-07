part of '../home_page.dart';

void createPost(
  BuildContext context, {
  required HomeBloc homeBloc,
}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (BuildContext context) {
      return Padding(
        padding: EdgeInsets.only(
          left: Spacing.md,
          right: Spacing.md,
          top: Spacing.xl,
          bottom: MediaQuery.of(context).viewInsets.bottom + Spacing.xl,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              Constants.text.createNewPost,
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 20,
              ),
            ),
            VerticalSpace.sm,
            PrimaryTextField(
              title: Constants.text.savePostTitle,
              onChanged: (value) {
                homeBloc.add(
                  UpdateTitleEvent(value),
                );
              },
            ),
            VerticalSpace.sm,
            PrimaryTextField(
              title: Constants.text.savePostBody,
              onChanged: (value) {
                homeBloc.add(
                  UpdateBodyEvent(value),
                );
              },
            ),
            VerticalSpace.sm,
            PrimaryTextField(
              title: Constants.text.savePostUserId,
              keyboardType: TextInputType.number,
              onChanged: (value) {
                homeBloc.add(
                  UpdateUserIdEvent(
                    int.parse(value),
                  ),
                );
              },
            ),
            VerticalSpace.md,
            PrimaryButton(
              onPressed: () => homeBloc.add(SavePostEvent()),
              title: Constants.text.savePostButton,
            )
          ],
        ),
      );
    },
  );
}
