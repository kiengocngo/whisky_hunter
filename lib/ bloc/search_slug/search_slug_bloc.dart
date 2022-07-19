import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whisky_hunter/%20bloc/search_slug/search_slug_event.dart';
import 'package:whisky_hunter/%20bloc/search_slug/search_slug_state.dart';
import 'package:whisky_hunter/resource/repository/api_repository_search_slug.dart';

class SearchSlugBloc extends Bloc<SearchSlugEvent, SearchSlugState>{
  SearchSlugBloc() : super(SearchSlugInitial()){
    final ApiRepositorySearchSlug _apiRepositorySearchSlug = ApiRepositorySearchSlug();
    on<GetSLugList>((event, emit ) async {
      try {
        emit(SearchSlugLoading());
        final slugList = await _apiRepositorySearchSlug.fetchSlugList();
        emit(SearchSlugLoaded(slugList));
        
      } on NetWorkError {
        emit(const SearchSlugError('Failed to fetch data'));        
      }
    });
  }
}