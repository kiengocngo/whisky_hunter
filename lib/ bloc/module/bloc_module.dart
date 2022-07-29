import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:whisky_hunter/%20bloc/blocs/auction/auction_bloc.dart';
import 'package:whisky_hunter/%20bloc/blocs/auction_info/auction_info_bloc.dart';
import 'package:whisky_hunter/%20bloc/blocs/authen/auth_bloc.dart';
import 'package:whisky_hunter/%20bloc/blocs/distilleries_info/distilleries_bloc.dart';
import 'package:whisky_hunter/%20bloc/blocs/search_slug/search_slug_bloc.dart';
import 'package:whisky_hunter/src/data/repo/auth_repository.dart';

final getIt = GetIt.instance;

class BlocModule {
  BlocModule._();

  static void provider() async {
    getIt.registerLazySingleton<AuctionBloc>(() => AuctionBloc(dio: Dio()));
    getIt.registerLazySingleton<AuctionInfoBloc>(
        () => AuctionInfoBloc(dio: Dio()));
    getIt.registerLazySingleton<DistilleriesInfoBloc>(
        () => DistilleriesInfoBloc(dio: Dio()));
    getIt.registerLazySingleton<SearchSlugBloc>(
        () => SearchSlugBloc(dio: Dio()));
    getIt.registerLazySingleton<AuthBloc>(
      () => AuthBloc(
        authRepository: AuthRepository(),
      ),
    );
  }
}
