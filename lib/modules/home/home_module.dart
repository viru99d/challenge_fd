import 'package:challenge_fd/modules/home/data/repository_impl/home_repository_impl.dart';
import 'package:challenge_fd/modules/home/domain/repository/home_repository.dart';
import 'package:challenge_fd/modules/home/domain/use_cases/get_posts_use_case.dart';
import 'package:challenge_fd/modules/home/presenter/bloc/bloc.dart';
import 'package:challenge_fd/modules/home/presenter/pages/home_page.dart';
import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';

class HomeModule extends Module {
  @override
  List<Bind> get binds => [
        Bind.factory<HomeRepository>(
          (i) => HomeRepositoryImpl(
            i.get<Dio>(),
          ),
        ),
        Bind.factory(
          (i) => GetPostsUseCase(
            i.get<HomeRepository>(),
          ),
        ),
        Bind.factory(
          (i) => HomeBloc(
            i.get<GetPostsUseCase>(),
          ),
        ),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          Modular.initialRoute,
          child: (context, args) {
            return HomePage(
              homeBloc: Modular.get<HomeBloc>(),
            );
          },
        ),
      ];
}
