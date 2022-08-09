// import 'package:equatable/equatable.dart';

// abstract class SearchSlugEvent extends Equatable {
//   const SearchSlugEvent();
// }

// class GetSLugList extends SearchSlugEvent {
//   final String slug;
//   const GetSLugList({required this.slug});
//   @override
//   List<Object> get props => [slug];
// }

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whisky_hunter/%20bloc/blocs/search_slug/search_slug_state.dart';

import '../../../dio/dio.dart';

class SearchCubit extends Cubit<SearchSlugState> {
  final Dio dio;
  SearchCubit({required this.dio}) : super(SearchEmpty());

  Future<void> getSearchList(String slug) async {
    if (slug.isEmpty) {
      return emit(SearchEmpty());
    }
    emit(SearchLoading());
    try {
      final search = await DioClient().fetchSearch(slug);
      emit(SearchSuccess(search));
    } catch (_) {
      emit(SearchError(_.toString()));
    }
  }
}
