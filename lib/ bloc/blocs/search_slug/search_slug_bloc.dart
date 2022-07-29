import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whisky_hunter/%20bloc/blocs/auction/aution_state.dart';
import 'package:whisky_hunter/%20bloc/blocs/search_slug/search_slug_event.dart';
import 'package:whisky_hunter/src/data/model/auction_data_model.dart';
import 'search_slug_state.dart';

class SearchSlugBloc extends Bloc<SearchSlugEvent, SearchSlugState> {
  SearchSlugBloc({required this.dio}) : super(const SearchSlugState()) {
    on<GetSLugList>(_onGetSearch);
  }
  final Dio dio;

  Future<void> _onGetSearch(
      GetSLugList event, Emitter<SearchSlugState> emit) async {
    try {
      if (state.status == AuctionStatus.initial) {
        final search = await _fetchSearch();
        return emit(state.copyWith(
          status: AuctionStatus.success,
          search: search,
        ));
      }
    } catch (_) {
      emit(state.copyWith(status: AuctionStatus.failure));
    }
  }

  Future<List<AuctionDataModel>> _fetchSearch() async {
    final response =
        await dio.get('https://whiskyhunter.net/api/auction_data/bonhams');
    if (response.statusCode == 200) {
      var getData = response.data as List;
      var slug = getData.map((e) => AuctionDataModel.fromJson(e)).toList();
      return slug;
    }
    throw Exception('faild to fecth data');
  }
}

//search
//  Response response =
//         await _dio.get(');
//     if (response.statusCode == 200) {
//       var getData = response.data as List;
//       slugs = getData.map((e) => AuctionDataModel.fromJson(e)).toList();
//       if (slug != null) {
//         slugs = slugs
//             .where((element) => element.allAuctionsLotsCount
//                 .toString()
//                 .toLowerCase()
//                 .contains((slug.toLowerCase())))
//             .toList();
//       } else if (slug == null) {
//         slugs = getData.map((e) => AuctionDataModel.fromJson(e)).toList();
//       }
//     } else {
//       throw Exception('Failded to load data');
//     }
//     return slugs;
//   }