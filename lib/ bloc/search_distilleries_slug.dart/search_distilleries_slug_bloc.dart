import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:whisky_hunter/resource/repository/api_repositoy_distilleries_slug.dart';

import 'search_distilleries_slug_event.dart';
import 'search_distilleries_slug_state.dart';

class DistilleriesSlugBloc
    extends Bloc<DistilleriesSlugEvent, DistilleriesSlugState> {
  DistilleriesSlugBloc() : super(DistilleriesSlugInitial()) {
    final ApiRepositoryDistilleriesSlug apiRepositoryDistilleriesSlug =
        ApiRepositoryDistilleriesSlug();
    on<GetSLugList1>((event, emit) async {
      try {
        emit(DistilleriesSlugLoading());
        final slugList2 =
            await apiRepositoryDistilleriesSlug.fetchSlugList(event.slug);
        emit(DistilleriesSlugLoaded(slugList2));
      } on NetWorkError {
        emit(const DistilleriesSlugError('Failed to fetch data'));
      }
    });
  }
}
