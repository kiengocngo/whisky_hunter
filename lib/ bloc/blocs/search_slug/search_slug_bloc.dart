// import 'package:dio/dio.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:whisky_hunter/%20bloc/blocs/auction/aution_state.dart';
// import 'package:whisky_hunter/%20bloc/blocs/search_slug/search_slug_event.dart';
// import 'package:whisky_hunter/dio/dio.dart';
// import 'search_slug_state.dart';

// class SearchSlugBloc extends Bloc<SearchSlugEvent, SearchSlugState> {
//   SearchSlugBloc({required this.dio})
//       : super(const SearchSlugState(error: '')) {
//     on<GetSLugList>(_onGetSearch);
//   }
//   final Dio dio;

//   Future<void> _onGetSearch(
//       GetSLugList event, Emitter<SearchSlugState> emit) async {
//     try {
//       if (state.status == AuctionStatus.initial) {
//         final search = await DioClient().fetchSearch(event.slug);
//         return emit(state.copyWith(
//           status: AuctionStatus.success,
//           search: search,
//         ));
//       }
//     } catch (_) {
//       emit(
//         state.copyWith(
//           status: AuctionStatus.failure,
//           error: _.toString(),
//         ),
//       );
//     }
//   }
// }
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whisky_hunter/%20bloc/blocs/search_slug/search_slug_event.dart';
import 'package:whisky_hunter/%20bloc/blocs/search_slug/search_slug_state.dart';
import 'package:whisky_hunter/dio/config_dio.dart';

class SearchSlugBloc extends Bloc<SearchSlugEvent, SearchSlugState> {
  SearchSlugBloc({required this.dio}) : super(SearchEmpty()) {
    on<GetSLugList>(_onGetSlugList);
  }

  final Dio dio;

  Future<void> _onGetSlugList(
      GetSLugList event, Emitter<SearchSlugState> emit) async {
    final searchName = event.slug;
    if (searchName.isEmpty) return emit(SearchEmpty());
    emit(SearchLoading());
    try {
      final search = await DioClient().fetchSearch(searchName);
      emit(SearchSuccess(search));
    } catch (error) {
      emit(error is SearchError
          ? SearchError(error.toString())
          : const SearchError('Something went wrong'));
    }
  }
}
