import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whisky_hunter/%20bloc/search_distilleries_slug.dart/search_distilleries_slug_event.dart';
import 'package:whisky_hunter/%20bloc/search_distilleries_slug.dart/search_distilleries_slug_state.dart';
import 'package:whisky_hunter/resource/repository/api_repositoy_distilleries_slug.dart';

class DistilleriesSlugBloc extends Bloc<DistilleriesSlugEvent, DistilleriesSlugState>{
  DistilleriesSlugBloc() : super(DistilleriesSlugInitial()){
    final ApiRepositoryDistilleriesSlug _apiRepositoryDistilleriesSlug = ApiRepositoryDistilleriesSlug();
    on<GetSLugList1>((event, emit ) async {
      try {
        emit(DistilleriesSlugLoading());
        final slugList = await _apiRepositoryDistilleriesSlug.fetchSlugList(event.slug);
        emit(DistilleriesSlugLoaded(slugList));
        
      } on NetWorkError {
        emit(const DistilleriesSlugError('Failed to fetch data'));        
      }
    });
  }
}